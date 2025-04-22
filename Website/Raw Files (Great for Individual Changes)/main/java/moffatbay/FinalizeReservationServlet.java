/* Finalize Reservation Servlet Test Alpha Team
   Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh */

package moffatbay;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moffatbay.DBConnection;

@WebServlet("/FinalizeReservationServlet")
public class FinalizeReservationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get reservation details from the form (passed via request)
        String confirmationNumber = request.getParameter("confirmationNumber");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String roomDetails = request.getParameter("roomDetails");
        String numOfGuests = request.getParameter("numOfGuests");
        String totalCost = request.getParameter("totalCost");

        // Database interaction to store reservation data
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Establish database connection
            conn = DBConnection.getConnection();

            // Insert the reservation details into the reservations table
            String sql = "INSERT INTO reservations (confirmation_number, start_date, end_date, room_details, num_of_guests, total_cost) "
                    + "VALUES (?, ?, ?, ?, ?, ?)";

            stmt = conn.prepareStatement(sql);
            stmt.setString(1, confirmationNumber);
            stmt.setString(2, startDate);
            stmt.setString(3, endDate);
            stmt.setString(4, roomDetails);
            stmt.setInt(5, Integer.parseInt(numOfGuests));  // Assuming numOfGuests is an integer
            stmt.setDouble(6, Double.parseDouble(totalCost));  // Assuming totalCost is a decimal

            // Execute the update
            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                // Successfully inserted the reservation into the database
                // Redirect to the confirmation page
                response.sendRedirect("thankyou.jsp?confirmationNumber=" + confirmationNumber);
            } else {
                // If insertion fails, show error
                request.setAttribute("errorMessage", "Error: Reservation could not be completed. Please try again.");
                request.getRequestDispatcher("/reservationSummary.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/reservationSummary.jsp").forward(request, response);
        } finally {
            // Close resources
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
