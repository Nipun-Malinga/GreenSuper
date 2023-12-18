package org.example.greensuper.utils;

import org.mindrot.jbcrypt.BCrypt;

public class DecryptionUtil {
    public boolean isPasswordMatch(String userEnteredPassword, String hashedPasswordFromDatabase) {
        return BCrypt.checkpw(userEnteredPassword, hashedPasswordFromDatabase);
    }
}
