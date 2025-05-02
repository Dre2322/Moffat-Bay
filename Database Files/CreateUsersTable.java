/*
 * User Table Page - Alpha Team
 * Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh
 *
 * Purpose:
 * - Creates the `users` table with `user_id` as AUTO_INCREMENT.
 * - Inserts sample users without manually setting `user_id`.
 */

package MBayDB;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class CreateUsersTable {
    public static void main(String[] args) {
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {

            // Create users table with AUTO_INCREMENT user_id
        	stmt.executeUpdate(
        		    "CREATE TABLE users (" +
        		    "user_id INT AUTO_INCREMENT PRIMARY KEY," +
        		    "email VARCHAR(255) UNIQUE NOT NULL," +
        		    "first_name VARCHAR(50) NOT NULL," +
        		    "last_name VARCHAR(50) NOT NULL," +
        		    "pass VARCHAR(255) NOT NULL," +
        		    "phone VARCHAR(20)," +
        		    "address VARCHAR(100)," +
        		    "city VARCHAR(50)," +
        		    "state VARCHAR(50)," +
        		    "zip VARCHAR(15)," +
        		    "registration_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP," + // <- Remove extra closing parenthesis here
        		    "reset_token VARCHAR(255)," +
        		    "token_expiration DATETIME" +
        		    ")"
        		);

            // Insert sample users (omit user_id to use auto-increment)
            stmt.executeUpdate(
                "INSERT INTO users (email, first_name, last_name, pass, phone, address, city, state, zip, registration_date) VALUES " +
                "('jsmith@google.com', 'John', 'Smith', 'e6c3da5b206634d7f3f3586d747ffdb36b5c675757b380c6a5fe5c570c714349', '867-5309', '100 Galvin Rd S', 'Bellevue', 'NE', '68005','2025-04-03')," +
                "('jdoe@yahoo.com', 'Jane', 'Doe', '1ba3d16e9881959f8c9a9762854f72c6e6321cdd44358a10a4e939033117eab9', '867-5409', '101 Galvin Rd', 'Los Angeles', 'CA', '90001','2025-04-02')," +
                "('jschmoe@hotmail.com', 'John', 'Schmoe', '3acb59306ef6e660cf832d1d34c4fba3d88d616f0bb5c2a9e0f82d18ef6fc167', '867-5509', '102 Galvin St', 'Portland', 'OR', '97035','2025-04-01')"
            );

            System.out.println("Users table created with AUTO_INCREMENT and populated.");

        } catch (SQLException e) {
            System.err.println("Error creating users table: " + e.getMessage());
        }
    }
}
