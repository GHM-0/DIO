package me.dio.kotlinRestApi.system.entity.dto.request

import jakarta.validation.constraints.NotEmpty
import jakarta.validation.constraints.Positive
import me.dio.kotlinRestApi.system.entity.Customer
import java.io.Serializable
import java.math.BigDecimal


data class CustomerUpdateDto(
    val firstName: String,
    val lastName: String,
    val zipCode: String,
    @field:NotEmpty
    val street: String,
    @field:Positive
    val number: Int?,
    @field:Positive
    val income: BigDecimal,
) : Serializable {

    // Update an existing Customer
    fun toEntity(customer: Customer): Customer {
        customer.firstName = this.firstName
        customer.lastName = this.lastName
        customer.income = this.income
        customer.address.street = this.street
        customer.address.zipCode = this.zipCode
        customer.address.number = this.number

        return customer
    }

}