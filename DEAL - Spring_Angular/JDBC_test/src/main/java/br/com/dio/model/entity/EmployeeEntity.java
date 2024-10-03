package br.com.dio.model.entity;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
@AllArgsConstructor
public class EmployeeEntity {
    private long id;
    private String name;
    private BigDecimal salary;
    private LocalDate birthday;

    public EmployeeEntity(String name, BigDecimal salary, LocalDate birthday) {
        this.name = name;
        this.salary = salary;
        this.birthday = birthday;
    }

    @Override
    public String toString() {
            return getClass().getSimpleName() + "[" +
                    "id=" + this.id + ", " +
                    "name='" + this.name + "', " +
                    "salary=" + this.salary + ", " +
                    "birthday=" + this.birthday +
                    "]";
        }

    }


