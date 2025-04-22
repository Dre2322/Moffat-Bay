// CreateUsersTable.java
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class CreateUsersTable {
    public static void main(String[] args) {
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {

            // Create users table
            stmt.executeUpdate(
                "CREATE TABLE users (" +
                "user_id int(8) PRIMARY KEY," +
                "email VARCHAR(255) UNIQUE NOT NULL," +
                "first_name VARCHAR(50) NOT NULL," +
                "last_name VARCHAR(50) NOT NULL," +
                "password_hash VARCHAR(255) NOT NULL," +
                "phone_number VARCHAR(20)," +
                "address VARCHAR(100)," +
                "city VARCHAR(50)," +
                "state VARCHAR(50)," +
                "zip VARCHAR(15)," +
                "registration_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)");

            // Insert sample data
            stmt.executeUpdate(
                "INSERT INTO users VALUES " +
                "(00000001, 'jsmith@google.com', 'John', 'Smith', 'e6c3da5b206634d7f3f3586d747ffdb36b5c675757b380c6a5fe5c570c714349', '867-5309', '100 Galvin Rd S', 'Bellevue', 'NE', '68005','2025-04-03')," + //pass: pass1
                "(00000002, 'jdoe@yahoo.com', 'Jane', 'Doe', '1ba3d16e9881959f8c9a9762854f72c6e6321cdd44358a10a4e939033117eab9', '867-5409', '101 Galvin Rd', 'Los Angeles', 'CA', '90001','2025-04-02')," + //pass: pass2
                "(00000003, 'jschmoe@hotmail.com', 'John', 'Schmoe', '3acb59306ef6e660cf832d1d34c4fba3d88d616f0bb5c2a9e0f82d18ef6fc167', '867-5509', '102 Galvin St', 'Portland', 'OR', '97035','2025-04-01')" //pass: pass3
            );

            System.out.println("Users table created and populated.");

        } catch (SQLException e) {
            System.err.println("Error creating users table: " + e.getMessage());
        }
    }
}
