package org.example.core.domain.cliente;

public class ClienteExtinto implements EstadoCliente{
    @Override
    public void extinguir(Cliente cliente) {
        throw new IllegalStateException("Cliente já está extinto");
    }

    // Estado Não transicionaveis

    @Override
    public void ativar(Cliente cliente) {
        // cliente.setEstado(new ClienteAtivo());
        throw new IllegalStateException("Cliente extinto não pode ser ativado.");
    }

    @Override
    public void desativar(Cliente cliente) {
        // cliente.setEstado(new ClienteAtivo());
        throw new IllegalStateException("Cliente extinto não pode ser desativado.");
    }

    @Override
    public void bloquear(Cliente cliente) {
        // cliente.setEstado(new ClienteBloqueado());
        throw new IllegalStateException("Cliente extinto não pode ser bloqueado.");
    }

    @Override
    public ClienteStatus getStatus() {
        return ClienteStatus.EXTINTO;
    }
}
