package org.example.greensuper.utils;

import jakarta.servlet.http.Part;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

public class FileHandling {
    public String getFileName(Part file) {
        return file.getSubmittedFileName();
    }

    public boolean moveFile(String path, Part file) {
        String fileName = getFileName(file);
        Path destinationPath = Paths.get(path, fileName);

        try {
            Files.copy(file.getInputStream(), destinationPath, StandardCopyOption.REPLACE_EXISTING);
            file.delete();

            System.out.println("File Successfully moved to: " + destinationPath);
        } catch (IOException e) {
            e.fillInStackTrace();
        }
        return Files.exists(destinationPath);
    }
}
