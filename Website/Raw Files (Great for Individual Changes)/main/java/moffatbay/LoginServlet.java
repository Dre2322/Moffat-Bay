/*
Lookup Reservation Servlet - Alpha Team
Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh

Purpose:
This servlet handles the login functionality for the application. It processes the login form, alidates
the user's credentials by querying the database, and manages the session for the authenticated user.
If successful, it redirects the user to the specified page or the default home page. If the credentials are
invalid, it forwards the user back to the login page with an error message.
*/

package moffatbay;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String redirect = request.getParameter("redirect");  // 🔁 optional redirect path

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE email = ? AND pass = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, email);
                stmt.setString(2, PasswordUtil.hashPassword(password));
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        HttpSession session = request.getSession();
                        session.setAttribute("user_id", rs.getInt("user_id"));
                        session.setAttribute("first_name", rs.getString("first_name"));

                        // ✅ Redirect based on pending path or default to home
                        if (redirect != null && !redirect.isEmpty()) {
                            response.sendRedirect("ReservationServlet?action=" + redirect);
                        } else {
                            response.sendRedirect("index.jsp");
                        }
                    } else {
                        request.setAttribute("errorMessage", "Invalid email or password.");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Login failed.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
}
