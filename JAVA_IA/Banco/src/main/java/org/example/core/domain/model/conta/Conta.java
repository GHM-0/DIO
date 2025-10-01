package org.example.core.domain.conta;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.example.core.domain.cliente.Cliente;
import org.example.core.domain.conta.rules.RestricaoConta;
import org.example.core.domain.transacao.TransacaoResultado;
import org.example.core.domain.transacao.rules.RestricaoTransacao;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
public abstract class Conta {

    @NotNull protected Cliente titular;

    @Setter @NotNull protected BigDecimal saldo = BigDecimal.ZERO;

    @NotNull protected Integer id;

    @NotNull protected Integer idAgencia;

    @NotNull public LocalDateTime criacao;

    @NotNull @Setter protected boolean status;

    protected Conta(@NotNull Cliente titular){
        this.titular=titular;
        this.id = criarId();
        this.criacao = LocalDateTime.now();
        this.status = true;
    }

    @Override
    public String toString(){

        return "Conta [ "+this.getClass().getSimpleName()+
                ". Titular="+getTitular().getIdNominal()+" "+
                    getTitular().getIdSupraNominal()+
                ", Saldo="+this.saldo+
                ", Criação="+this.criacao+
                "]";
    }

    protected abstract Integer criarId();

    // TODO Restrições de Bloqueio -> Definir status = false
    @RestricaoConta
    protected boolean statusConta(){
        return status;
    }

    @RestricaoTransacao
    public TransacaoResultado Depositar(BigDecimal valor){
        String mensagem="";

        boolean checkValor = valor.compareTo(BigDecimal.ZERO)>0;
        boolean status = checkValor && this.status;

        if(!this.status){
            mensagem += "Conta Bloqueada";
        }
        if(checkValor){
            this.saldo = this.saldo.add(valor);
            mensagem += "Realizado com sucesso";
        }else{
            mensagem += "Argumento invalido, Valor Menor ou Igual a Zero";
        }

       return new TransacaoResultado(status,mensagem,this,LocalDateTime.now(),valor);
    }

    @RestricaoTransacao
    public TransacaoResultado Sacar(BigDecimal valor){
        String mensagem="";

        boolean checkValor = valor.compareTo(BigDecimal.ZERO)>0;
        boolean checkSaldo = saldo.compareTo(valor) >= 0;

        boolean status = (checkValor && checkSaldo) && this.status ;

        if(!this.status){
            mensagem += "Conta Bloqueada";
        }

        if(status){
                this.saldo= this.saldo.subtract(valor);
                mensagem += "Saque realizado com sucesso";
        }else{
            mensagem +="Erro Interno: ";
        }

        if (!checkValor) {
            mensagem += "Argumento invalido, Valor Menor ou Igual a Zero";
        }

        if(!checkSaldo){
            mensagem += "Saldo Insuficiente";
        }

        return new TransacaoResultado(status,mensagem,this,LocalDateTime.now(),valor);
    }
}
