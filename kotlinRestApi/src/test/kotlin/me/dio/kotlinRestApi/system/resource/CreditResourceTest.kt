package me.dio.kotlinRestApi.system.resource

import com.fasterxml.jackson.databind.ObjectMapper
import me.dio.kotlinRestApi.system.entity.Address
import me.dio.kotlinRestApi.system.entity.Credit
import me.dio.kotlinRestApi.system.entity.Customer
import me.dio.kotlinRestApi.system.entity.dto.request.CreditDto
import me.dio.kotlinRestApi.system.repository.CreditRepository
import me.dio.kotlinRestApi.system.repository.CustomerRepository
import org.junit.jupiter.api.AfterEach
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.http.MediaType
import org.springframework.test.context.ActiveProfiles
import org.springframework.test.context.ContextConfiguration
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders
import org.springframework.test.web.servlet.result.MockMvcResultHandlers
import org.springframework.test.web.servlet.result.MockMvcResultMatchers
import java.math.BigDecimal
import java.time.LocalDate

@SpringBootTest
@ActiveProfiles("test")
@AutoConfigureMockMvc
@ContextConfiguration
class CreditResourceTest {
    @Autowired
    private lateinit var customerRepository: CustomerRepository

    @Autowired
    private lateinit var creditRepository: CreditRepository

    @Autowired
    private lateinit var mockMvc: MockMvc

    @Autowired
    private lateinit var objectMapper: ObjectMapper

    private lateinit var customer: Customer
    private lateinit var credit1: CreditDto
    private lateinit var credit2: CreditDto


    @BeforeEach
    fun setup() {
        customerRepository.deleteAll()
        creditRepository.deleteAll()
        customer = buildCustomer()
        customerRepository.save(customer)
        credit1 = buildCreditDto(
            customerId = customer.id!!,
            creditValue = BigDecimal.valueOf(200.0)
        )
        creditRepository.save(credit1.toEntity())
        credit2 = buildCreditDto(
            customerId = customer.id!!,
            creditValue = BigDecimal.valueOf(2045.0)
        )
        creditRepository.save(credit2.toEntity())
    }

    @AfterEach
    fun tearDown() {
        customerRepository.deleteAll()
        creditRepository.deleteAll()
    }

    companion object {
        const val URL: String = "/api/credits"

        fun buildCustomer(
            firstName: String = "Cami",
            lastName: String = "Cavalcante",
            cpf: String = "0993732874646",
            email: String = "camila@gmail.com",
            password: String = "12345",
            zipCode: String = "12345",
            street: String = "Rua da Cami",
            number: Int? = 12,
            id: Long = 1L,
            income: BigDecimal = BigDecimal.valueOf(1000.0),
        ): Customer = Customer(
            firstName = firstName,
            lastName = lastName,
            cpf = cpf,
            email = email,
            password = password,
            id = id,
            address = Address(
                zipCode = zipCode,
                street = street,
                number = number
            ),
            income = income
        )

        fun buildCreditDto(
            creditValue: BigDecimal = BigDecimal.valueOf(1000.0),
            dayOfFirstInstallment: LocalDate = LocalDate.now().plusMonths(3L),
            numberOfInstallments: Int = 15,
            customerId: Long = 1L,

            ): CreditDto = CreditDto(
            creditValue = creditValue,
            dayOfFirstInstallment = dayOfFirstInstallment,
            numberOfInstallments = numberOfInstallments,
            customerId = customerId
        )
    }


    @Test
    fun `should create a new credit and return STATUS 201`() {
        //given
        val credit3: CreditDto = buildCreditDto(customerId = customer.id!!, creditValue = BigDecimal.valueOf(1200.0))
        val stringCredit: String = objectMapper.writeValueAsString(credit3)

        //when //then
        mockMvc.perform(
            MockMvcRequestBuilders.post(URL)
                .contentType(MediaType.APPLICATION_JSON)
                .content(stringCredit)
        )
            .andExpect(MockMvcResultMatchers.status().isCreated)
            .andDo(MockMvcResultHandlers.print())

    }

    @Test
    fun `should not create a new credit with customerId and return STATUS 400`() {
        //given
        val credit3: CreditDto = buildCreditDto(customerId = 333L, creditValue = BigDecimal.valueOf(1200.0))
        val stringCredit: String = objectMapper.writeValueAsString(credit3)

        //when //then
        mockMvc.perform(
            MockMvcRequestBuilders.post(URL)
                .contentType(MediaType.APPLICATION_JSON)
                .content(stringCredit)
        )
            .andExpect(MockMvcResultMatchers.status().isBadRequest)
            .andExpect(
                MockMvcResultMatchers.jsonPath("$.exception")
                    .value("class me.dio.kotlinRestApi.system.exception.BusinessException")
            )
            .andExpect(MockMvcResultMatchers.jsonPath("$.details[*]").isNotEmpty)
            .andDo(MockMvcResultHandlers.print())
    }

    @Test
    fun `should find all credits with valid customerId and return STATUS 200`() {
        //given
        val customerId: Long = customer.id!!
        //when //then
        mockMvc.perform(
            MockMvcRequestBuilders.get("$URL?customerId=${customerId}")
                .accept(MediaType.APPLICATION_JSON)
        )
            .andExpect(MockMvcResultMatchers.status().isOk)
            .andExpect(MockMvcResultMatchers.jsonPath("$").isArray())
            .andExpect(MockMvcResultMatchers.jsonPath("$.length()").value(2))
            .andDo(MockMvcResultHandlers.print())

    }

    @Test
    fun `should not find any credit with invalid customerId and return STATUS 400`() {
        val customerId: Long = 300L
        //when //then
        mockMvc.perform(
            MockMvcRequestBuilders.get("$URL?customerId=${customerId}")
                .accept(MediaType.APPLICATION_JSON)
        )
            .andExpect(MockMvcResultMatchers.status().isNotFound)
            .andDo(MockMvcResultHandlers.print())
    }

    @Test
    fun `should find a credit by valid creditCode and customerId with return STATUS 200`() {
        val credit3: CreditDto = buildCreditDto(customerId = customer.id!!, creditValue = BigDecimal.valueOf(1200.0))
        val saveCredit3: Credit = creditRepository.save(credit3.toEntity())
        val creditCode = saveCredit3.creditCode

        mockMvc.perform(
            MockMvcRequestBuilders.get("$URL/${creditCode}?customerId=${credit3.customerId}")
                .accept(MediaType.APPLICATION_JSON)
        )
            .andExpect(MockMvcResultMatchers.status().isOk)
            .andDo(MockMvcResultHandlers.print())
    }

//    @Test
//    fun `should not find a credit by valid creditId and invalid customerId with return STATUS 400`() {
//        val credit3: CreditDto = buildCreditDto(customerId = customer.id!!, creditValue = BigDecimal.valueOf(1200.0))
//        val saveCredit3: Credit = creditRepository.save(credit3.toEntity())
//        val creditCode = saveCredit3.creditCode
//
//        mockMvc.perform(
//            MockMvcRequestBuilders.get("$URL/${creditCode}?customerId=${300L}")
//                .accept(MediaType.APPLICATION_JSON)
//        )
//            .andExpect(MockMvcResultMatchers.status().isBadRequest)
//            .andExpect(
//                MockMvcResultMatchers.jsonPath("$.exception")
//                    .value("class java.lang.IllegalArgumentException")
//            )
//            .andExpect(MockMvcResultMatchers.content().string(CoreMatchers.containsString("Contact Admin")))
//            .andDo(MockMvcResultHandlers.print())
//    }

}