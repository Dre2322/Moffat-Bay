/*
 * Filler Data Page - Alpha Team
 * Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh
 *
 * Purpose:
 * This script populates the MBay database with example data for development and testing.
 * It inserts users, base reservations (without room_type_id),
 * and reservation-room mappings into the normalized `reservation_rooms` table.
 */

package MBayDB;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class FillerData1 {
    public static void main(String[] args) {
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {

            // Insert test users
            stmt.executeUpdate(
                "INSERT INTO users (user_id, email, first_name, last_name, pass, phone, address, city, state, zip, registration_date) VALUES " +
                "(20777918, 'AliciaJChmura@google.com', 'Alicia', 'Chmura', '8801c59bd4c886d5eec4d7d5277fc341810ccecdfb14a4d02c14a1e1a6d63789', '567-9305', '4362 Marcus Street', 'Hunstville', 'AL', '35802','2025-05-01')," + // pass: le4seiXiegh
                "(31800597, 'CheriJBlackman@yahoo.com', 'Cherie', 'Blackman', '078646aa679ed91d115636f7d5e99dd49de54c60cd7ad233c256b7a106e95e6d', '295-2932', '4288 Meadow Lane', 'Ukiah', 'CA', '95482','2025-04-17')," +     // pass: heuPh3IRohph
                "(73535047, 'GeorgeKAngel@hotmail.com', 'George', 'Angel', 'eebf8211dc41a718533ef21ef30dca8116b52b11b6a6b28688d0651d5b269621', '933-4484', '4552 White Lane', 'Toomsboro', 'GA', '31090','2025-04-28')"          // pass: cho0AhmohSae
            );
            System.out.println("✅ Users sample data inserted.");

            // Insert sample reservations (no room_type_id column anymore)
            stmt.executeUpdate(
                "INSERT INTO reservations (reservation_id, user_id, check_in_date, check_out_date, num_guests, special_requests, status, total_price, created_at, confirmation_number) VALUES " +
                "(101, 20777918, '2025-06-16', '2025-06-23', 2, 'No room service until after 9am please', 'Complete', 1080.00, '2025-04-22 05:31:48', 'MBAY2001')," +
                "(102, 31800597, '2025-07-19', '2025-07-23', 5, 'Extra blankets, pillows, and towels', 'Complete', 750.00, '2025-05-18 12:31:59', 'MBAY2002')," +
                "(103, 73535047, '2025-06-12', '2025-06-15', 2, 'Extra pillows', 'Complete', 540.00, '2025-04-22 19:25:00', 'MBAY2003')"
            );
            System.out.println("✅ Reservations sample data inserted.");

            // Insert corresponding reservation_rooms mappings
            stmt.executeUpdate(
                "INSERT INTO reservation_rooms (reservation_id, room_type_id, room_count) VALUES " +
                "(101, 2, 2)," +
                "(102, 3, 1)," +
                "(103, 2, 1)"
            );
            System.out.println("✅ Reservation_rooms mapping inserted.");

            System.out.println("✅ All filler data from FillerData1 injected successfully.");

        } catch (SQLException e) {
            System.err.println("❌ Error injecting Filler Data 1: " + e.getMessage());
        }
    }
}
