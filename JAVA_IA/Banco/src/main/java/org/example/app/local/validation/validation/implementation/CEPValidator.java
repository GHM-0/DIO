package org.example.core.domain.local.validation.implementation;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import org.example.core.domain.local.validation.ValidaCEP;

public class CEPValidator implements ConstraintValidator<ValidaCEP, String> {

    private static final String REGEX_CEP = "\\d{5}-?\\d{3}";

    @Override
    public boolean isValid(String cep, ConstraintValidatorContext context) {
        if (cep == null) {
            return true; // Deixe que @NotNull cuide disso se for obrigatório
        }
        return cep.matches(REGEX_CEP);
    }
}
