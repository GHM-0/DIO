package org.example.core.domain.cliente.pessoafisica.validation.implementation;

import org.example.core.domain.cliente.validation.IdentidadeValidator;

public  final class validadorCPF implements IdentidadeValidator {
    @Override
    public boolean isValid(String cpf) {
        if (cpf == null) return false;
        return cpf.replaceAll("\\D", "").matches("\\d{11}");
    }


}
