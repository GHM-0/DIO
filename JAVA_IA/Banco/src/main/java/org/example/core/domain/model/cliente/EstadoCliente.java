package org.example.core.domain.cliente;

public interface EstadoCliente {
    default void ativar(Cliente cliente){
        throw new UnsupportedOperationException("Ativar não permitido neste estado");
    }
    default void desativar(Cliente cliente){
        throw new UnsupportedOperationException("Desativar não permitido neste estado");
    }
    default void bloquear(Cliente cliente){
        throw new UnsupportedOperationException("Bloquear não permitido neste estado");
    }
    default void extinguir(Cliente cliente){
        throw new UnsupportedOperationException("Extinguir não é permitido neste estado");
    }

    ClienteStatus getStatus();
}
