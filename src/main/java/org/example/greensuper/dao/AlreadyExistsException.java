package org.example.greensuper.dao;

/** Thrown when trying to add a category or product that is already in the database. */
public class AlreadyExistsException extends RuntimeException {
    public AlreadyExistsException(String message) {
        super(message);
    }
}
