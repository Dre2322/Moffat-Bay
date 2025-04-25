/*
 * Reservation Servlet Page - Alpha Team
 * Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh
 *
 * Purpose:
 * This servlet handles reservation flow:
 * - selectRoom: fetches available room types for given dates
 * - confirmReservation: finalizes reservation, calculates cost, saves to DB
 * - editReservation: reloads form with previous data for modification
 *
 * Now integrates with the normalized `reservation_rooms` table and uses `java.time.LocalDate`.
 */

package moffatbay;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import moffatbay.DBConnection;

@WebServlet("/ReservationServlet")
public class ReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        switch (action) {
	        case "selectRoom" -> handleSelectRoom(request, response);
	        case "confirmReservation" -> handleConfirmReservation(request, response);
	        case "editReservation" -> handleEditReservation(request, response);
	        default -> response.sendRedirect("reservation.jsp");
        }
    }

    private void handleSelectRoom(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        HttpSession session = request.getSession();
        session.setAttribute("pendingReservation_startDate", startDate);
        session.setAttribute("pendingReservation_endDate", endDate);

        List<HashMap<String, String>> availableRooms = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {
            String sql = """
                    SELECT DISTINCT rt.room_type_id, rt.room_name, rt.price_per_night
                    FROM room_types rt
                    JOIN reservation_rooms r ON rt.room_type_id = r.room_type_id
                    WHERE r.reservation_room_id NOT IN (
                        SELECT reservation_room_id FROM reservation_rooms rr
                        JOIN reservations res ON rr.reservation_id = res.reservation_id
                        WHERE NOT (res.check_out_date < ? OR res.check_in_date > ?)
                    )
                """;

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, startDate);
                stmt.setString(2, endDate);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    HashMap<String, String> room = new HashMap<>();
                    room.put("room_type_id", rs.getString("room_type_id"));
                    room.put("room_name", rs.getString("room_name"));
                    room.put("price_per_night", rs.getString("price_per_night"));
                    availableRooms.add(room);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);
        request.setAttribute("availableRooms", availableRooms);
        request.getRequestDispatcher("room.jsp").forward(request, response);
    }

    private void handleConfirmReservation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("user_id");

        String startDate = Optional.ofNullable(request.getParameter("startDate"))
                .orElse((String) session.getAttribute("pendingReservation_startDate"));
        String endDate = Optional.ofNullable(request.getParameter("endDate"))
                .orElse((String) session.getAttribute("pendingReservation_endDate"));
        String numGuests = request.getParameter("numGuests");

        String[] selectedRoomTypeIds = request.getParameterValues("roomTypeId");

        if (selectedRoomTypeIds == null || startDate == null || endDate == null) {
            request.setAttribute("errorMessage", "Reservation details incomplete.");
            request.getRequestDispatcher("reservation.jsp").forward(request, response);
            return;
        }

        double totalCost = 0;
        int totalRoomCount = 0;
        StringBuilder roomDetails = new StringBuilder();
        int generatedReservationId = 0;
        String confirmationNumber = null;

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false); // Start transaction

            String insertReservationSQL = """
                    INSERT INTO reservations (user_id, check_in_date, check_out_date, num_guests, special_requests, status, total_price)
                    VALUES (?, ?, ?, ?, '', 'Confirmed', 0)
                """;

            try (PreparedStatement ps = conn.prepareStatement(insertReservationSQL, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, userId);
                ps.setString(2, startDate);
                ps.setString(3, endDate);
                ps.setInt(4, Integer.parseInt(numGuests));
                ps.executeUpdate();

                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    generatedReservationId = rs.getInt(1);
                }
            }

            for (String roomTypeIdStr : selectedRoomTypeIds) {
                String countParam = request.getParameter("roomCount_" + roomTypeIdStr);
                if (countParam == null || countParam.equals("0")) continue;

                int roomTypeId = Integer.parseInt(roomTypeIdStr);
                int roomCount = Integer.parseInt(countParam);
                totalRoomCount += roomCount;

                String roomSQL = "SELECT room_name, price_per_night FROM room_types WHERE room_type_id = ?";
                try (PreparedStatement ps = conn.prepareStatement(roomSQL)) {
                    ps.setInt(1, roomTypeId);
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        String roomName = rs.getString("room_name");
                        double price = rs.getDouble("price_per_night");
                        long days = calculateDaysBetween(startDate, endDate);
                        double cost = price * roomCount * days;
                        totalCost += cost;

                        roomDetails.append(roomCount).append(" x ").append(roomName).append("<br>");

                        try (PreparedStatement insert = conn.prepareStatement(
                                "INSERT INTO mbay.reservation_rooms (reservation_id, room_type_id, room_count) VALUES (?, ?, ?)")) {
                            insert.setInt(1, generatedReservationId);
                            insert.setInt(2, roomTypeId);
                            insert.setInt(3, roomCount);
                            insert.executeUpdate();
                        }
                    }
                }
            }

            //This has been changed to reflect only one room per customer
            try (PreparedStatement update = conn.prepareStatement("""
                    UPDATE reservations
                    SET total_price = ?
                    WHERE reservation_id = ?
                """)) {
                update.setDouble(1, totalCost);
                //update.setInt(2, totalRoomCount);
                //update.setString(3, roomDetails.toString());
                //Formerly 4
                update.setInt(2, generatedReservationId);
                update.executeUpdate();
            }

            try (PreparedStatement getCN = conn.prepareStatement(
                    "SELECT confirmation_number FROM reservations WHERE reservation_id = ?")) {
                getCN.setInt(1, generatedReservationId);
                ResultSet rs = getCN.executeQuery();
                if (rs.next()) confirmationNumber = rs.getString("confirmation_number");
            }

            conn.commit();

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("reservation.jsp").forward(request, response);
            return;
        }

        request.setAttribute("checkInDate", startDate);
        request.setAttribute("checkOutDate", endDate);
        request.setAttribute("numOfGuests", numGuests);
        request.setAttribute("roomCount", totalRoomCount);
        request.setAttribute("roomDetails", roomDetails.toString());
        request.setAttribute("totalCost", String.format("%.2f", totalCost));
        request.setAttribute("confirmationNumber", confirmationNumber);

        request.getRequestDispatcher("ReservationSummary.jsp").forward(request, response);
    }

    private void handleEditReservation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);

        String startDate = request.getParameter("checkInDate");
        String endDate = request.getParameter("checkOutDate");
        String guests = request.getParameter("numGuests");

        session.setAttribute("pendingReservation_startDate", startDate);
        session.setAttribute("pendingReservation_endDate", endDate);
        session.setAttribute("pendingReservation_numGuests", guests);

        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);
        request.setAttribute("numGuests", guests);

        request.getRequestDispatcher("room.jsp").forward(request, response);
    }

    private long calculateDaysBetween(String start, String end) {
        try {
            LocalDate d1 = LocalDate.parse(start);
            LocalDate d2 = LocalDate.parse(end);
            return ChronoUnit.DAYS.between(d1, d2);
        } catch (Exception e) {
            return 0;
        }
    }
}
