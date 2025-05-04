/*
 * Run All Page - Alpha Team
 * Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh
 *
 * Purpose:
 * This script initializes the entire MBay database. It:
 * - Creates the database if it does not exist.
 * - Drops all dependent tables in proper order for a clean reset.
 * - Recreates and populates core tables: users, room types, reservations, reservation_rooms.
 * - Optionally loads filler data for testing.
 *
 * Use this as a one-click development initializer. Not intended for production.
 */

package MBayDB;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class RunAll {
    public static void main(String[] args) {
        // Create database if it doesn't exist
        try (Connection conn = DBConnection.createDatabase();
             Statement stmt = conn.createStatement()) {

            stmt.executeUpdate("CREATE DATABASE IF NOT EXISTS Mbay");
            System.out.println("[✅] Database 'Mbay' created or verified.");

        } catch (SQLException e) {
            System.err.println("[❌] Error creating database: " + e.getMessage());
        }

        // Drop all existing tables in dependency-safe order
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {

            stmt.executeUpdate("DROP TABLE IF EXISTS reservation_rooms");
            stmt.executeUpdate("DROP TABLE IF EXISTS reservations");
            //stmt.executeUpdate("DROP TABLE IF EXISTS rooms"); // No longer used, but dropped for legacy cleanup
            stmt.executeUpdate("DROP TABLE IF EXISTS contact_messages");
            stmt.executeUpdate("DROP TABLE IF EXISTS room_types");
            stmt.executeUpdate("DROP TABLE IF EXISTS users");

            System.out.println("[✅] All tables dropped successfully (if they existed).");

        } catch (SQLException e) {
            System.err.println("[❌] Error dropping tables: " + e.getMessage());
        }

        // Recreate and populate each core table
        System.out.println("\n[⚙️] Creating and populating tables...");
        CreateUsersTable.main(null);
        CreateRoomTypesTable.main(null);
        CreateReservationsTable.main(null);
        CreateReservationRoomsTable.main(null);

        // Load optional filler data for testing
        FillerData1.main(null);

        System.out.println("\n[✅] All MBay tables created, populated, and ready.");
    }
}
