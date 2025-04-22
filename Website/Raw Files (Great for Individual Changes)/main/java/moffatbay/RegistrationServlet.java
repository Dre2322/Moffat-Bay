/* Registration Servlet Alpha Team
   Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh */

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
import moffatbay.RegistrationBeans;
import moffatbay.DBConnection;
import java.sql.*;

import java.util.Random;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;


@WebServlet("/Registration")
public class RegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public RegistrationServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		//Get Form Data via Beans
		RegistrationBeans fname = new RegistrationBeans();
		RegistrationBeans lname = new RegistrationBeans();
		RegistrationBeans email = new RegistrationBeans();
		RegistrationBeans phone = new RegistrationBeans();
		RegistrationBeans pass = new RegistrationBeans();
		RegistrationBeans confpass = new RegistrationBeans();
		RegistrationBeans address = new RegistrationBeans();
		RegistrationBeans city = new RegistrationBeans();
		RegistrationBeans state = new RegistrationBeans();
		RegistrationBeans zip = new RegistrationBeans();
		
		//Create UserID Object
		RegistrationBeans userid = new RegistrationBeans();
		
		fname.setFirstName(req.getParameter("firstname"));
		lname.setLastName(req.getParameter("lastname"));
		email.setEmailAddress(req.getParameter("email"));
		phone.setPhoneNum(req.getParameter("phone"));
		pass.setPassword(req.getParameter("pass"));
		confpass.setConfirmPassword(req.getParameter("confirmpass"));
		address.setAddress(req.getParameter("address"));
		city.setCity(req.getParameter("city"));
		state.setState(req.getParameter("state"));
		zip.setZipcode(req.getParameter("zip"));
		
		//These are for the optional values if they were empty
		String addaddress = null;
		String addcity = null;
		String addstate = null;
		String addzip = null;
		
		//Set Response Type
		res.setContentType("text/html");
		
		//Check to see if account already exists
		try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE email = ? AND password_hash = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email.getEmailAddress());
            pstmt.setString(2, PasswordUtil.hashPassword(pass.getPassword()));
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
			//Make Random 8 digit number and set userid
			Random rand = new Random();
			int newuserid = rand.nextInt(99999999) + 1;

			//Obtain Result Set to make existence check
			String sql = "Select * From users Where user_id = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, newuserid);
			ResultSet rs = pstmt.executeQuery();

			//This boolean check informs of whether a Result Exists for the random number generated above
			boolean nullcheck = rs.next();

			//Loop to check Database Match. If there is a match with the first check, the loop generates a new Random Number and Result Set until there is a unique user_id
			//If the first generated number is unique, this loop is ignored
			while (nullcheck == true) {
				//Regenerate new random user_id, recreate ResultSet, and ResultSet Check
				newuserid = rand.nextInt(99999999) + 1;
				
				sql = "Select * From Users Where user_id = ?;";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, newuserid);
				rs = pstmt.executeQuery();
				
				nullcheck = rs.next();
				
				//If a unique user_id was made, the loop breaks as the requirement is now met
				if (nullcheck == false) {
					break;
				}
			}
			
			//Set the NewUserId so it can be used outside of this try statement
			userid.setNewUserID(newuserid);
			//userid is now a unique 8 digit number
		
	        //Convert Password to hash then proceed with Database Entry
			String passhash = PasswordUtil.hashPassword(pass.getPassword());
	        
	        //If Optional Entries (Address, City, State, Zip) are empty, convert to null values
	        //Address Check. If Entry is filled, obtain String info and replace
	        if (address.getAddress().isEmpty() == false) {
	        	addaddress = address.getAddress();
	        }
	        //City Check. If Entry is filled, obtain String info and replace
	        if (city.getCity().isEmpty() == false) {
	        	addcity = city.getCity();
	        }
	        //State Check. If Entry is filled, obtain String info and replace
	        if (state.getState().isEmpty() == false) {
	        	addstate = state.getState();
	        }
	        //Zip Check. If Entry is filled, obtain String info and replace
	        if (zip.getZipcode().isEmpty() == false) {
	        	addzip = zip.getZipcode();
	        }		        
	        
	        //Add new User to Registration Table.
			sql = "INSERT INTO MBay.Users (user_id, first_name, last_name, email, phone_number, "
						+ "password_hash, address, city, state, zip) VALUES "
						+ "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userid.getNewUserID());
			pstmt.setString(2, fname.getFirstName());
			pstmt.setString(3, lname.getLastName());
			pstmt.setString(4, email.getEmailAddress());
			pstmt.setString(5, phone.getPhoneNum());
			pstmt.setString(6, passhash);
			pstmt.setString(7, addaddress);
			pstmt.setString(8, addcity);
			pstmt.setString(9, addstate);
			pstmt.setString(10, addzip);
			pstmt.executeUpdate();
			
			//Close connection
			conn.close();
			
			//Redirect User to Registration Confirmation Page
			res.sendRedirect("Confirmation.jsp");
		}						
		catch(SQLException e) {
			System.out.println(e);
			System.out.println("Failed to Insert User into Registration Table.");
		}	
	}
}
