package me.dio.santanderdevbootcamp.domain.model;

import jakarta.persistence.Embeddable;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Embeddable
@Getter
@Setter
public class Address {
    @NotNull
    private String CEP;
    @NotNull
    private String Rua;
    @NotNull
    private String Bairro;
    @NotNull
    private char[] Estado=new char[2];
}
