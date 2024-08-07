package org.example.domain.cliente;

import jakarta.validation.constraints.NotNull;

public class PessoaJuridica extends Cliente{
    public PessoaJuridica(
            @NotNull String id,
            @NotNull String nome,
            @NotNull String sobrenome,
            @NotNull Endereco endereco
    ){
        super(id,nome,sobrenome,endereco);
    }
}
