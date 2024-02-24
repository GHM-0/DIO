package me.dio.kotlinRestApi.system.entity.dto.response

import jakarta.validation.constraints.NotBlank
import jakarta.validation.constraints.NotEmpty
import jakarta.validation.constraints.NotNull
import jakarta.validation.constraints.Positive
import me.dio.kotlinRestApi.system.entity.Customer
import java.io.Serializable
import java.math.BigDecimal


data class CustomerViewDto(
    @field:NotNull @field:NotEmpty @field:NotBlank
    val firstName: String,
    @field:NotNull @field:NotEmpty @field:NotBlank
    val lastName: String,
    @field:NotNull @field:NotEmpty @field:NotBlank
    val cpf: String,
    @field:NotNull @field:NotEmpty @field:NotBlank
    val email: String,
    @field:NotNull @field:NotEmpty @field:NotBlank
    val street: String,
    @field:NotNull @field:NotEmpty @field:NotBlank
    val zipCode: String,
    @field:NotNull @field:Positive
    val income: BigDecimal,
    @field:NotNull @field:Positive
    val id: Long?,
) : Serializable {

    // View non-sensitive data of an existing Customer
    constructor(customer: Customer) : this(
        firstName = customer.firstName,
        lastName = customer.lastName,
        cpf = customer.cpf,
        email = customer.email,
        street = customer.address.street,
        zipCode = customer.address.zipCode,
        income = customer.income,
        id = customer.id
    )
}