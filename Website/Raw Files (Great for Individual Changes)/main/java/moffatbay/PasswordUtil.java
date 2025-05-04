/* Password Hash Class Alpha Team
Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh

Purpose:
This utility class provides a method to hash a user's password using the SHA-256 algorithm.
The `hashPassword` method takes a plain text password as input, applies the SHA-256 hashing algorithm,
and returns the hashed password as a hexadecimal string.This is used for securely storing passwords in the
database, ensuring that sensitive information is not stored in plain text.
*/
package moffatbay;
import java.security.MessageDigest;

public class PasswordUtil {
    public static String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] bytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : bytes) sb.append(String.format("%02x", b));
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}