package org.example.domain.conta;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;


import org.example.domain.cliente.Cliente;

import java.time.LocalDateTime;

@Getter
public abstract class Conta {


    public static Integer num_contas = 0;

    @NotNull
    protected Cliente titular;

    @NotNull
    protected double saldo;

    @NotNull
    public Integer id;

    @NotNull
    public LocalDateTime criacao;

    public Conta(@NotNull Cliente titular){
        this.titular=titular;
        this.id = ++num_contas;
        this.criacao = LocalDateTime.now();
    }

    public String getTitular(){
        return this.titular.id;
    }

    @Override
    public String toString(){
        return "Conta [ "+this.getClass().getSimpleName()+
                ". Titular="+this.getTitular()+
                ", Saldo="+this.saldo+
                ", Criação="+this.criacao+
                "]";
    }

    private boolean Sacar(double valor){
        //valor não nulo, não negativo não igual a zero
        if(valor>0){
            if(this.saldo >= valor){
                this.saldo -= valor;
                //write.log    Saque autorizado
                return true;
            }else {
                //write.log    Valor superior ao saldo
                return false;
            }
        }
        //write.log   Valor Invalido
        return false;
    }

    private boolean Depositar(double valor){
        //valor positivo, não igual a zero
        if(valor>0){
            this.saldo+=valor;
            // write.log Deposito Efetuado
            return true;
        }
        // valor invalido para deposito
        return false;
    }

    // Log function
}
