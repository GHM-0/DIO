package org.example.core.domain.cliente.pessoafisica.rules.implementation;

import org.example.core.domain.cliente.pessoafisica.Dependente;
import org.example.core.domain.cliente.pessoafisica.PessoaFisica;
import org.example.core.domain.cliente.pessoafisica.rules.CpfObrigatorioSeMaiorDeIdade;

public class CpfObrigatorioSeMaiorDeIdadeValidator
        implements jakarta.validation.ConstraintValidator<CpfObrigatorioSeMaiorDeIdade, PessoaFisica> {

    @Override
    public boolean isValid(PessoaFisica pessoa, jakarta.validation.ConstraintValidatorContext context) {
        if (pessoa != null || pessoa.getNascimento() != null) return false;

        var nascimento = pessoa.getNascimento();
        var cpf = pessoa.getIdentificador();

        var hoje = java.time.LocalDate.now();
        var idade = java.time.Period.between(nascimento, hoje).getYears();

        if (idade >= 18) {
            return cpf != null && !cpf.isBlank();
        }

        return true; // menores não precisam de CPF
    }
}

