package me.dio.kotlinRestApi.system.service.exception

data class BusinessException(override val message:String?) : RuntimeException(message) {

}
