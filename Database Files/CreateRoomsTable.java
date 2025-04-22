// CreateRoomsTable.java
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class CreateRoomsTable {
    public static void main(String[] args) {
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {

            // Create rooms table
            stmt.executeUpdate(
                "CREATE TABLE rooms (" +
                "room_id INT AUTO_INCREMENT PRIMARY KEY," +
                "room_type_id INT NOT NULL," +
                "room_number VARCHAR(10) UNIQUE NOT NULL," +
                "FOREIGN KEY (room_type_id) REFERENCES room_types(room_type_id))"
            );

            // Insert sample data
            stmt.executeUpdate(
                "INSERT INTO rooms (room_type_id, room_number) VALUES " +
                "(1, '101')," +
                "(2, '202')," +
                "(3, '303')"
            );

            System.out.println("Rooms table created and populated.");

        } catch (SQLException e) {
            System.err.println("Error creating rooms table: " + e.getMessage());
        }
    }
}
