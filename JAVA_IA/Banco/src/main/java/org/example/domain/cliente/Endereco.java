package org.example.domain.cliente;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Null;

public record Endereco(
        @NotNull String logradouro,
        @NotNull String bairro,
        @NotNull String cidade,
        @NotNull String estado,
        @Null Integer numero) {
}
