package me.dio.kotlinRestApi.system.resource

import com.fasterxml.jackson.databind.ObjectMapper
import me.dio.kotlinRestApi.system.entity.Customer
import me.dio.kotlinRestApi.system.entity.dto.request.CustomerDto
import me.dio.kotlinRestApi.system.entity.dto.request.CustomerUpdateDto
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

@SpringBootTest
@ActiveProfiles("test")
@AutoConfigureMockMvc
@ContextConfiguration
class CustomerResourceTest {
    @Autowired
    private lateinit var customerRepository: CustomerRepository

    @Autowired
    private lateinit var mockMvc: MockMvc

    @Autowired
    private lateinit var objectMapper: ObjectMapper

    companion object {
        const val URL: String = "/api/customers"

        fun buildCustomerDto(
            firstName: String = "Cami",
            lastName: String = "Cavalcante",
            cpf: String = "0993732874646",
            email: String = "camila@gmail.com",
            password: String = "12345",
            zipCode: String = "12345",
            street: String = "Rua da Cami",
            number: Int? = 12,
            income: BigDecimal = BigDecimal.valueOf(1000.0),
        ) = CustomerDto(
            firstName = firstName,
            lastName = lastName,
            cpf = cpf,
            email = email,
            password = password,
            zipCode = zipCode,
            street = street,
            number = number,
            income = income,
        )

        fun buildCustomerUpdateDto(
            firstName: String = "CamiUpdated",
            lastName: String = "CavalcanteUpdated",
            zipCode: String = "12345",
            street: String = "Rua da CamiUpdated",
            number: Int? = 12,
            income: BigDecimal = BigDecimal.valueOf(1000.0),
        ): CustomerUpdateDto = CustomerUpdateDto(
            firstName = firstName,
            lastName = lastName,
            zipCode = zipCode,
            street = street,
            number = number,
            income = income
        )

    }

    @BeforeEach
    fun setup() = customerRepository.deleteAll()

    @AfterEach
    fun tearDown() = customerRepository.deleteAll()

    @Test
    fun `should save a new customer and return a STATUS 201`() {
        //given
        val customerDto: CustomerDto = buildCustomerDto()
        val stringCustomer: String = objectMapper.writeValueAsString(customerDto)

        //when //then
        mockMvc.perform(
            MockMvcRequestBuilders.post(URL)
                .contentType(MediaType.APPLICATION_JSON)
                .content(stringCustomer)
        )
            .andExpect(MockMvcResultMatchers.status().isCreated)
            .andDo(MockMvcResultHandlers.print())
    }

    @Test
    fun `should not save a Custumer with a not unique fields dublication and return STATUS 409`() {
        //given
        //Already persisted user which will try to duplicate
        customerRepository.save(buildCustomerDto().toEntity())
        val customerDto: CustomerDto = buildCustomerDto()
        val stringCustomer: String = objectMapper.writeValueAsString(customerDto)

        //when //then
        mockMvc.perform(
            MockMvcRequestBuilders.post(URL)
                .contentType(MediaType.APPLICATION_JSON)
                .content(stringCustomer)
        )
            .andExpect(MockMvcResultMatchers.status().isConflict)
            .andExpect(
                MockMvcResultMatchers.jsonPath("$.exception")
                    .value("class org.springframework.dao.DataIntegrityViolationException")
            )
            .andExpect(MockMvcResultMatchers.jsonPath("$.details[*]").isNotEmpty)
            .andDo(MockMvcResultHandlers.print())
    }

    @Test
    fun `should not save a customer with non-nullable empty or Number lesser or igual Zero fields and return a STATUS 400`() {
        /*
        * Non-nullable fields of Customer:
        *  firstName,lastName,cpf,email,password,address{zipCode,Street} and income
        * */
        //given
        val customerDto: CustomerDto = buildCustomerDto(cpf = "")

        val stringCustomer: String = objectMapper.writeValueAsString(customerDto)

        //when //then
        mockMvc.perform(
            MockMvcRequestBuilders.post(URL)
                .contentType(MediaType.APPLICATION_JSON)
                .content(stringCustomer)
        )
            .andExpect(MockMvcResultMatchers.status().isBadRequest)
            .andExpect(
                MockMvcResultMatchers.jsonPath("$.exception")
                    .value("class org.springframework.web.bind.MethodArgumentNotValidException")
            )
            .andExpect(MockMvcResultMatchers.jsonPath("$.details[*]").isNotEmpty)
            .andDo(MockMvcResultHandlers.print())

    }

