package me.dio.santanderdevbootcamp.domain.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.Future;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import org.hibernate.validator.constraints.Range;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Card {

    @Id @GeneratedValue(strategy= GenerationType.IDENTITY)
    private Long id;
    @NotNull
    private boolean status;
    @OneToMany
    private List<Restrictions> restrictions;
    @Column(unique = true)
    private String number;
    @Min(value = 500) @Max(value=200000)
    @Column(name="_limit")
    private BigDecimal limit;
    private String printedName;
    private Date emission;
    @Future
    private Date expiration;
    @OneToOne   //Uma Conta Para muitos Cartoes           | TITULAR do Cartao
    private Account account;
}
