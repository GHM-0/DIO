package org.example.core.domain.cliente.validation.implementation;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import org.example.core.domain.cliente.Cliente;
import org.example.core.domain.cliente.pessoafisica.PessoaFisica;
import org.example.core.domain.cliente.pessoafisica.validation.implementation.validadorCPF;
import org.example.core.domain.cliente.pessoajuridica.PessoaJuridica;
import org.example.core.domain.cliente.pessoajuridica.validador.implementation.validadorCNPJ;
import org.example.core.domain.cliente.validation.IdentidadeValidator;
import org.example.core.domain.cliente.validation.ValidaIdentidade;

import java.util.Map;

public class ValidadorIdentidadeCliente implements ConstraintValidator<ValidaIdentidade, Cliente> {

    private static final Map<Class<? extends Cliente>, IdentidadeValidator> VALIDADORES = Map.of(
            PessoaFisica.class,  (IdentidadeValidator) new validadorCPF(),
            PessoaJuridica.class,  (IdentidadeValidator) new validadorCNPJ()
    );

    @Override
    public boolean isValid(Cliente cliente, ConstraintValidatorContext context) {
        if (cliente == null) return true;

        IdentidadeValidator validador = VALIDADORES.get(cliente.getClass());

        if (validador == null) {
            context.disableDefaultConstraintViolation();
            context.buildConstraintViolationWithTemplate("Validador não configurado para " +
                            cliente.getClass().getSimpleName())
                    .addConstraintViolation();
            return false;
        }

        return validador.isValid(cliente.getIdentificador());
    }
}
