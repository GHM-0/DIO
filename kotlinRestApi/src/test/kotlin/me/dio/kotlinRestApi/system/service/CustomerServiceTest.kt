package me.dio.kotlinRestApi.system.service

import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.runs
import io.mockk.verify
import me.dio.kotlinRestApi.system.entity.Address
import me.dio.kotlinRestApi.system.entity.Customer
import me.dio.kotlinRestApi.system.exception.BusinessException
import me.dio.kotlinRestApi.system.repository.CustomerRepository
import me.dio.kotlinRestApi.system.service.impl.CustomerService
import org.assertj.core.api.Assertions
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith
import org.springframework.test.context.junit.jupiter.SpringExtension
import java.math.BigDecimal
import java.util.*

//@ExtendWith(MockKExtension::class)
@ExtendWith(SpringExtension::class)
class CustomerServiceTest {
    @MockK
    lateinit var customerRepository: CustomerRepository

    @InjectMockKs
    lateinit var customerService: CustomerService

    @Test
    fun `should save a customer`() {
        //given
        val fakeCustomer: Customer = buildCustomer()
        every { customerRepository.save(fakeCustomer) } returns fakeCustomer

        //when
        val actual: Customer = customerService.save(fakeCustomer)

        //then
        Assertions.assertThat(actual).isNotNull
        Assertions.assertThat(actual).isSameAs(fakeCustomer)
        verify(exactly = 1) { customerRepository.save(fakeCustomer) }
    }

    @Test
    fun `should find customer by id`() {
        //given
        val fakeId: Long = Random().nextLong()
        val fakeCustomer: Customer = buildCustomer(id = fakeId)
        every { customerRepository.findById(fakeId) } returns Optional.of(fakeCustomer)

        // when
        val actual: Customer = customerService.findById(fakeId)

        // then
        Assertions.assertThat(actual).isNotNull
        Assertions.assertThat(actual).isSameAs(fakeCustomer)
        Assertions.assertThat(actual).isExactlyInstanceOf(Customer::class.java)

        verify(exactly = 1) { customerRepository.findById(fakeId) }
    }

    @Test
    fun `should not find customer by invalid id and throw BusinessException`() {

        //given
        val fakeId: Long = Random().nextLong()
        every { customerRepository.findById(fakeId) } returns Optional.empty()

        //when //then

        Assertions.assertThatExceptionOfType(BusinessException::class.java)
            .isThrownBy { customerService.findById(fakeId) }
            .withMessage("Id $fakeId not found")

        verify(exactly = 1) { customerRepository.findById(fakeId) }

    }

    @Test
    fun `should delete a customer by Id`() {
        //given
        val fakeId: Long = Random().nextLong()
        val fakeCustomer: Customer = buildCustomer(id = fakeId)
        every { customerRepository.findById(fakeId) } returns Optional.of(fakeCustomer)
        every { customerRepository.delete(fakeCustomer) } just runs

        //when
        customerService.deleteById(fakeId)

        //then
        verify(exactly = 1) { customerRepository.findById(fakeId) }
        verify(exactly = 1) { customerRepository.delete(fakeCustomer) }
    }

    @Test
    fun `should delete a customer by invalid Id and throw BusinessException`() {
        //given
        val fakeId: Long = Random().nextLong()
        every { customerRepository.findById(fakeId) } returns Optional.empty()

        //when //then

        Assertions.assertThatExceptionOfType(BusinessException::class.java)
            .isThrownBy { customerService.deleteById(fakeId) }
            .withMessage("Id $fakeId not found")

        verify(exactly = 1) { customerRepository.findById(fakeId) }

    }

    companion object {
        fun buildCustomer(
            firstName: String = "Cami",
            lastName: String = "Cavalcante",
            cpf: String = "0993732874646",
            email: String = "camila@gmail.com",
            password: String = "12345",
            zipCode: String = "12345",
            street: String = "Rua da Cami",
            number: Int? = 12,
            income: BigDecimal = BigDecimal.valueOf(1000.0),
            id: Long = 1L,
        ) = Customer(
            firstName = firstName,
            lastName = lastName,
            cpf = cpf,
            email = email,
            password = password,
            address = Address(
                zipCode = zipCode,
                street = street,
                number = number
            ),
            income = income,
            id = id
        )
    }


}