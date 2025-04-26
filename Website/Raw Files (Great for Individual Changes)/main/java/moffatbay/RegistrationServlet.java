/*
Registration Servlet Page - Alpha Team
Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh

Purpose:
Handles new user registration. This servlet:
- Validates and sanitizes input data from the registration form
- Hashes user passwords using SHA-256
- Inserts new user records into the MySQL `users` table
- Retrieves the auto-generated user_id using AUTO_INCREMENT
- Automatically logs in the user by storing user_id in session
- Redirects to reservation or confirmation based on session context
*/

package moffatbay;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import moffatbay.DBConnection;
import java.sql.*;

import java.util.Random;


@WebServlet("/Registration")
public class RegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public RegistrationServlet() {
        super();
    }

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		//Get Form Data
		String fname = req.getParameter("firstname");
        String lname = req.getParameter("lastname");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String pass = req.getParameter("pass");
        String address = req.getParameter("address");
        String city = req.getParameter("city");
        String state = req.getParameter("state");
        String zip = req.getParameter("zip");

		//May not be needed
        String redirectParam = req.getParameter("redirect");
		
		//Set Response Type
		res.setContentType("text/html");
		
		//Check to see if account already exists
		try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE email = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            
            //If email exists, close connection and redirect
            if (rs.next()) {
            	conn.close();
                req.setAttribute("errorMessage", "Email already exists.");
                req.getRequestDispatcher("RegistrationPage.jsp").forward(req, res);
                return;
            }
            
            //Close connection
            conn.close();
		}
		catch(SQLException e) {
			System.out.println(e);
			System.out.println("Failed to see if Email already exists");
		}
        
		//Connect to Database and Register New User
		try (Connection conn = DBConnection.getConnection()) {
			//Make Random 8 digit number and set userid field
			Random rand = new Random();
			int userid;
			do {
				userid = rand.nextInt(99999999) + 1;

				//Obtain Result Set to make existence check
				String sql = "Select * From users Where user_id = ?";
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, userid);
				ResultSet rs = pstmt.executeQuery();

				//If Result Doesn't exist, break loop
				if (!rs.next()) {
					break;
				}
			}
			//If a unique userid was made, the loop breaks as the requirement is now met
			while (true);			
		
	        //Convert Password to hash then proceed with Database Entry
			String passhash = PasswordUtil.hashPassword(pass);
	        
	        //If Optional Entries (Address, City, State, Zip) are empty, convert to null values
	        //Address Check. If Entry is empty, set to null
	        if (address.isEmpty() == true) {
				address = null;
	        }
	        //City Check. If Entry is empty, set to null
	        if (city.isEmpty() == true) {
				city = null;
	        }
	        //State Check. If Entry is empty, set to null
	        if (state.isEmpty() == true) {
				state = null;
	        }
	        //Zip Check. If Entry is empty, set to null
	        if (zip.isEmpty() == true) {
				zip = null;
	        }		        
	        
	        //Add new User to Registration Table.
			String sql = "INSERT INTO MBay.Users (user_id, first_name, last_name, email, phone, "
						+ "pass, address, city, state, zip) VALUES "
						+ "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userid);
			pstmt.setString(2, fname);
			pstmt.setString(3, lname);
			pstmt.setString(4, email);
			pstmt.setString(5, phone);
			pstmt.setString(6, passhash);
			pstmt.setString(7, address);
			pstmt.setString(8, city);
			pstmt.setString(9, state);
			pstmt.setString(10, zip);
			pstmt.executeUpdate();
			
			//Close connection
			conn.close();
			
			//Keep this in case we forgo the auto-log feature below
			//Redirect User to Registration Confirmation Page
			//res.sendRedirect("Confirmation.jsp");			

            // Set session attribute for auto-login
            HttpSession session = req.getSession(true);
            session.setAttribute("user_id", userid);
            session.setAttribute("first_name", fname);

            // Redirect logic
            if ("confirmReservation".equals(redirectParam) || session.getAttribute("pendingReservation_roomTypeId") != null) {
                res.sendRedirect("ReservationServlet?action=confirmReservation");
            } else {
                res.sendRedirect("Confirmation.jsp");
            }
			 
		}						
		catch(SQLException e) {
			System.out.println(e);
			System.out.println("Failed to Insert User into Registration Table.");
		}	
	}
}
