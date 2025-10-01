package org.example.core.domain.local.agencia;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.example.core.domain.local.Endereco;

import java.time.LocalDateTime;
import java.util.Objects;

@Getter
public class Agencia {
    private static int agencias = 0;

    @Setter @NotNull  private Endereco endereco;
    @NotNull private final Integer id;
    private final LocalDateTime criacao;
    private AgenciaStatus status;

    // Método Auxiliar de criação
    private static synchronized int gerarNumeroAgencia() {
        return ++agencias;
    }

    // Criação
    public Agencia(@NotNull Endereco endereco) {
        this.id = gerarNumeroAgencia();
        this.endereco = Objects.requireNonNull(endereco);
        this.criacao=LocalDateTime.now();
        this.status=AgenciaStatus.ATIVA;
    }
}
