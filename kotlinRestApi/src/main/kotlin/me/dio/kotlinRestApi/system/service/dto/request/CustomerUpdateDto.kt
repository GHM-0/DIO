package me.dio.kotlinRestApi.system.service.dto.request

import jakarta.validation.constraints.Positive
import me.dio.kotlinRestApi.system.service.entity.Customer
import java.io.Serializable
import java.math.BigDecimal

/**
 * DTO for {@link me.dio.kotlinRestApi.system.service.entity.Customer}
 */
data class CustomerUpdateDto(
    val firstName: String,
    val lastName: String,
    val zipCode:String,
    val street:String,
    @field:Positive
    val income: BigDecimal,
) : Serializable{

    // Update an existing Customer
    fun toEntity(customer: Customer): Customer{
        customer.firstName=this.firstName
        customer.lastName=this.lastName
        customer.income=this.income
        customer.address.street=this.street
        customer.address.zipCode=this.zipCode

        return customer
    }

}