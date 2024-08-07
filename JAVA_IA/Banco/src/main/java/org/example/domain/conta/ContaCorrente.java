package org.example.domain.conta;

import org.example.domain.cliente.Cliente;

public class ContaCorrente extends Conta {
    public ContaCorrente(Cliente titular){
        super(titular);
    }
}
