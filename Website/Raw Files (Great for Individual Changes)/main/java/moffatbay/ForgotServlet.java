/*
Forgot Password Servlet - Alpha Team
Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh

Purpose:
This servlet handles the "Forgot Password" functionality for the application. It receives an email address
submitted by the user, verifies if the email exists in the database, and generates a secure reset token.
If the email is found, a token is saved in the database for future verification and the user is notified that
reset instructions have been sent. If the email is not found, an error message is shown.
*/

package moffatbay;

import java.io.IOException;
import java.sql.*;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ForgotServlet")
public class ForgotServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");

        try (Connection conn = DBConnection.getConnection()) {
            String checkUserQuery = "SELECT * FROM users WHERE email = ?";
            PreparedStatement ps = conn.prepareStatement(checkUserQuery);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String token = UUID.randomUUID().toString();
                String updateToken = "UPDATE users SET reset_token = ?, token_expiration = DATE_ADD(NOW(), INTERVAL 1 HOUR) WHERE email = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateToken);
                updateStmt.setString(1, token);
                updateStmt.setString(2, email);
                updateStmt.executeUpdate();

                String resetLink = "reset.jsp?token=" + token;
                request.setAttribute("message", "Reset instructions sent to your email.<br><a href='" + resetLink + "'>Click here to reset your password</a>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred. Please try again later.");
        }

        request.getRequestDispatcher("forgot.jsp").forward(request, response);
    }
}
