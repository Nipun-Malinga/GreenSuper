package org.example.greensuper.seeders;

import org.example.greensuper.dao.AdminDao;
import org.example.greensuper.models.Admin;

/**
 * Creates the initial admin from the ADMIN_EMAIL and ADMIN_PASSWORD environment variables
 * (set in Tomcat's bin/setenv.sh). Safe to run on every startup: an admin that already
 * exists is left untouched, so changing ADMIN_PASSWORD later does not reset it.
 */
public final class AdminSeeder {

    private AdminSeeder() {}

    public static void seed() {
        String email = System.getenv("ADMIN_EMAIL");
        String password = System.getenv("ADMIN_PASSWORD");

        if (isBlank(email) || isBlank(password)) {
            System.out.println("AdminSeeder: ADMIN_EMAIL or ADMIN_PASSWORD not set, skipping.");
            return;
        }

        email = email.trim();
        AdminDao adminDao = new AdminDao();

        if (adminDao.adminExists(email)) {
            System.out.println("AdminSeeder: admin " + email + " already exists, skipping.");
            return;
        }

        if (adminDao.addAdmin(new Admin(email, password))) {
            System.out.println("AdminSeeder: created admin " + email + ".");
        }
    }

    private static boolean isBlank(String value) {
        return value == null || value.isBlank();
    }
}
