package me.dio.kotlinRestApi.system.service.dto.request

import ValidDateRange
import jakarta.validation.constraints.*
import me.dio.kotlinRestApi.system.service.entity.Credit
import me.dio.kotlinRestApi.system.service.entity.Customer
import java.io.Serializable
import java.math.BigDecimal
import java.time.LocalDate

/**
 * DTO for {@link me.dio.kotlinRestApi.system.service.entity.Credit}
 */
data class CreditDto(
    @field:NotNull @field:Positive
    val customerId: Long,
    @field:NotNull @field:Positive
    val creditValue: BigDecimal,
    @field:NotNull @field:Positive @field:Max(48) @field:Min(1)
    val numberOfInstallments: Int,
    @field:NotNull @field:FutureOrPresent @field:ValidDateRange(3,unit="MONTHS")
    val dayOfFirstInstallment: LocalDate
) : Serializable{
    // Create a new Credit for an existing Customer
    fun toEntity(): Credit =Credit(
        creditValue = this.creditValue,
        customer = Customer(id = this.customerId),
        numberOfInstallments = this.numberOfInstallments,
        dayOfFirstInstallment = this.dayOfFirstInstallment
    )
}