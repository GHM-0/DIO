package me.dio.kotlinRestApi.system.service

import me.dio.kotlinRestApi.system.service.entity.Credit
import org.springframework.stereotype.Service
import java.util.*

@Service
interface ICreditService {
    fun save(credit: Credit): Credit
    fun findAllByCustomer(customerId:Long):List<Credit>
    fun findByCreditCode(customerId: Long,creditCode: UUID): Credit
}