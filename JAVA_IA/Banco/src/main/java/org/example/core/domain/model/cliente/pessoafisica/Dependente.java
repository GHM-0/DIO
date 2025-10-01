package org.example.core.domain.cliente.pessoafisica;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Null;
import lombok.Getter;
import lombok.NonNull;
import org.example.core.domain.cliente.pessoafisica.rules.CpfObrigatorioSeMaiorDeIdade;
import org.example.core.domain.local.Endereco;

import java.time.LocalDate;

@Getter
@CpfObrigatorioSeMaiorDeIdade
public class Dependente{

    @NonNull private final PessoaFisica provedor;
    @NotNull private final Parentesco parentesco;
    @NotNull private String nome;
    @NotNull private String sobreNome;
    @NotNull private LocalDate nascimento;
    @Null private String cpf;
    @NotNull private Endereco endereco;

    public Dependente(@NotNull PessoaFisica provedor,
                      @NotBlank String nome,
                      @NotBlank String sobreNome,
                      @NotNull LocalDate nascimento,
                      @Null String cpf,
                      @NotNull Parentesco parentesco,
                      @NotNull Endereco endereco) {
        this.provedor = provedor;
        this.parentesco = parentesco;
    }

    protected String criarId() {
        return "DEP-" + provedor.getId() + "-" + parentesco.name();
    }
}
