package org.example.core.domain.cliente;

public class ClienteInativo implements EstadoCliente{
    @Override
    public void desativar(Cliente cliente) {
        throw new IllegalStateException("Cliente já está inativo");
    }

    // Estados Transicionaveis
    @Override
    public void ativar(Cliente cliente) {
        cliente.setEstado(new ClienteAtivo());
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
        return ClienteStatus.INATIVO;
    }
}
