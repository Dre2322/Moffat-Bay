// CreateContactMessagesTable.java
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class CreateContactMessagesTable {
    public static void main(String[] args) {
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {

            // Create contact_messages table
            stmt.executeUpdate(
                "CREATE TABLE contact_messages (" +
                "message_id INT AUTO_INCREMENT PRIMARY KEY," +
                "name VARCHAR(100) NOT NULL," +
                "email VARCHAR(255) NOT NULL," +
                "subject VARCHAR(255)," +
                "message TEXT NOT NULL," +
                "submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)"
            );

            stmt.executeUpdate(
                "INSERT INTO contact_messages (name, email, subject, message, submitted_at) VALUES " +
                "('John Smith', 'jsmith@gmail.com', 'Hello', 'You Guys Rock!', '2025-01-28 03:04:05')," +
                "('Jane Doe', 'jdoe@yahoo.com', 'Awesome Developers', 'These Developers are awesome!', '2025-02-16 04:05:06')," +
                "('Joe Schmoe', 'jschmoe@hotmail.com', 'Amazing Stay', 'Keep up the great work!', '2025-03-07 07:08:09')"
            );

            System.out.println("Contact_messages table created and populated.");

        } catch (SQLException e) {
            System.err.println("Error creating contact_messages table: " + e.getMessage());
        }
    }
}
