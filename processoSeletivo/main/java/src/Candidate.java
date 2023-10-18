package src;

import lombok.Getter;

@Getter
public class Candidate {

    private Double salary;
    private String name;
    private String telephone;
    public Candidate(String name, String telephone, Double salary){
        this.salary=salary;
        this.name=name;
        this.telephone=telephone;
    }
}