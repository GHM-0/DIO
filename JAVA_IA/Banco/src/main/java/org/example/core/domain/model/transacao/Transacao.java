package org.example.core.domain.transacao;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;

import java.math.BigDecimal;

public abstract class Transacao implements ITransacionavel{
    private String Tipo = "Generica";

    public abstract TransacaoResultado operation(@NotNull ITransacionavel destino,
                                                 @NotNull @DecimalMin(value = "0.01", inclusive = true) BigDecimal valor);

}
