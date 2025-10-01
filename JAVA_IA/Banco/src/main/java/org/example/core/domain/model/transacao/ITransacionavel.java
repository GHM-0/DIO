package org.example.core.domain.transacao;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;

import java.math.BigDecimal;

public interface ITransacionavel{

    TransacaoResultado operation(@NotNull ITransacionavel destino,
                                 @NotNull @DecimalMin(value = "0.01", inclusive = true)  BigDecimal valor);

}
