package org.example.core.exception;

/**
 * Exceção para violações de regras de negócio
 */
public class BusinessException extends Exception {
    public BusinessException(String message) {
        super(message);
    }

    public BusinessException(String message, Throwable cause) {
        super(message, cause);
    }
}