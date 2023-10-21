package me.dio.santanderdevbootcamp.domain.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.math.BigDecimal;
import java.util.List;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(of="number")
public class Account {
    @Id @GeneratedValue(strategy= GenerationType.IDENTITY)
    private Long id;
    @Column(unique = true)
    @NotNull
    private String number;
    @NotNull
    private String agency;
    private BigDecimal balance;
    @Column(name="_limit")
    private BigDecimal limit;

    @OneToMany
    private List<Card> cards;

    public List<Card> getCards() {
        return cards;
    }

}
