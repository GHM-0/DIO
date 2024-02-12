package me.dio.kotlinRestApi.system.service.impl

import me.dio.kotlinRestApi.system.repository.CustomerRepository
import me.dio.kotlinRestApi.system.service.ICustomerService
import me.dio.kotlinRestApi.system.service.entity.Customer
import me.dio.kotlinRestApi.system.service.exception.BusinessException
import org.springframework.stereotype.Service

@Service
class CustomerService(
    private val customerRepository: CustomerRepository
) : ICustomerService {
    override fun save(customer: Customer): Customer =
        this.customerRepository.save(customer)

    override fun findById(customerId: Long): Customer =
        this.customerRepository.findById(customerId).
        orElseThrow{
       // throw RuntimeException
            throw BusinessException("Id $customerId not found")
    }

    override fun deleteById(customerId: Long) {
        val customer:Customer =this.customerRepository.findById(customerId)
            .orElseThrow {
                throw BusinessException("Id $customerId not found")
            }
        this.customerRepository.delete(customer)
    }
}