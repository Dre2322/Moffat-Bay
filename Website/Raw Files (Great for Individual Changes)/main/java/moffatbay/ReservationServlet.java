/*
Reservation Servlet Page - Alpha Team
Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh

Purpose:
This servlet manages the full lifecycle of room reservations for Moffat Bay Lodge.
- selectRoom: Determines room availability between a given check-in and check-out date.
- confirmReservation: Inserts or updates a reservation, calculates total cost, and stores room details.
- editReservation: Reloads room selection form for a prior reservation, supporting reservation modification.

This version uses normalized database tables (including reservation_rooms) and Java's LocalDate for date handling.
It also supports reservation editing by storing and checking a reservation ID in the session.
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

@WebServlet("/ReservationServlet")
public class ReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Handles form actions sent via POST request
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        switch (action) {
            case "selectRoom" -> handleSelectRoom(request, response); // Step 1: Check availability
            case "confirmReservation" -> handleConfirmReservation(request, response); // Step 2: Finalize reservation
            case "editReservation" -> handleEditReservation(request, response); // Edit flow trigger
            default -> response.sendRedirect("reservation.jsp");
        }
    }

    // Handles room availability lookup based on date range
    private void handleSelectRoom(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        // Store dates in session for continuity between steps
        HttpSession session = request.getSession();
        session.setAttribute("pendingReservation_startDate", startDate);
        session.setAttribute("pendingReservation_endDate", endDate);

        List<HashMap<String, String>> availableRooms = fetchAvailableRooms(startDate, endDate);

        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);
        request.setAttribute("availableRooms", availableRooms);
        request.getRequestDispatcher("room.jsp").forward(request, response);
    }

    // Confirms a reservation, either as a new insert or an update to an existing one
    private void handleConfirmReservation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("user_id");

        // Retrieve dates and guest count
        String startDate = Optional.ofNullable(request.getParameter("startDate"))
                .orElse((String) session.getAttribute("pendingReservation_startDate"));
        String endDate = Optional.ofNullable(request.getParameter("endDate"))
                .orElse((String) session.getAttribute("pendingReservation_endDate"));
        String numGuests = request.getParameter("numGuests");

        // Gather selected room IDs
        String[] selectedRoomTypeIds = request.getParameterValues("roomTypeId");

        // Validation check
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
            conn.setAutoCommit(false); // Begin transaction

            // Handle update if editing
            String editReservationId = (String) session.getAttribute("editReservationId");

            if (editReservationId != null) {
                generatedReservationId = Integer.parseInt(editReservationId);

                // Update reservation header
                try (PreparedStatement update = conn.prepareStatement("""
                        UPDATE reservations 
                        SET check_in_date = ?, check_out_date = ?, num_guests = ?, special_requests = '', status = 'Confirmed', total_price = 0
                        WHERE reservation_id = ?
                """)) {
                    update.setString(1, startDate);
                    update.setString(2, endDate);
                    update.setInt(3, Integer.parseInt(numGuests));
                    update.setInt(4, generatedReservationId);
                    update.executeUpdate();
                }

                // Clear old room associations
                try (PreparedStatement delete = conn.prepareStatement(
                        "DELETE FROM reservation_rooms WHERE reservation_id = ?")) {
                    delete.setInt(1, generatedReservationId);
                    delete.executeUpdate();
                }

                session.removeAttribute("editReservationId");

            } else {
                // Insert new reservation
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
            }

            // Loop over room types and insert into reservation_rooms
            for (String roomTypeIdStr : selectedRoomTypeIds) {
                String countParam = request.getParameter("roomCount_" + roomTypeIdStr);
                if (countParam == null || countParam.equals("0")) continue;

                int roomTypeId = Integer.parseInt(roomTypeIdStr);
                int roomCount = Integer.parseInt(countParam);
                totalRoomCount += roomCount;

                // Fetch room info and compute cost
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

                        // Insert into join table
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

            // Update final total in reservation
            try (PreparedStatement update = conn.prepareStatement("""
                    UPDATE reservations
                    SET total_price = ?
                    WHERE reservation_id = ?
                """)) {
                update.setDouble(1, totalCost);
                update.setInt(2, generatedReservationId);
                update.executeUpdate();
            }

            // Retrieve confirmation number for display
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

        // Set reservation details for JSP display
        request.setAttribute("checkInDate", startDate);
        request.setAttribute("checkOutDate", endDate);
        request.setAttribute("numOfGuests", numGuests);
        request.setAttribute("roomCount", totalRoomCount);
        request.setAttribute("roomDetails", roomDetails.toString());
        request.setAttribute("totalCost", String.format("%.2f", totalCost));
        request.setAttribute("confirmationNumber", confirmationNumber);

        request.getRequestDispatcher("ReservationSummary.jsp").forward(request, response);
    }

    // Loads a reservation's existing data into session for editing
    private void handleEditReservation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String startDate = request.getParameter("checkInDate");
        String endDate = request.getParameter("checkOutDate");
        String guests = request.getParameter("numGuests");
        String reservationId = request.getParameter("reservationId");

        HttpSession session = request.getSession(true);
        session.setAttribute("pendingReservation_startDate", startDate);
        session.setAttribute("pendingReservation_endDate", endDate);
        session.setAttribute("pendingReservation_numGuests", guests);
        session.setAttribute("editReservationId", reservationId);

        List<HashMap<String, String>> availableRooms = fetchAvailableRooms(startDate, endDate);

        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);
        request.setAttribute("numGuests", guests);
        request.setAttribute("availableRooms", availableRooms);

        request.getRequestDispatcher("room.jsp").forward(request, response);
    }

    // Queries and returns a list of available room types within the provided date range
    private List<HashMap<String, String>> fetchAvailableRooms(String startDate, String endDate) {
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
        return availableRooms;
    }

    // Calculates the number of nights between check-in and check-out
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
