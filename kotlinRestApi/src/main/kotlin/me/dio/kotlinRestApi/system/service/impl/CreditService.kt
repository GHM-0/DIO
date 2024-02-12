package me.dio.kotlinRestApi.system.service.impl

import me.dio.kotlinRestApi.system.repository.CreditRepository
import me.dio.kotlinRestApi.system.service.ICreditService
import me.dio.kotlinRestApi.system.service.entity.Credit
import org.springframework.stereotype.Service
import java.util.*

@Service
class CreditService(
    private val creditRepository:CreditRepository,
    private val customerService: CustomerService
): ICreditService {
    override fun save(credit: Credit): Credit {
        credit.apply {
            //customerService.run { findById(credit.customer?.id!!) }
            customer=customerService.findById(credit.customer?.id!!)
        }
        return this.creditRepository.save(credit)
    }

    override fun findAllByCustomer(customerId: Long): List<Credit> =
        this.creditRepository.findAllByCustomer(customerId)

    override fun findByCreditCode(customerId: Long,creditCode: UUID): Credit {
        val credit: Credit =(
                this.creditRepository.findByCreditCode(creditCode)?:throw RuntimeException("Credit code $creditCode doest exist")
                )
        return if(credit.customer?.id==customerId) credit else throw RuntimeException("Contact Admin")
    }
}