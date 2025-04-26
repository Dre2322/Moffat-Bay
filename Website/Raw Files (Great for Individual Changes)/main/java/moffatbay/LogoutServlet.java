/* Logout Page Servlet Alpha Team
Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh
    
Purpose:
This servlet handles user logout functionality. When the user logs out, the session is invalidated to clear the
user’s session data. After invalidating the session, the user is redirected to the login page (`login.jsp`).
This ensures that the user is logged out securely and is no longer able to access restricted areas until they log in again.
    */
package moffatbay;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) session.invalidate();
        response.sendRedirect("login.jsp");
    }
}
//<form method="post" action="LogoutServlet">
//</form>
//<% session.setAttribute("user_id") = null; %>
//<a href="login.jsp" class="auth-button">Logout</a>