package org.example.core.domain.cliente;

public class ClienteAtivo implements EstadoCliente {

    @Override
    public void ativar(Cliente cliente) {
        throw new IllegalStateException("Cliente já está ativo");
    }

    // Estados Transicionaveis

    @Override
    public void desativar(Cliente cliente) {
        cliente.setEstado(new ClienteInativo());
    }

    @Override
    public void bloquear(Cliente cliente) {
        cliente.setEstado(new ClienteBloqueado());
    }


    @Override
    public void extinguir(Cliente cliente) {
        cliente.setEstado(new ClienteExtinto());
    }

    @Override
    public ClienteStatus getStatus() {
        return ClienteStatus.ATIVO;
    }
}

