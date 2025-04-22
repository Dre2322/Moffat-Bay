// DBConnection.java (shared connection utility class)
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL JDBC driver
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found.", e);
        }

        String dbUrl = "jdbc:mysql://localhost:3306/MBay";
        String user = "root";
        String password = "Freeaid#0001"; // Change this!
        return DriverManager.getConnection(dbUrl, user, password);
    }

    public static Connection createDatabase() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL JDBC driver
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found.", e);
        }

        String dbUrl = "jdbc:mysql://localhost:3306";
        String user = "root";
        String password = "Freeaid#0001"; // Change this!
        return DriverManager.getConnection(dbUrl, user, password);
    }
}
