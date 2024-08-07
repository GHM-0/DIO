package org.example.src.Entidade;

import lombok.Getter;
import lombok.Setter;
import java.util.Date;

@Getter
@Setter
public class Cliente{
    private String nome;
    private String sobrenome;
    private Date nascimento;
    private Endereco endereco;
    private String id;

    public Cliente(String nome, String sobrenome, Date nascimento, Endereco endereco, String id ){
        this.nome = nome;
        this.sobrenome = sobrenome;
        this.nascimento = nascimento;
        this.endereco = endereco;
        this.id = id;
    }

}
