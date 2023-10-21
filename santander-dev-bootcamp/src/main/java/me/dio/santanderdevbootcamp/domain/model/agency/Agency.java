package me.dio.santanderdevbootcamp.domain.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.validation.constraints.NotNull;

@Entity
public class Agency {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @NotNull @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String number;
    @NotNull
    private Address location;
}
