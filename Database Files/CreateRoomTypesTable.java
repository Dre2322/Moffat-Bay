/*
 * Room Type Table Page - Alpha Team
 * Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh
 *
 * Purpose:
 * This script creates and populates the `room_types` table, which defines the available types of rooms 
 * offered by the lodge. Each room type includes a name, description, nightly rate, maximum occupancy, 
 * and availability status. This table is referenced by reservations and reservation_rooms to associate 
 * bookings with room categories.
 */

package MBayDB;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class CreateRoomTypesTable {
    public static void main(String[] args) {
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {

            // Create room_types table
            stmt.executeUpdate(
                "CREATE TABLE IF NOT EXISTS room_types (" +
                "room_type_id INT AUTO_INCREMENT PRIMARY KEY," +
                "room_name VARCHAR(50) NOT NULL," +
                "description TEXT," +
                "price_per_night DECIMAL(10,2) NOT NULL," +
                "max_occupancy INT NOT NULL," +
                "availability_status VARCHAR(20) NOT NULL" +
                ")"
            );

            // Insert sample room types
            stmt.executeUpdate(
                "INSERT INTO room_types (room_name, description, price_per_night, max_occupancy, availability_status) VALUES " +
                "('Double Full Beds', 'Two full-size beds for a comfortable night''s rest', 120.00, 5, 'Available')," +
                "('Queen Bed', 'Provides a cozy space for a tranquil retreat', 135.00, 3, 'Available')," +
                "('Double Queen Beds', 'Offers a spacious stay', 150.00, 5, 'Available')," +
                "('King Bed', 'Ensures a regal experience with a luxurious king-size bed', 160.00, 3, 'Not Available')"
            );

            // Adjust prices up by 5% for all room types
            stmt.executeUpdate(
                "UPDATE room_types " +
                "SET price_per_night = ROUND(price_per_night * 1.05, 2)"
            );

            System.out.println("Room_types table created, populated, and prices increased by 5%.");

        } catch (SQLException e) {
            System.err.println("Error creating room_types table: " + e.getMessage());
        }
    }
}
