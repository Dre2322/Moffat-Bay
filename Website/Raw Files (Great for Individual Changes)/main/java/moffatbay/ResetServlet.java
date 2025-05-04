/*
Reset Password Servlet - Alpha Team
Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh

Purpose:
This servlet handles password resets using a secure token sent to the user's email. It verifies that the
provided token is valid and has not expired, then updates the user's password in the database. After a
successful reset, it clears the token to prevent reuse and informs the user.
*/

package moffatbay;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.security.MessageDigest;

@WebServlet("/ResetServlet")
public class ResetServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String token = request.getParameter("token");
        String newPassword = request.getParameter("password");

        if (token == null || token.trim().isEmpty()) {
            request.setAttribute("error", "Invalid or missing token.");
            request.getRequestDispatcher("reset.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            // Verify the token and ensure it hasn't expired
            String query = "SELECT * FROM users WHERE reset_token = ? AND token_expiration > NOW()";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, token);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String email = rs.getString("email");

                // Hash the new password
                String hashedPassword = hashPassword(newPassword);

                // Update password and clear token
                String update = "UPDATE users SET pass = ?, reset_token = NULL, token_expiration = NULL WHERE email = ?";
                PreparedStatement updateStmt = conn.prepareStatement(update);
                updateStmt.setString(1, hashedPassword);
                updateStmt.setString(2, email);
                updateStmt.executeUpdate();

                request.setAttribute("message", "Password reset successful. You may now log in.");
            } else {
                request.setAttribute("error", "Reset token is invalid or has expired.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while resetting the password.");
        }

        request.getRequestDispatcher("reset.jsp").forward(request, response);
    }

    // Simple SHA-256 hash for passwords (production should use bcrypt or similar)
    private String hashPassword(String password) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hashBytes = md.digest(password.getBytes());
        StringBuilder sb = new StringBuilder();
        for (byte b : hashBytes) sb.append(String.format("%02x", b));
        return sb.toString();
    }
}
