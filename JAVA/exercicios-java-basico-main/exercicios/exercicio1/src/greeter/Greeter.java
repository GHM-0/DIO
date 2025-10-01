package src;

import java.util.Scanner;
import java.util.stream.Stream;
import java.time.Year;

public class Greeter{

    private Person[] people;

    public Greeter(Scanner scanner){
            this.people = Stream.generate(()->{
                System.out.println("Digite o nome:");
                String name = scanner.nextLine().trim();

                System.out.println("Digite o ano de Nascimento:");
                Integer birthYear = Integer.parseInt(scanner.nextLine().trim());
                return new Person(birthYear,name);

            }).limit(1).toArray(Person[]::new);
    }

    // public Greeter(){this(1)}  Ugly as British smile

    public String getGetterInfo(){
        return STR."Olá \{this.people[0].name()} você tem ~\{Year.now().getValue() - this.people[0].birthYear()} anos.";
    }

    public Person getPersonByPosition(int position){
        if (position >= 0 && position < people.length)
            return people[position];

        throw new IndexOutOfBoundsException("Posição inválida: " + position);
    }
}