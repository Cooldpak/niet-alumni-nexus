package com.niet.nexus.utils;

import org.mindrot.jbcrypt.BCrypt;

public class BcryptUtil {
    
    // Hash a password using Bcrypt
    public static String hashPassword(String plainTextPassword) {
        return BCrypt.hashpw(plainTextPassword, BCrypt.gensalt(12));
    }
    
    // Check a password against a hash
    public static boolean checkPassword(String plainTextPassword, String hashedPassword) {
        return BCrypt.checkpw(plainTextPassword, hashedPassword);
    }
}
