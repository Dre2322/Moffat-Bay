/*
 * Lookup Reservation Servlet - Alpha Team
 * Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh
 *
 * Purpose:
 * Allows users to look up their reservation using either a confirmation number or an email.
 * Performs a join between reservations and users to validate ownership and fetch reservation details,
 * and displays all room types associated with each reservation.
 */

package moffatbay;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

/**
 * Servlet for handling reservation lookups based on confirmation number or email.
 * Allows users to search for individual or all reservations and view booking details.
 */
@WebServlet("/LookupReservationServlet")
public class LookupReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * Processes POST requests from the lookup form.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String confirmationNumber = request.getParameter("confirmationNumber");
        String email = request.getParameter("email");
        String sql;

        // Require at least one input to proceed
        if ((confirmationNumber == null || confirmationNumber.trim().isEmpty()) &&
            (email == null || email.trim().isEmpty())) {
            request.setAttribute("error", "Please provide either a confirmation number or email.");
            request.getRequestDispatcher("lookup.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement stmt;

            // Case 1: Lookup by Confirmation Number (and optional email match)
            if (confirmationNumber != null && !confirmationNumber.trim().isEmpty()) {
                sql = """
                    SELECT r.confirmation_number, u.email, r.check_in_date, r.check_out_date,
                           r.num_guests, r.total_price,
                           GROUP_CONCAT(rt.room_name SEPARATOR ', ') AS room_names
                    FROM reservations r
                    JOIN users u ON r.user_id = u.user_id
                    JOIN reservation_rooms rr ON r.reservation_id = rr.reservation_id
                    JOIN room_types rt ON rr.room_type_id = rt.room_type_id
                    WHERE r.confirmation_number = ?
                    GROUP BY r.reservation_id
                """;
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, confirmationNumber);

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        // If email was provided, validate it matches
                        String dbEmail = rs.getString("email");
                        if (email != null && !email.isEmpty() && !email.equalsIgnoreCase(dbEmail)) {
                            request.setAttribute("error", "Email does not match our records.");
                            request.getRequestDispatcher("lookup.jsp").forward(request, response);
                            return;
                        }

                        // Build single reservation result
                        Map<String, Object> res = new HashMap<>();
                        res.put("confirmationNumber", rs.getString("confirmation_number"));
                        res.put("checkInDate", rs.getString("check_in_date"));
                        res.put("checkOutDate", rs.getString("check_out_date"));
                        res.put("numOfGuests", rs.getInt("num_guests"));
                        res.put("totalCost", rs.getDouble("total_price"));
                        res.put("roomName", rs.getString("room_names"));

                        List<Map<String, Object>> reservations = new ArrayList<>();
                        reservations.add(res);

                        request.setAttribute("reservations", reservations);
                        request.getRequestDispatcher("lookup.jsp").forward(request, response);
                        return;
                    } else {
                        // No reservation matched the confirmation number
                        request.setAttribute("error", "No reservation found.");
                        request.getRequestDispatcher("lookup.jsp").forward(request, response);
                    }
                }

            // Case 2: Lookup all reservations by Email
            } else {
                sql = """
                    SELECT r.confirmation_number, u.email, r.check_in_date, r.check_out_date,
                           r.num_guests, r.total_price,
                           GROUP_CONCAT(rt.room_name SEPARATOR ', ') AS room_names
                    FROM reservations r
                    JOIN users u ON r.user_id = u.user_id
                    JOIN reservation_rooms rr ON r.reservation_id = rr.reservation_id
                    JOIN room_types rt ON rr.room_type_id = rt.room_type_id
                    WHERE u.email = ?
                    GROUP BY r.reservation_id
                    ORDER BY r.created_at DESC
                """;
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, email);

                try (ResultSet rs = stmt.executeQuery()) {
                    List<Map<String, Object>> reservations = new ArrayList<>();

                    while (rs.next()) {
                        Map<String, Object> res = new HashMap<>();
                        res.put("confirmationNumber", rs.getString("confirmation_number"));
                        res.put("checkInDate", rs.getString("check_in_date"));
                        res.put("checkOutDate", rs.getString("check_out_date"));
                        res.put("numOfGuests", rs.getInt("num_guests"));
                        res.put("totalCost", rs.getDouble("total_price"));
                        res.put("roomName", rs.getString("room_names"));
                        reservations.add(res);
                    }

                    // If no results found, inform user
                    if (reservations.isEmpty()) {
                        request.setAttribute("error", "No reservations found.");
                    } else {
                        request.setAttribute("reservations", reservations);
                    }

                    request.getRequestDispatcher("lookup.jsp").forward(request, response);
                }
            }

        } catch (SQLException e) {
            // Handle and log database-related exceptions
            throw new ServletException("Database error while looking up reservations", e);
        }
    }
}
