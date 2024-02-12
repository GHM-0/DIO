package me.dio.kotlinRestApi.system.repository

import me.dio.kotlinRestApi.system.service.entity.Credit
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface CreditRepository: JpaRepository<Credit,Long> {
    fun findByCreditCode(creditCode:UUID): Credit?

    @Query(value="SELECT * FROM credits WHERE customer_id=?1", nativeQuery = true)
    fun findAllByCustomer(customerId:Long):List<Credit>
}