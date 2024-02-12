package me.dio.kotlinRestApi.system.resources

import jakarta.validation.Valid
import me.dio.kotlinRestApi.system.service.ICustomerService
import me.dio.kotlinRestApi.system.service.dto.request.CustomerDto
import me.dio.kotlinRestApi.system.service.dto.request.CustomerUpdateDto
import me.dio.kotlinRestApi.system.service.dto.response.CustomerViewDto
import me.dio.kotlinRestApi.system.service.entity.Customer
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/api/customers")
class CustomerResource(
    @Autowired private val customerService: ICustomerService
) {

    // Create a new Customer
    @PostMapping
    fun saveCustomer(@RequestBody @Valid customerDto: CustomerDto): ResponseEntity<String> {
        val savedCustomer = this.customerService.save(customerDto.toEntity())
        return ResponseEntity.status(HttpStatus.CREATED).body("Customer ${savedCustomer.email} saved!")
    }

    // View non-sensitive data of an existing Customer
    @GetMapping("/{id}")
    fun findById(@PathVariable id:Long): ResponseEntity<CustomerViewDto> {
        val customer: Customer =this.customerService.findById(id)
        return ResponseEntity.status(HttpStatus.OK).body(CustomerViewDto(customer))
    }

    @DeleteMapping("/{id}")
    fun deleteCustomer(@PathVariable id:Long)= this.customerService.deleteById(id)

    // Update non-sensitive data of an existing Customer
    @PatchMapping
    fun updateCustomer(@RequestParam(value="customerId")id:Long,
                       @RequestBody customerUpdate: CustomerUpdateDto
    ): ResponseEntity<CustomerViewDto> {
        val customer = this.customerService.findById(id)
        val customerToUpdate: Customer =customerUpdate.toEntity(customer)
        val customerUpdated: Customer =this.customerService.save(customerToUpdate)

        return ResponseEntity.status(HttpStatus.OK).body(CustomerViewDto(customerUpdated))
    }

}