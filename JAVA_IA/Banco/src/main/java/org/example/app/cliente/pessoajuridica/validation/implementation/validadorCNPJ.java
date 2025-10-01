package org.example.core.domain.cliente.pessoajuridica.validador.implementation;

import org.example.core.domain.cliente.validation.IdentidadeValidator;

public final class  validadorCNPJ implements IdentidadeValidator {

    @Override
    public boolean isValid(String cnpj) {
        if (cnpj == null) return false;
        return cnpj.replaceAll("\\D", "").matches("\\d{14}");
    }
}
