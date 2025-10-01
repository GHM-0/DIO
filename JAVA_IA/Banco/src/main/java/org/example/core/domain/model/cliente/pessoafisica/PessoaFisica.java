package org.example.core.domain.cliente.pessoafisica;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Null;
import lombok.NonNull;
import org.example.core.domain.cliente.Cliente;
import org.example.core.domain.cliente.pessoafisica.rules.CpfObrigatorioSeMaiorDeIdade;
import org.example.core.domain.local.agencia.Agencia;
import org.example.core.domain.local.Endereco;

import java.time.LocalDate;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

@CpfObrigatorioSeMaiorDeIdade
public class PessoaFisica extends Cliente {

    // Identificador == cpf
    // IdNominal == nome
    // IdSupraNominal == sobrenome

    private final Set<Dependente> dependentes = new HashSet<>();

    private static boolean isMaiorDeIdade(LocalDate nascimento) {
        var hoje = java.time.LocalDate.now();
        return java.time.Period.between(nascimento, hoje).getYears() >= 18;
    }

    public PessoaFisica(
            @NonNull String nome,
            @NonNull String sobreNome,
            @Null String cpf,
            @NonNull LocalDate nascimento,
            @NonNull Agencia agencia,
            @NonNull Endereco endereco
    ) {
        super(nome, sobreNome, cpf, nascimento, agencia, endereco);
    }

    // Wrappers for consistency in fields names
    public String getCPF(){return this.getIdentificador();}
    public String getNome(){return this.getIdNominal();}
    public String getSobreNome(){return this.getIdSupraNominal();}
    public LocalDate getNascimento(){return this.getDataOrigem();}

    @Override
    public String getNomeCompleto() {
        return this.getNome()+" "+this.getSobreNome();
    }

    //TODO
    @Override
    protected String  criarId(){
        return ("W+0");
    }

    public void addDependente(@NotNull Dependente dependente){
        this.dependentes.add(Objects.requireNonNull(dependente));
    }

    public Set<Dependente> getDependentes(){
        return this.dependentes;
    }

}
