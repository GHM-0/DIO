package me.dio.santanderdevbootcamp.domain.model.agency;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

import java.time.LocalDateTime;

@Entity
public abstract class Operation {
    @Id
    private String type;
    private LocalDateTime occurence;
    private Double Value;
    private float fee;
    private float taxation;
}
