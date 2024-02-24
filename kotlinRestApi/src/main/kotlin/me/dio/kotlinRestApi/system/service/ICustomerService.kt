package me.dio.kotlinRestApi.system.service

import me.dio.kotlinRestApi.system.entity.Customer
import org.springframework.stereotype.Service

@Service
interface ICustomerService {
    fun save(customer: Customer): Customer
    fun findById(customerId: Long): Customer
    fun deleteById(customerId: Long)
}