package me.dio.kotlinRestApi.system.entity.dto.response

import jakarta.validation.constraints.NotNull
import jakarta.validation.constraints.Positive
import me.dio.kotlinRestApi.system.entity.Credit
import java.io.Serializable
import java.math.BigDecimal
import java.util.*


data class CreditsViewListDto(
    @field:NotNull
    val creditCode: UUID,
    @field:NotNull @field:Positive
    val creditValue: BigDecimal,
    @field:Positive
    val numberOfInstallments: Int,
) : Serializable {

    constructor(credit: Credit) : this(
        creditCode = credit.creditCode,
        creditValue = credit.creditValue,
        numberOfInstallments = credit.numberOfInstallments,
    )
}