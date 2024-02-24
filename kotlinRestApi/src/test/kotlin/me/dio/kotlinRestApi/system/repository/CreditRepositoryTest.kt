package me.dio.kotlinRestApi.system.repository

import me.dio.kotlinRestApi.system.entity.Address
import me.dio.kotlinRestApi.system.entity.Credit
import me.dio.kotlinRestApi.system.entity.Customer
import org.assertj.core.api.Assertions
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager
import org.springframework.test.context.ActiveProfiles
import java.math.BigDecimal
import java.time.LocalDate
import java.time.Month
import java.util.*


@ActiveProfiles("test")
@DataJpaTest
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
class CreditRepositoryTest {
    @Autowired
    lateinit var creditRepository: CreditRepository

    @Autowired
    lateinit var testEntityManager: TestEntityManager

    private lateinit var customer: Customer
    private lateinit var credit1: Credit
    private lateinit var credit2: Credit

    @BeforeEach
    fun setup() {
        customer = testEntityManager.persist(buildCustomer())
        credit1 = testEntityManager.persist(
            buildCredit(
                customer = customer,
                creditCode = UUID.fromString("aa547c0f-9a6a-451f-8c89-afddce916a29")
            )
        )
        credit2 = testEntityManager.persist(
            buildCredit(
                customer = customer,
                creditCode = UUID.fromString("49f740be-46a7-449b-84e7-ff5b7986d7ef")
            )
        )
    }

    @Test
    fun `should find credit by credit code`() {
        //when
        val fakeCredit1: Credit = creditRepository.findByCreditCode(this.credit1.creditCode)!!
        val fakeCredit2: Credit = creditRepository.findByCreditCode(this.credit2.creditCode)!!
        //then
        Assertions.assertThat(fakeCredit1).isNotNull
        Assertions.assertThat(fakeCredit2).isNotNull
        Assertions.assertThat(fakeCredit1).isSameAs(credit1)
        Assertions.assertThat(fakeCredit2).isSameAs(credit2)
    }

    @Test
    fun `should find all credits by customer id`() {
        //given
        val customerId: Long = this.customer.id!!

        //when
        val creditList: List<Credit> = creditRepository.findAllByCustomerId(customerId)
        //then
        Assertions.assertThat(creditList).isNotEmpty
        Assertions.assertThat(creditList.size).isEqualTo(2)
        Assertions.assertThat(creditList).contains(credit1, credit2)
    }

    private fun buildCredit(
        creditCode: UUID = UUID.randomUUID(),
        creditValue: BigDecimal = BigDecimal.valueOf(500.0),
        dayOfFirstInstallment: LocalDate = LocalDate.of(2023, Month.APRIL, 22),
        numberOfInstallments: Int = 5,
        customer: Customer,
    ): Credit = Credit(
        creditCode = creditCode,
        creditValue = creditValue,
        dayOfFirstInstallment = dayOfFirstInstallment,
        numberOfInstallments = numberOfInstallments,
        customer = customer
    )

    private fun buildCustomer(
        firstName: String = "Cami",
        lastName: String = "Cavalcante",
        cpf: String = "28475934625",
        email: String = "camila@gmail.com",
        password: String = "12345",
        zipCode: String = "12345",
        number: Int = 123,
        street: String = "Rua da Cami",
        income: BigDecimal = BigDecimal.valueOf(1000.0),
//        id: Long = 1L,
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
//        id = id,
        income = income,
    )

}


