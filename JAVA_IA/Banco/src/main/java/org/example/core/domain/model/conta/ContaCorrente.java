package org.example.core.domain.conta;

import org.example.core.domain.cliente.Cliente;

public class ContaCorrente extends Conta {
    public ContaCorrente(Cliente titular){
        super(titular);
    }

    @Override
    protected Integer criarId() {
        // TODO
        return 2;
    }
}
