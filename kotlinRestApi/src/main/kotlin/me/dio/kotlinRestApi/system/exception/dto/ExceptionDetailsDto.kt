package me.dio.kotlinRestApi.system.exception.dto

import java.time.LocalDateTime

data class ExceptionDetailsDto(
    val title: String,
    val timeStamp: LocalDateTime,
    val status: Int,
    val exception: String,
    val details: MutableMap<String, String?>,
)
