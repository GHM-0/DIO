package org.example.core.domain.cliente.pessoajuridica;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.NonNull;
import org.example.core.domain.cliente.Cliente;
import org.example.core.domain.local.agencia.Agencia;
import org.example.core.domain.local.Endereco;

import java.time.LocalDate;
import java.util.Set;

public class PessoaJuridica extends Cliente {

    // Identificador == cnpj
    // IdNominal == nomeFantasia
    // IdSupraNominal == razaoSocial

    public PessoaJuridica(
            @NonNull String nomeFantasia,
            @NonNull String razaoSocial,
            @NonNull String cnpj,
            @NotNull LocalDate dataConstituicao,
            @NonNull Agencia agencia,
            @NonNull Endereco endereco
    ){
        super(nomeFantasia,razaoSocial,cnpj,dataConstituicao,agencia,endereco);
    }

    // Wrappers for consistency in fields names
    protected String getCNPJ(){
        return this.getIdentificador();
    }
    protected String getRazaoSocial(){
        return this.getIdSupraNominal();
    }
    protected String getNomeFantasia(){return this.getIdNominal();}
    protected LocalDate getDataDeConstituicao(){return this.getDataOrigem();}

    @Override
    public String getNomeCompleto() {
        return this.getIdNominal()+" "+this.getRazaoSocial();
    }

    //TODO
    @Override
    protected String criarId(){
        return ("Y+1");
    }

}
