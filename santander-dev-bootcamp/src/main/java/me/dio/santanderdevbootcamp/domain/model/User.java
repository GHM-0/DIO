package me.dio.santanderdevbootcamp.domain.model;


import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import javax.lang.model.type.ArrayType;
import java.util.ArrayList;
import java.util.List;


@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class User {

    @Id @GeneratedValue(strategy= GenerationType.IDENTITY)
    private Long id;
    private String name;
    @OneToOne
    private Account account;
    @OneToMany
    private List<Feature> features;
    @OneToOne
    private Card card;
    @OneToMany
    private List<News> news;

}
