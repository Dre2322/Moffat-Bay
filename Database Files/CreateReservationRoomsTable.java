/*
 * Reservation Rooms Table Page - Alpha Team
 * Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh
 *
 * Purpose:
 * This script creates the `reservation_rooms` table to normalize the relationship between 
 * reservations and room types. Each entry links a reservation to a specific room type and
 * records how many rooms of that type were booked. 
 * 
 * This replaces the older `rooms` table and allows the system to support multi-room-type
 * reservations, improve flexibility, and simplify reporting. Individual room numbers are 
 * not tracked in this model.
 */

package MBayDB;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class CreateReservationRoomsTable {
    public static void main(String[] args) {
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {

            // Create reservation_rooms table
            stmt.executeUpdate(
                "CREATE TABLE reservation_rooms (" +
                "reservation_room_id INT AUTO_INCREMENT PRIMARY KEY," +
                "reservation_id INT NOT NULL," +
                "room_type_id INT NOT NULL," +
                "room_count INT NOT NULL," +
                "FOREIGN KEY (reservation_id) REFERENCES reservations(reservation_id) ON DELETE CASCADE," +
                "FOREIGN KEY (room_type_id) REFERENCES room_types(room_type_id) ON DELETE CASCADE" +
                ")"
            );

            // Optional: Insert starter data
            stmt.executeUpdate(
                "INSERT INTO reservation_rooms (reservation_id, room_type_id, room_count) VALUES " +
                "(1, 1, 2)," +
                "(1, 2, 1)," +
                "(2, 3, 1)"
            );

            System.out.println("Reservation_rooms table created and populated.");

        } catch (SQLException e) {
            System.err.println("Error creating reservation_rooms table: " + e.getMessage());
        }
    }
}
