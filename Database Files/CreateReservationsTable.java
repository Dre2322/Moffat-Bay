// CreateReservationsTable.java
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class CreateReservationsTable {
    public static void main(String[] args) {
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {

            // Create reservations table
            stmt.executeUpdate(
                "CREATE TABLE reservations (" +
                "reservation_id INT AUTO_INCREMENT PRIMARY KEY," +
                "user_id int(8) NOT NULL," +
                "room_type_id INT NOT NULL," +
                "check_in_date DATE NOT NULL," +
                "check_out_date DATE NOT NULL," +
                "num_guests INT NOT NULL," +
                "special_requests TEXT," +
                "status VARCHAR(20) NOT NULL," +
                "total_price DECIMAL(10,2) NOT NULL," +
                "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP," +
                "FOREIGN KEY (user_id) REFERENCES users(user_id)," +
                "FOREIGN KEY (room_type_id) REFERENCES room_types(room_type_id))"
            );

            // Insert sample data
            stmt.executeUpdate(
                "INSERT INTO reservations (user_id, room_type_id, check_in_date, check_out_date, num_guests, special_requests, status, total_price, created_at) VALUES " +
                "(00000001, 1, '2025-05-01', '2025-05-03', 2, 'Extra pillows', 'Confirmed', 300.00, '2025-04-01 10:00:00')," +
                "(00000002, 2, '2025-06-10', '2025-06-12', 1, 'Late check-in', 'Completed', 400.00, '2025-04-02 11:00:00')," +
                "(00000003, 3, '2025-07-15', '2025-07-17', 2, 'Allergy-free room', 'Cancelled', 200.00, '2025-04-03 12:00:00')"
            );

            System.out.println("Reservations table created and populated.");

        } catch (SQLException e) {
            System.err.println("Error creating reservations table: " + e.getMessage());
        }
    }
}
