package org.example.core.domain.conta;

import org.example.core.domain.cliente.Cliente;

public class ContaPoupanca extends Conta{
    public ContaPoupanca(Cliente titular){
        super(titular);
    }

    @Override
    protected Integer criarId() {
        // TODO
        return 1;
    }

}