    @Test
    fun `should find a customer by customerId and return STATUS 200`() {
        //given
        val customer: Customer = customerRepository.save(buildCustomerDto().toEntity())
        //when //then
        mockMvc.perform(
            MockMvcRequestBuilders.get("$URL/${customer.id}")
                .accept(MediaType.APPLICATION_JSON)
        ).andExpect(MockMvcResultMatchers.status().isOk)
            .andDo(MockMvcResultHandlers.print())
    }

    @Test
    fun `should not find a customer by invalid customerId and return STATUS 400`() {
        //given
        val invalidCustomerId = 11L
        //when //then
        mockMvc.perform(
            MockMvcRequestBuilders.get("$URL/${invalidCustomerId}")
                .accept(MediaType.APPLICATION_JSON)
        ).andExpect(MockMvcResultMatchers.status().isBadRequest)
            .andExpect(
                MockMvcResultMatchers.jsonPath("$.exception")
                    .value("class me.dio.kotlinRestApi.system.exception.BusinessException")
            )
            .andExpect(MockMvcResultMatchers.jsonPath("$.details[*]").isNotEmpty)
            .andDo(MockMvcResultHandlers.print())
    }

    @Test
    fun `should remove a customer by id return STATUS 204`() {
        //given
        val customer: Customer = customerRepository.save(buildCustomerDto().toEntity())
        //when //then
        mockMvc.perform(
            MockMvcRequestBuilders.delete("$URL/${customer.id}")
                .accept(MediaType.APPLICATION_JSON)
        ).andExpect(MockMvcResultMatchers.status().isNoContent)
            .andDo(MockMvcResultHandlers.print())
    }

    @Test
    fun `should not  remove a customer by invalidCustomerId return STATUS 400`() {
        //given
        val invalidCustomerId = 11L
        //when //then
        mockMvc.perform(
            MockMvcRequestBuilders.delete("$URL/${invalidCustomerId}")
                .accept(MediaType.APPLICATION_JSON)
        ).andExpect(MockMvcResultMatchers.status().isBadRequest)
            .andExpect(MockMvcResultMatchers.jsonPath("$.details[*]").isNotEmpty)
            .andDo(MockMvcResultHandlers.print())
    }

    @Test
    fun `should update a customer by customerId and return STATUS 200`() {
        //given
        val customer: Customer = customerRepository.save(buildCustomerDto().toEntity())
        val customerToUpdate: CustomerUpdateDto =
            buildCustomerUpdateDto("CamiUpdated", income = BigDecimal.valueOf(3000.0))
        val stringCustomer: String = objectMapper.writeValueAsString(customerToUpdate)

        //when //then
        mockMvc.perform(
            MockMvcRequestBuilders.patch("$URL?customerId=${customer.id}")
                .contentType(MediaType.APPLICATION_JSON)
                .content(stringCustomer)
        )
            .andExpect(MockMvcResultMatchers.status().isOk)
            .andDo(MockMvcResultHandlers.print())
    }

    @Test
    fun `should not update a customer by invalidCustomerId and return STATUS 400`() {
        //given
        val customerToUpdate: CustomerUpdateDto =
            buildCustomerUpdateDto("CamiUpdated", income = BigDecimal.valueOf(3000.0))
        val invalidCustomerId = 11L
        val stringCustomer: String = objectMapper.writeValueAsString(customerToUpdate)

        //when //then
        mockMvc.perform(
            MockMvcRequestBuilders.patch("$URL?customerId=${invalidCustomerId}")
                .contentType(MediaType.APPLICATION_JSON)
                .content(stringCustomer)
        )
            .andExpect(MockMvcResultMatchers.status().isBadRequest)
            .andDo(MockMvcResultHandlers.print())
    }
}