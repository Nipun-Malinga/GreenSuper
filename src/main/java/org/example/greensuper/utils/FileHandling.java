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

    /**
     * Builds a file name from {@code baseName} plus the uploaded file's extension,
     * e.g. ("Fish & Meat", "IMG_001.JPG") -> "fish_meat.jpg".
     * Only lowercase letters, digits, '-' and '_' are kept, so the name is safe on disk and in URLs.
     */
    public String buildFileName(String baseName, Part file) {
        String name = baseName == null ? "" : baseName.trim().toLowerCase()
                .replaceAll("[^a-z0-9_-]+", "_")
                .replaceAll("^_+|_+$", "");
        if (name.isEmpty()) {
            name = "image";
        }
        return name + getExtension(getFileName(file));
    }

    public boolean moveFile(String path, Part file) {
        return moveFile(path, file, getFileName(file));
    }

    // Saves the uploaded file under the given file name.
    public boolean moveFile(String path, Part file, String fileName) {
        Path destinationPath = Paths.get(path, fileName);

        try {
            Files.copy(file.getInputStream(), destinationPath, StandardCopyOption.REPLACE_EXISTING);
            file.delete();

            System.out.println("File Successfully moved to: " + destinationPath);
        } catch (IOException e) {
            System.out.println("Could not save file: " + destinationPath + " (" + e + ")");
            return false;
        }
        return Files.exists(destinationPath);
    }

    // Deletes a previously uploaded file. Returns false if there was nothing to delete.
    public boolean deleteFile(String path, String fileName) {
        if (fileName == null || fileName.isBlank()) {
            return false;
        }
        Path directory = Paths.get(path).normalize();
        Path target = directory.resolve(fileName).normalize();
        if (!target.getParent().equals(directory)) {
            return false; // never delete outside the upload folder
        }
        try {
            return Files.deleteIfExists(target);
        } catch (IOException e) {
            System.out.println("Could not delete file: " + target + " (" + e.getMessage() + ")");
            return false;
        }
    }

    public boolean isFileSelected(Part file) {
        return file.getSize() > 0;
    }

    // ".jpg" for "photo.JPG"; empty when there is no usable extension.
    private String getExtension(String fileName) {
        if (fileName == null) {
            return "";
        }
        int dot = fileName.lastIndexOf('.');
        if (dot < 0 || dot == fileName.length() - 1) {
            return "";
        }
        String extension = fileName.substring(dot + 1).toLowerCase();
        return extension.matches("[a-z0-9]+") ? "." + extension : "";
    }
}
