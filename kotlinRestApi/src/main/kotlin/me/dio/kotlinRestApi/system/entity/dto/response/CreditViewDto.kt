package me.dio.kotlinRestApi.system.entity.dto.response

import jakarta.validation.constraints.NotNull
import me.dio.kotlinRestApi.system.entity.Credit
import me.dio.kotlinRestApi.system.entity.Status
import java.io.Serializable
import java.math.BigDecimal
import java.util.*

/**
 * DTO for {@link me.dio.kotlinRestApi.system.service.entity.Credit}
 */
data class CreditViewDto(
    @field:NotNull
    val creditCode: UUID,
    @field:NotNull
    val creditValue: BigDecimal,
    @field:NotNull
    val numberOfInstallments: Int,
    @field:NotNull
    val status: Status,
) : Serializable {
    constructor(credit: Credit) : this(
        creditCode = credit.creditCode,
        creditValue = credit.creditValue,
        numberOfInstallments = credit.numberOfInstallments,
        status = credit.status
    )
}