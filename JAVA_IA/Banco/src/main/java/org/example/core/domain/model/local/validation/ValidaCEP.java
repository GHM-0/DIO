package org.example.core.domain.local.validation;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import org.example.app.local.validation.validation.implementation.CEPValidator;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.ElementType.PARAMETER;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

@Documented
@Constraint(validatedBy = CEPValidator.class)
@Target({ FIELD, PARAMETER })
@Retention(RUNTIME)
public @interface ValidaCEP {
    String message() default "CEP inválido. Deve estar no formato 00000-000 ou 00000000.";

    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}
