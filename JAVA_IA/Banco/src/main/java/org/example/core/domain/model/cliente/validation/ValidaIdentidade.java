package org.example.core.domain.cliente.validation;


import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import org.example.app.cliente.validation.implementation.ValidadorIdentidadeCliente;

import java.lang.annotation.*;

@Inherited
@Documented
@Constraint(validatedBy = ValidadorIdentidadeCliente.class)
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
public @interface ValidaIdentidade {
    String message() default "Identidade inválida para o tipo de cliente.";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}

