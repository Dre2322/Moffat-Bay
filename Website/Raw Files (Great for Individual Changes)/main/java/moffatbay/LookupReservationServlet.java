/*
Lookup Reservation Servlet - Alpha Team
Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh

Purpose:
Allows users to look up their reservation using either a confirmation number or an email.
Performs a join between reservations and users to validate ownership and fetch reservation details.
 */

package moffatbay;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LookupReservationServlet")
public class LookupReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String confirmationNumber = request.getParameter("confirmationNumber");
        String email = request.getParameter("email");
        String sql;

        if ((confirmationNumber == null || confirmationNumber.trim().isEmpty()) &&
            (email == null || email.trim().isEmpty())) {
            request.setAttribute("error", "Please provide either a confirmation number or email.");
            request.getRequestDispatcher("lookup.jsp").forward(request, response);
            return;
        }
        
        //block to get the room name via either confirmation number or email
        try (Connection conn = DBConnection.getConnection()) {
        	PreparedStatement stmt;
        	
        	sql = """
        			SELECT rt.room_name
        			FROM reservations r
        			JOIN users u ON r.user_id = u.user_id
        			JOIN reservation_rooms rr ON r.reservation_id = rr.reservation_id
        			JOIN room_types rt ON rr.room_type_id = rt.room_type_id
        			WHERE r.confirmation_number = ? OR u.email = ?;
        			""";
        	stmt = conn.prepareStatement(sql);
        	stmt.setString(1, confirmationNumber);
        	stmt.setString(2, email);
        	
        	ResultSet rs = stmt.executeQuery();
        	
        	if (rs.next()) {
        		String roomName = rs.getString("room_name");
        		request.setAttribute("roomName", roomName);
        	}
        	
        	
        } catch (SQLException e) {
        	throw new ServletException("Database error while looking up reservation", e);
        }

        try (Connection conn = DBConnection.getConnection()) {
            //String sql;
            PreparedStatement stmt;

            if (confirmationNumber != null && !confirmationNumber.trim().isEmpty()) {
                // Lookup by confirmation number
                sql = """
                    SELECT r.*, u.email
                    FROM reservations r
                    JOIN users u ON r.user_id = u.user_id
                    WHERE r.confirmation_number = ?
                """;
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, confirmationNumber);
            } else {
                // Lookup most recent reservation by email
                sql = """
                    SELECT r.*, u.email
                    FROM reservations r
                    JOIN users u ON r.user_id = u.user_id
                    WHERE u.email = ?
                    ORDER BY r.created_at DESC
                    LIMIT 1
                """;
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, email);
            }

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    // If user submitted both, double check email matches too
                    String dbEmail = rs.getString("email");
                    if (email != null && !email.isEmpty() && !email.equalsIgnoreCase(dbEmail)) {
                        request.setAttribute("error", "Email does not match our records.");
                        request.getRequestDispatcher("lookup.jsp").forward(request, response);
                        return;
                    }

                    // Pass reservation data to summary page
                    request.setAttribute("confirmationNumber", rs.getString("confirmation_number"));
                    request.setAttribute("checkInDate", rs.getString("check_in_date"));
                    request.setAttribute("checkOutDate", rs.getString("check_out_date"));
                    request.setAttribute("numOfGuests", rs.getInt("num_guests"));
                    request.setAttribute("totalCost", rs.getDouble("total_price"));

                    RequestDispatcher dispatcher = request.getRequestDispatcher("lookup.jsp");
                    dispatcher.forward(request, response);
                } else {
                    request.setAttribute("error", "No reservation found.");
                    request.getRequestDispatcher("lookup.jsp").forward(request, response);
                }
            }

        } catch (SQLException e) {
            throw new ServletException("Database error while looking up reservation", e);
        }
    }
}
