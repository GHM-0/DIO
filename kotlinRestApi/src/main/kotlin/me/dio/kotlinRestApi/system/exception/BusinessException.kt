package me.dio.kotlinRestApi.system.exception

data class BusinessException(override val message: String?) : RuntimeException(message)
