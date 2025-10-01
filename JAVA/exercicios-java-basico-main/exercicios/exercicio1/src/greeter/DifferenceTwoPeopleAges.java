package src;

import java.time.Year;
import java.util.Scanner;
import java.util.stream.Stream;

public class DifferenceTwoPeopleAges {
    private Person[] people;

    public DifferenceTwoPeopleAges(Scanner scanner){

            this.people = Stream.generate(()->{
                System.out.println("Digite o nome:");
                String name = scanner.nextLine().trim();

                System.out.println("Digite a idade:");
                Integer birthYear = Year.now().getValue() - Integer.parseInt(scanner.nextLine().trim());

                return new Person(birthYear,name);

            }).limit(2).toArray(Person[]::new);
    }

    public String getDifference(){
        return STR."A diferença é de ~\{(Year.now().getValue() - this.people[0].birthYear()) - (Year.now().getValue() - this.people[1].birthYear())} anos.";
    }

}