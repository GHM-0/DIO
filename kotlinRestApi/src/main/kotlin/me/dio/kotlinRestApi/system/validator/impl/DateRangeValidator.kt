package me.dio.kotlinRestApi.system.validator.impl

import jakarta.validation.ConstraintValidator
import jakarta.validation.ConstraintValidatorContext
import me.dio.kotlinRestApi.system.validator.ValidDateRange
import java.time.LocalDate
import java.time.temporal.ChronoUnit

class DateRangeValidator : ConstraintValidator<ValidDateRange, LocalDate> {
    private lateinit var annotation: ValidDateRange

    override fun initialize(constraintAnnotation: ValidDateRange) {
        annotation = constraintAnnotation
    }

    override fun isValid(date: LocalDate, context: ConstraintValidatorContext): Boolean {
        val now = LocalDate.now()
        val futureDate = now.plus(annotation.value.toLong(), getChronoUnit(annotation.unit))
        return date <= futureDate
    }

    private fun getChronoUnit(unit: String): ChronoUnit {
        return try {
            ChronoUnit.valueOf(unit.uppercase())
        } catch (e: IllegalArgumentException) {
            throw IllegalArgumentException("Invalid Chrono Unit: $unit")
        }
    }

}