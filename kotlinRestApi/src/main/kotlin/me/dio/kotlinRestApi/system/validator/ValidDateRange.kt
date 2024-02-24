package me.dio.kotlinRestApi.system.validator

import jakarta.validation.Constraint
import jakarta.validation.Payload
import me.dio.kotlinRestApi.system.validator.impl.DateRangeValidator
import kotlin.reflect.KClass

@Target(AnnotationTarget.FIELD)
@Retention(AnnotationRetention.RUNTIME)
@Constraint(validatedBy = [DateRangeValidator::class])
@MustBeDocumented
annotation class ValidDateRange(
    val value: Int,
    val unit: String,
    val message: String = "Please insert a valid Integer value and a valid Chrono.Unit",
    val groups: Array<KClass<Any>> = [],
    val payload: Array<KClass<Payload>> = [],
)