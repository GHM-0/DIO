package org.example.domain.transacao;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Null;
import org.example.domain.conta.Conta;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public abstract class Transacao {

    public static Integer num_transacoes = 0;

    @NotNull
    public Integer transacao_id;

    @NotNull
    public LocalDateTime criacao;

    @NotNull
    public BigDecimal valor;
    @NotNull
    public Conta origem;
    @Null
    public Conta destino;

    // verificar interoperação Double / BigDecimal

    public Transacao(@NotNull BigDecimal valor,@NotNull Conta origem, @Null Conta destino){
        this.valor = valor;
        this.origem = origem;
        this.destino = (destino == null || destino == origem) ? origem : destino; // Mesmo Objeto
                   //  (destino == null || destino.equals(origem)) ? origem : destino; Equivalência lógica

        this.criacao = LocalDateTime.now();
        this.transacao_id = ++num_transacoes;
    }

    public abstract boolean operation();

    @Override
    public String toString(){
        return "Transacão [ "+this.getClass().getSimpleName()+
                "numero="+this.transacao_id+
                ", Origem= "+this.origem.getId()+
                ", Destino= "+this.destino.getId()+
                " valor="+this.valor+
                "]";
    }
}



