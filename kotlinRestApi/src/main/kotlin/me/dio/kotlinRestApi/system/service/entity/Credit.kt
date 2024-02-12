package me.dio.kotlinRestApi.system.service.entity

import jakarta.persistence.*
import java.math.BigDecimal
import java.time.LocalDate
import java.util.*

@Entity
@Table(name="credits")
data class Credit(
    @Column(nullable=false,unique = true)
    val creditCode:UUID= UUID.randomUUID(),
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id:Long?=null,
    @JoinColumn(nullable=false) @ManyToOne
    var customer: Customer?=null,
    @Column(nullable=false)
    val creditValue:BigDecimal=BigDecimal.ZERO,
    @Column(nullable=false)
    val numberOfInstallments:Int,
    @Column(nullable=false)
    val dayOfFirstInstallment:LocalDate,
    @Column(nullable=false, columnDefinition = "ENUM('IN_PROGRESS', 'APPROVED', 'REJECTED') NOT NULL DEFAULT 'IN_PROGRESS'") @Enumerated(EnumType.STRING)
    var status: Status = Status.IN_PROGRESS
) {


    // Customer Exist em outra classe DTO
    // Até 48 parcelas numberOfInstallments
    // Até 3 mêses apois a data da solicitação dayFirstInstallment
}