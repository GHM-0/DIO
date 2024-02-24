package me.dio.kotlinRestApi.system.entity

import jakarta.persistence.Column
import jakarta.persistence.Embeddable

@Embeddable
class Address(
    @Column(nullable = false)
    var zipCode: String = "",
    @Column(nullable = false)
    var street: String = "",
    @Column(nullable = true)
    var number: Int? = null,
)