package me.dio.kotlinRestApi.system.entity.dto.request

import jakarta.validation.constraints.NotEmpty
import jakarta.validation.constraints.NotNull
import jakarta.validation.constraints.Positive
import me.dio.kotlinRestApi.system.entity.Address
import me.dio.kotlinRestApi.system.entity.Customer
import java.io.Serializable
import java.math.BigDecimal


data class CustomerDto(
    @field:NotEmpty
    val firstName: String,
    @field:NotEmpty
    val lastName: String,
    @field:NotEmpty
    val cpf: String,
    @field:NotEmpty //@Email
    val email: String,
    @field:NotEmpty
    val password: String,
    @field:NotEmpty
    val street: String,
    @field:NotEmpty
    val zipCode: String,
    @field:Positive
    val number: Int?,
    @field:NotNull @field:Positive
    val income: BigDecimal,
) : Serializable {

    // Create a new Customer from DTO
    fun toEntity(): Customer = Customer(
        firstName = this.firstName,
        lastName = this.lastName,
        cpf = this.cpf,
        email = this.email,
        password = this.password,
        address = Address(
            street = this.street,
            zipCode = this.zipCode,
            number = this.number
        ),
        income = this.income
    )

}