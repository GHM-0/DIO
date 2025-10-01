package org.example.core.domain.cliente;

public class ClienteBloqueado implements EstadoCliente{
    @Override
    public void bloquear(Cliente cliente) {
        throw new IllegalStateException("Cliente já está bloqueado");
    }

    // Estados Trasicionaveis

    @Override
    public void ativar(Cliente cliente) {
        cliente.setEstado(new ClienteAtivo());
    }

    @Override
    public void desativar(Cliente cliente) {
        cliente.setEstado(new ClienteInativo());
    }

    @Override
    public void extinguir(Cliente cliente) {
        cliente.setEstado(new ClienteExtinto());

    }

    @Override
    public ClienteStatus getStatus() {
        return ClienteStatus.BLOQUEADO;
    }
}
