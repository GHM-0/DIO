package me.dio.kotlinRestApi.system.resources

import jakarta.validation.Valid
import me.dio.kotlinRestApi.system.service.ICreditService
import me.dio.kotlinRestApi.system.service.dto.request.CreditDto
import me.dio.kotlinRestApi.system.service.dto.response.CreditViewDto
import me.dio.kotlinRestApi.system.service.dto.response.CreditsViewListDto
import me.dio.kotlinRestApi.system.service.entity.Credit
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.util.*
import java.util.stream.Collectors

@RestController
@RequestMapping("/api/credits")
class CreditResource(
    private val creditService: ICreditService
) {
    @PostMapping
    fun saveCredit(
        @RequestBody @Valid creditDto: CreditDto
    ): ResponseEntity<String> {
        val creditToSave: Credit = this.creditService.save(creditDto.toEntity())

        return ResponseEntity.status(HttpStatus.CREATED)
            .body("Credit ${creditToSave.creditCode} " +
                    "- Customer ${creditToSave.customer?.lastName},${creditToSave.customer?.firstName} ")
    }

    @GetMapping
    fun findAllByCustomer(
        @RequestParam(value = "customerId") customerId: Long
    ):  ResponseEntity<List<CreditsViewListDto>> {
        val creditsViewList:List<CreditsViewListDto> = this.creditService.findAllByCustomer(customerId).stream()
            .map { credit: Credit -> CreditsViewListDto(credit) }.collect(Collectors.toList())
        return ResponseEntity.status(HttpStatus.OK).body(creditsViewList)
    }

    @GetMapping("/{creditCode}")
    fun findByCreditCode(
        @RequestParam(value = "customerId") customerId: Long,
        @PathVariable creditCode: UUID
    ): ResponseEntity<CreditViewDto> {
        val credit = this.creditService.findByCreditCode(customerId, creditCode)
        return ResponseEntity.status(HttpStatus.OK).body(CreditViewDto(credit))
    }

}