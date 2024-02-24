package me.dio.kotlinRestApi.system.service

import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.verify
import me.dio.kotlinRestApi.system.entity.Credit
import me.dio.kotlinRestApi.system.entity.Customer
import me.dio.kotlinRestApi.system.entity.Status
import me.dio.kotlinRestApi.system.exception.BusinessException
import me.dio.kotlinRestApi.system.repository.CreditRepository
import me.dio.kotlinRestApi.system.service.impl.CreditService
import me.dio.kotlinRestApi.system.service.impl.CustomerService
import org.assertj.core.api.Assertions
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith
import org.springframework.test.context.junit.jupiter.SpringExtension
import java.math.BigDecimal
import java.time.LocalDate
import java.util.*


//@ExtendWith(MockKExtension::class)
@ExtendWith(SpringExtension::class)
class CreditServiceTest {
    @MockK
    lateinit var creditRepository: CreditRepository

    @MockK
    lateinit var customerService: CustomerService

    @InjectMockKs
    lateinit var creditService: CreditService

    @Test
    fun `should create a credit `() {
        //given
        val fakeCredit: Credit = buildCredit()
        val customerId: Long = fakeCredit.customer!!.id!!

        every { customerService.findById(customerId) } returns fakeCredit.customer!!
        every { creditRepository.save(fakeCredit) } returns fakeCredit

        //when
        val actual: Credit = creditService.save(fakeCredit)

        //then
        verify(exactly = 1) { customerService.findById(customerId) }
        verify(exactly = 1) { creditRepository.save(fakeCredit) }

        Assertions.assertThat(actual).isNotNull
        Assertions.assertThat(actual).isSameAs(fakeCredit)
    }

    @Test
    fun `should return list of credits for a customer`() {
        //given
        val customerId: Long = 1L
        val expectedCredits: List<Credit> = listOf(buildCredit(), buildCredit(), buildCredit())

        every { creditRepository.findAllByCustomerId(customerId) } returns expectedCredits
        //when
        val actual: List<Credit> = creditService.findAllByCustomer(customerId)
        //then
        Assertions.assertThat(actual).isNotNull
        Assertions.assertThat(actual).isNotEmpty
        Assertions.assertThat(actual).isSameAs(expectedCredits)

        verify(exactly = 1) { creditRepository.findAllByCustomerId(customerId) }
    }

    @Test
    fun `should return credit for a valid customer and credit code`() {
        //given
        val customerId: Long = 1L
        val creditCode: UUID = UUID.randomUUID()
        val credit: Credit = buildCredit(customer = Customer(id = customerId))

        every { creditRepository.findByCreditCode(creditCode) } returns credit
        //when
        val actual: Credit = creditService.findByCreditCode(customerId, creditCode)
        //then
        Assertions.assertThat(actual).isNotNull
        Assertions.assertThat(actual).isSameAs(credit)

        verify(exactly = 1) { creditRepository.findByCreditCode(creditCode) }
    }

    @Test
    fun `should throw BusinessException for invalid credit code`() {
        //given
        val customerId: Long = 1L
        val invalidCreditCode: UUID = UUID.randomUUID()

        every { creditRepository.findByCreditCode(invalidCreditCode) } returns null
        //when
        //then
        Assertions.assertThatThrownBy { creditService.findByCreditCode(customerId, invalidCreditCode) }
            .isInstanceOf(BusinessException::class.java)
            .hasMessage("Credit code $invalidCreditCode doest exist")
        //then
        verify(exactly = 1) { creditRepository.findByCreditCode(invalidCreditCode) }
    }

    @Test
    fun `should throw IllegalArgumentException for different customer ID`() {
        //given
        val customerId: Long = 1L
        val creditCode: UUID = UUID.randomUUID()
        val credit: Credit = buildCredit(customer = Customer(id = 2L))

        every { creditRepository.findByCreditCode(creditCode) } returns credit
        //when
        //then
        Assertions.assertThatThrownBy { creditService.findByCreditCode(customerId, creditCode) }
            .isInstanceOf(IllegalArgumentException::class.java)
            .hasMessage("Contact Admin")

        verify { creditRepository.findByCreditCode(creditCode) }
    }

    companion object {
        fun buildCredit(
            creditCode: UUID = UUID.randomUUID(),
            id: Long = 1L,
            creditValue: BigDecimal = BigDecimal.valueOf(1000.0),
            dayOfFirstInstallment: LocalDate = LocalDate.now().plusMonths(3L),
            numberOfInstallments: Int = 15,
            customer: Customer = CustomerServiceTest.buildCustomer(),
            status: Status = Status.IN_PROGRESS,
        ): Credit = Credit(
            creditCode = creditCode,
            id = id,
            status = status,
            creditValue = creditValue,
            dayOfFirstInstallment = dayOfFirstInstallment,
            numberOfInstallments = numberOfInstallments,
            customer = customer
        )
    }
}
