package org.example.greensuper.utils;

import org.mindrot.jbcrypt.BCrypt;

public class EncryptionUtil {
    public String hashingPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt());
    }
}
