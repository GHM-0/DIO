package org.example.core.domain.cliente;

/**
 * Define o contrato para um titular no sistema.
 */
public interface ITitular {
    String getId();                                             // Deve estar registrado no Sistema
    String getIdentificador();                                  // Deve ser identificável
    String getNomeCompleto();                                   // Deve retornar a identificação nominal completa
    ClienteStatus getStatus();                                  // Deve possuir status compatível
    boolean isAtivo();                                          // ? Estado ATivo parece uma violação
}