package org.example.core.domain.transacao;

import org.example.core.domain.conta.Conta;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class TransacaoResultado {
    public TransacaoResultado(boolean status, String mensagem, Conta conta, LocalDateTime now, BigDecimal valor) {
    }
}
