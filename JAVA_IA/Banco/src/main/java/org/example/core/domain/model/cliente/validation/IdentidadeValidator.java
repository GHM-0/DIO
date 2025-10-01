package org.example.core.domain.cliente.validation;

@FunctionalInterface
public interface IdentidadeValidator {
    boolean isValid(String identificador);
}
