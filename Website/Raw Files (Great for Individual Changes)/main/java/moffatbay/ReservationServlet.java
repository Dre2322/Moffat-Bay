/* Reservation Servlet Test Alpha Team
   Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh */

package moffatbay;

import java.io.IOException;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import moffatbay.DBConnection;

@WebServlet("/ReservationServlet")
public class ReservationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("selectRoom".equals(action)) {
            handleSelectRoom(request, response);
        } else if ("confirmReservation".equals(action)) {
            handleConfirmReservation(request, response);
        } else if ("editReservation".equals(action)) {
            handleEditReservation(request, response);
        } else {
            response.sendRedirect("reservation.jsp");
        }
    }

    private void handleSelectRoom(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");

        // Save pending dates to session in case user needs to log in
        session.setAttribute("pendingReservation_startDate", startDate);
        session.setAttribute("pendingReservation_endDate", endDate);

        // 🔒 Redirect to login if not logged in
        if (userId == null) {
            response.sendRedirect("login.jsp?redirect=selectRoom");
            return;
        }

        List<HashMap<String, String>> availableRooms = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT DISTINCT rooms.room_type_id, room_types.room_name, room_types.price_per_night " +
                         "FROM rooms " +
                         "JOIN room_types ON rooms.room_type_id = room_types.room_type_id " +
                         "WHERE rooms.room_id NOT IN (" +
                         "SELECT room_id FROM reservations WHERE NOT (check_out_date < ? OR check_in_date > ?))";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, startDate);
                stmt.setString(2, endDate);

                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        HashMap<String, String> room = new HashMap<>();
                        room.put("room_type_id", rs.getString("room_type_id"));
                        room.put("room_name", rs.getString("room_name"));
                        room.put("price_per_night", rs.getString("price_per_night"));
                        availableRooms.add(room);
                    }
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
        Integer userId = (session != null) ? (Integer) session.getAttribute("user_id") : null;

        String startDate = Optional.ofNullable(request.getParameter("startDate"))
                .orElse((String) session.getAttribute("pendingReservation_startDate"));
        String endDate = Optional.ofNullable(request.getParameter("endDate"))
                .orElse((String) session.getAttribute("pendingReservation_endDate"));
        String numGuests = request.getParameter("numGuests");

        String[] selectedRoomTypeIds = request.getParameterValues("roomTypeId");

        if (selectedRoomTypeIds == null || selectedRoomTypeIds.length == 0 || startDate == null || endDate == null) {
            request.setAttribute("errorMessage", "Missing reservation data. Please select at least one room type.");
            request.getRequestDispatcher("reservation.jsp").forward(request, response);
            return;
        }

        double totalCost = 0;
        int totalRoomCount = 0;
        int confirmationNumber = 0;
        StringBuilder roomDetails = new StringBuilder();

        try (Connection conn = DBConnection.getConnection()) {
            for (String roomTypeIdStr : selectedRoomTypeIds) {
                String roomCountStr = request.getParameter("roomCount_" + roomTypeIdStr);
                if (roomCountStr == null || roomCountStr.equals("0")) continue;

                int roomTypeId = Integer.parseInt(roomTypeIdStr);
                int roomCount = Integer.parseInt(roomCountStr);
                totalRoomCount += roomCount;

                String sql = "SELECT room_name, price_per_night FROM room_types WHERE room_type_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, roomTypeId);
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) {
                        String roomName = rs.getString("room_name");
                        double pricePerNight = rs.getDouble("price_per_night");
                        long daysBetween = calculateDaysBetween(startDate, endDate);
                        double cost = daysBetween * pricePerNight * roomCount;

                        totalCost += cost;
                        roomDetails.append(roomCount).append(" x ").append(roomName).append("<br>");

                        String insertSQL = "INSERT INTO reservations (user_id, room_type_id, check_in_date, check_out_date, num_guests, total_price, status) " +
                                           "VALUES (?, ?, ?, ?, ?, ?, ?)";
                        try (PreparedStatement insertStmt = conn.prepareStatement(insertSQL, Statement.RETURN_GENERATED_KEYS)) {
                            insertStmt.setInt(1, userId);
                            insertStmt.setInt(2, roomTypeId);
                            insertStmt.setString(3, startDate);
                            insertStmt.setString(4, endDate);
                            insertStmt.setInt(5, Integer.parseInt(numGuests));
                            insertStmt.setDouble(6, cost);
                            insertStmt.setString(7, "Confirmed");
                            insertStmt.executeUpdate();

                            ResultSet keys = insertStmt.getGeneratedKeys();
                            if (keys.next()) {
                                confirmationNumber = keys.getInt(1);
                            }
                        }
                    }
                }
            }
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Reservation failed: " + e.getMessage());
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

        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String numGuests = request.getParameter("numGuests");

        session.setAttribute("pendingReservation_startDate", startDate);
        session.setAttribute("pendingReservation_endDate", endDate);
        session.setAttribute("pendingReservation_numGuests", numGuests);

        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);
        request.setAttribute("numGuests", numGuests);

        List<HashMap<String, String>> availableRooms = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT DISTINCT rooms.room_type_id, room_types.room_name, room_types.price_per_night " +
                         "FROM rooms " +
                         "JOIN room_types ON rooms.room_type_id = room_types.room_type_id " +
                         "WHERE rooms.room_id NOT IN (" +
                         "SELECT room_id FROM reservations WHERE NOT (check_out_date < ? OR check_in_date > ?))";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, startDate);
                stmt.setString(2, endDate);
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        HashMap<String, String> room = new HashMap<>();
                        room.put("room_type_id", rs.getString("room_type_id"));
                        room.put("room_name", rs.getString("room_name"));
                        room.put("price_per_night", rs.getString("price_per_night"));
                        availableRooms.add(room);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("availableRooms", availableRooms);
        request.getRequestDispatcher("room.jsp").forward(request, response);
    }

    private long calculateDaysBetween(String startDate, String endDate) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date start = sdf.parse(startDate);
            java.util.Date end = sdf.parse(endDate);
            long diffInMillis = end.getTime() - start.getTime();
            return diffInMillis / (24 * 60 * 60 * 1000);
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
}
