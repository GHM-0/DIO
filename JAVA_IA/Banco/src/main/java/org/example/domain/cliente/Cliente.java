package org.example.domain.cliente;

import jakarta.validation.constraints.NotNull;

public abstract class Cliente {
    @NotNull
    public Endereco endereco;

    @NotNull
    public String nome;

    @NotNull
    public String sobreNome;

    @NotNull
    public String id;

    public Cliente(
            @NotNull String id,
            @NotNull String nome,
            @NotNull String sobrenome,
            @NotNull Endereco endereco){
        this.id = id;
        this.sobreNome = sobrenome;
        this.nome = nome;
        this.endereco = endereco;
    }

    @Override
    public String toString(){
        return "Cliente [ "+this.getClass().getSimpleName()+
                ", id:"+this.id+
                ", nome:"+this.nome+" "+this.sobreNome+", "+
                this.endereco.toString()+"]";
    }
}
