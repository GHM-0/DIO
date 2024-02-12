package me.dio.kotlinRestApi.system.service.exception.resources

import me.dio.kotlinRestApi.system.service.exception.BusinessException
import me.dio.kotlinRestApi.system.service.exception.dto.ExceptionDetailsDto
import org.springframework.dao.DataAccessException
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.validation.FieldError
import org.springframework.validation.ObjectError
import org.springframework.web.bind.MethodArgumentNotValidException
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.web.bind.annotation.RestControllerAdvice
import java.time.LocalDateTime

@RestControllerAdvice
class RestExceptionHandler{


    @ExceptionHandler(MethodArgumentNotValidException::class)
    fun handlerValidException(ex:MethodArgumentNotValidException): ResponseEntity<ExceptionDetailsDto>{

        val errors:MutableMap<String,String?> = HashMap()
        ex.bindingResult.allErrors.stream().forEach{
            error: ObjectError ->
            val fieldName:String = (error as FieldError).field
            val messageError:String? = error.defaultMessage
            errors[fieldName]=messageError
        }

        return ResponseEntity(ExceptionDetailsDto(
            title="Bad Request, consult the documentation",
            timeStamp= LocalDateTime.now(),
            status=HttpStatus.BAD_REQUEST.value(),
            exception=ex.javaClass.toString(),
            details=errors
        ), HttpStatus.BAD_REQUEST)
    }

    @ExceptionHandler(DataAccessException::class)
    fun handlerValidException(ex:DataAccessException): ResponseEntity<ExceptionDetailsDto>{

        return ResponseEntity(ExceptionDetailsDto(
            title="Conflict, consult the documentation",
            timeStamp= LocalDateTime.now(),
            status=HttpStatus.CONFLICT.value(),
            exception=ex.javaClass.toString(),
            details= mutableMapOf(ex.cause.toString() to ex.message)
        ), HttpStatus.CONFLICT
        )
    }

    @ExceptionHandler(BusinessException::class)
    fun handlerBusinessException(ex:BusinessException):ResponseEntity<ExceptionDetailsDto>{
        return ResponseEntity(ExceptionDetailsDto(
            title="Bad Request, consult the documentation",
            timeStamp= LocalDateTime.now(),
            status=HttpStatus.BAD_REQUEST.value(),
            exception=ex.javaClass.toString(),
            details= mutableMapOf(ex.cause.toString() to ex.message)
        ), HttpStatus.BAD_REQUEST)
    }


}