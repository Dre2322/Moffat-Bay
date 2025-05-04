/*
 * Reservation Table Creation Script - Alpha Team
 * Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh
 *
 * Purpose:
 * Creates the `reservations` table and auto-generates a unique `confirmation_number`.
 * Room-specific data is now normalized into the `reservation_rooms` table, allowing each
 * reservation to be linked to multiple room types with custom counts.
 */

package MBayDB;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class CreateReservationsTable {
    public static void main(String[] args) {
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {

            // Drop trigger if it already exists (avoids duplication errors when rerunning)
            stmt.executeUpdate("DROP TRIGGER IF EXISTS set_confirmation_number");

            // Drop existing table if needed (optional for dev/testing, comment out in prod)
            // stmt.executeUpdate("DROP TABLE IF EXISTS reservations");

            // Create the reservations table
            stmt.executeUpdate(
                "CREATE TABLE IF NOT EXISTS reservations (" +
                "reservation_id INT AUTO_INCREMENT PRIMARY KEY," +
                "user_id INT(8) NOT NULL," +
                "check_in_date DATE NOT NULL," +
                "check_out_date DATE NOT NULL," +
                "num_guests INT NOT NULL," +
                "special_requests TEXT," +
                "status VARCHAR(20) NOT NULL," +
                "total_price DECIMAL(10,2) NOT NULL," +
                "confirmation_number VARCHAR(50) UNIQUE," +
                "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP," +
                "FOREIGN KEY (user_id) REFERENCES users(user_id)" +
                ")"
            );

            // Create the trigger to auto-generate confirmation_number as 'MBAY' + reservation_id + 0000
            stmt.executeUpdate(
                "CREATE TRIGGER set_confirmation_number " +
                "BEFORE INSERT ON reservations " +
                "FOR EACH ROW " +
                "BEGIN " +
                "  SET NEW.confirmation_number = CONCAT('MBAY', (SELECT IFNULL(MAX(reservation_id), 0) + 0001 FROM reservations)); " +
                "END"
            );

            // Optional sample data without room_type info
            stmt.executeUpdate(
                "INSERT INTO reservations (user_id, check_in_date, check_out_date, num_guests, special_requests, status, total_price, created_at) VALUES " +
                "(1, '2025-05-01', '2025-05-03', 2, 'Extra pillows', 'Confirmed', 300.00, '2025-04-01 10:00:00')," +
                "(2, '2025-06-10', '2025-06-12', 1, 'Late check-in', 'Completed', 400.00, '2025-04-02 11:00:00')," +
                "(3, '2025-07-15', '2025-07-17', 2, 'Allergy-free room', 'Cancelled', 200.00, '2025-04-03 12:00:00')"
            );

            System.out.println("Reservations table and trigger created successfully.");

        } catch (SQLException e) {
            System.err.println("Error creating reservations table or trigger: " + e.getMessage());
        }
    }
}
