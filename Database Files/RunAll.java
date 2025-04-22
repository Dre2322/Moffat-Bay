// RunAll.java
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class RunAll {
    public static void main(String[] args) {
        //This is exclusively for Database creation due to different connection path
        try (Connection conn = DBConnection.createDatabase();

            Statement stmt = conn.createStatement()) {

            //Create Database if it doesn't exist
            stmt.executeUpdate("CREATE DATABASE IF NOT EXISTS Mbay");
            System.out.println("Database created.");

        } catch (SQLException e) {
            System.err.println("Error creating Database: " + e.getMessage());
        }

        try (Connection conn = DBConnection.getConnection();
            Statement stmt = conn.createStatement()) {

            //Drop tables in correct dependency order
            stmt.executeUpdate("DROP TABLE IF EXISTS reservations");
            stmt.executeUpdate("DROP TABLE IF EXISTS rooms");
            stmt.executeUpdate("DROP TABLE IF EXISTS contact_messages");
            stmt.executeUpdate("DROP TABLE IF EXISTS room_types");
            stmt.executeUpdate("DROP TABLE IF EXISTS users");

            System.out.println("All tables dropped (if existed).\n");

        } catch (SQLException e) {
            System.err.println("Error dropping tables: " + e.getMessage());
        }

        //Recreate and populate each table
        CreateUsersTable.main(null);
        CreateRoomTypesTable.main(null);
        CreateRoomsTable.main(null);
        CreateReservationsTable.main(null);
        CreateContactMessagesTable.main(null);

        //Inject additional Filler Data 1
        FillerData1.main(null);

        System.out.println("All MBay tables have been created and populated.");
    }
}
