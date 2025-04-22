/* Data Manager Servlet Test Alpha Team
   Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh */

package moffatbay;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


//DataManager file to handle Server Connections privately
public class DataManager {	
	private String dbURL = "";
	private String dbUserName = "";
	private String dbPassword = "";
	
	//public DataManager() {
	//}
	
	//Getters
	public String getDbURL() {
		return dbURL;
	}
	
	public String getDbUserName() {
		return dbUserName;
	}
	
	public String getDbPassword() {
		return dbPassword;
	}
	
	//Setters
	public void setDbURL(String dbURL) {
		this.dbURL = dbURL;
	}
	
	public void setDbUserName(String dbUserName) {
		this.dbUserName = dbUserName;
	}
	
	public void setDbPassword(String dbPassword) {
		this.dbPassword = dbPassword;
	}
	
	//This provides Connection the Database
	public Connection getConnection() {
		Connection conn = null;
		
		try {
			conn = DriverManager.getConnection(getDbURL(), getDbUserName(), getDbPassword());
		}
		catch (SQLException e) {
			System.out.println("Could not connect to Database: " + e.getMessage());
		}
		
		return conn;
	}
	
	//Close connection
	public void putConnection(Connection conn) {
		if (conn != null) {
			try {
				conn.close();
			}
			catch (SQLException e) {
			}
		}
	}
}
