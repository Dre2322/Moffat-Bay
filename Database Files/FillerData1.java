//This injects additional filler data into the Database
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class FillerData1 {
    public static void main(String[] args) {
        //This initiates the connection to the Database
        try (Connection conn = DBConnection.getConnection();
            Statement stmt = conn.createStatement()) {

            //This injects some data into the User Table
            stmt.executeUpdate(
                "INSERT INTO Users VALUES " +
                "(20777918, 'AliciaJChmura@google.com', 'Alicia', 'Chmura', '8801c59bd4c886d5eec4d7d5277fc341810ccecdfb14a4d02c14a1e1a6d63789', '567-9305', '4362 Marcus Street', 'Hunstville', 'AL', '35802','2025-05-01')," + //pass: le4seiXiegh
                "(31800597, 'CheriJBlackman@yahoo.com', 'Cherie', 'Blackman', '078646aa679ed91d115636f7d5e99dd49de54c60cd7ad233c256b7a106e95e6d', '295-2932', '4288 Meadow Lane', 'Ukiah', 'CA', '95482','2025-04-17')," + //pass: heuPh3IRohph
                "(73535047, 'GeorgeKAngel@hotmail.com', 'George', 'Angel', 'eebf8211dc41a718533ef21ef30dca8116b52b11b6a6b28688d0651d5b269621', '933-4484', '4552 White Lane', 'Toomsboro', 'GA', '31090','2025-04-28')" //pass: cho0AhmohSae
            );

            System.out.println("Users Sample data inserted.");

            //This injects some data into the Room Table
            stmt.executeUpdate(
                "INSERT INTO Rooms (room_type_id, room_number) VALUES " +
                "(2, '306')," +
                "(3, '113')," +
                "(2, '224')"
                );

            System.out.println("Rooms Sample data inserted.");

            //This injects some data into the Reservation Table
            stmt.executeUpdate(
                "INSERT INTO Reservations (user_id, room_type_id, check_in_date, check_out_date, num_guests, special_requests, status, total_price, created_at) VALUES " +
                "(20777918, 2, '2025-06-16', '2025-06-23', 2, 'No room service until after 9am please', 'Complete', 1080.00, '2025-04-22 05:31:48')," +
                "(31800597, 3, '2025-07-19', '2025-07-23', 5, 'Extra blankets, pillows, and towels', 'Complete', 750.00, '2025-05-18 12:31:59')," +
                "(73535047, 2, '2025-06-12', '2025-06-15', 2, 'Extra pillows', 'Complete', 540.00, '2025-04-22 19:25:00')"
                );

            System.out.println("Reservations Sample data inserted.");

            //This injects some data into the ContactMessage Table
            stmt.executeUpdate(
                "INSERT INTO Contact_Messages (name, email, subject, message, submitted_at) VALUES " +
                "('Linsey Vereen', 'LindseyDVereen@gmail.com', 'Attractions Required', 'Are we required to do some of the Attractions on your website or can we rent some rooms and do our own thing?', '2025-05-13 22:00:58')," +
                "('Elizabeth Robinson', 'ElizabethTRobinson@yahoo.com', 'Future Reservation Question', 'How far out can we rent out some space in the lodge? I was thinking of renting a room early next year and I wanted to know if that was feasible or not.', '2025-04-30 07:41:41')," +
                "('Ashley Brewer', 'AshleyJBrewer@hotmail.com', 'Hiring', 'I know this is not you typical question you may recieve but I was wondering if Moffat Bay was hiring. If so, please email me back at AshleyJBrewer@hotmail.com', '2025-05-01 08:49:02')"
                );

            System.out.println("Contact_Messages Sample data inserted.");
            System.out.println("All Filler Data from file 1 inserted.");

        } catch (SQLException e) {
            System.err.println("Error injecting Filler Data 1: " + e.getMessage());
        }
    }
}