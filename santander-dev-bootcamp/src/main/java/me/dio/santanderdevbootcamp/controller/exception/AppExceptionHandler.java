package me.dio.santanderdevbootcamp.controller.exception;

import jakarta.persistence.EntityNotFoundException;
import me.dio.santanderdevbootcamp.dto.ErrorDTO;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.RestControllerAdvice;


@RestControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(EntityNotFoundException.class)
    public ResponseEntity handlerEntityNotFound() {
        return ResponseEntity.notFound().build();
    }

    @org.springframework.web.bind.annotation.ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity handlerArgumentNotValid(MethodArgumentNotValidException ex) {
        var erros = ex.getFieldErrors();
        return ResponseEntity.badRequest().body(erros.stream().map(ErrorDTO::new).toList());
    }

    @org.springframework.web.bind.annotation.ExceptionHandler(HttpMessageNotReadableException.class)
    public ResponseEntity handlerMessageNotReadable(HttpMessageNotReadableException ex) {
        return ResponseEntity.badRequest().body(ex.getMessage());
    }


//    @org.springframework.web.bind.annotation.ExceptionHandler(BadCredentialsException.class)
//    public ResponseEntity handlerBadCredentials() {
//        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid Credentials");
//    }

//    @org.springframework.web.bind.annotation.ExceptionHandler(AuthenticationException.class)
//    public ResponseEntity handlerAuthentication() {
//        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Authentication Failed");
//    }

//    @org.springframework.web.bind.annotation.ExceptionHandler(AccessDeniedException.class)
//    public ResponseEntity handlerAccessDenied() {
//        return ResponseEntity.status(HttpStatus.FORBIDDEN).body("Acess Denied");
//    }

    @org.springframework.web.bind.annotation.ExceptionHandler(Exception.class)
    public ResponseEntity handleGeneric(Exception ex) {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error: " +ex.getLocalizedMessage());
    }


}
