import src.greeter.DifferenceTwoPeopleAges;
import src.greeter.Greeter;
import src.calculate.Square;
import src.calculate.Rectangle;

import java.util.Scanner;

public class Main {
    private static void doGreeter(Scanner scanner) {
        var greeter = new Greeter(scanner);
        System.out.println(greeter.getGetterInfo());
    }

    private static void doDifferTwoPeopleAges(Scanner scanner) {
        var diffAges = new DifferenceTwoPeopleAges(scanner);
        System.out.println(diffAges.getDifference());
    }

    private static void doCalculateSquare(Scanner scanner) {
        System.out.println("Entre o Lado do Quadrado:");
        double side = scanner.nextDouble();
        scanner.nextLine();

        var areaQuadrado = new Square(side);
        System.out.println("A área do quadrado é: " + areaQuadrado.getArea());
    }

    private static void doCalculateReatangle(Scanner scanner) {
        System.out.println("Entre com a Altura do Retangulo:");
        double height = scanner.nextDouble();
        scanner.nextLine();

        System.out.println("Entre com a Largura do Retangulo:");
        double weight = scanner.nextDouble();
        scanner.nextLine();

        var areaRetangulo = new Rectangle(height,weight);
        System.out.println("A área do Retângulo é: " + areaRetangulo.getArea());
    }

    public static void main(String[] args) {
        var scanner = new Scanner(System.in);
        char option = ' ';

        try {
            while (option != 'q') {
                System.out.println("Escolha a função\n\t1 - Greeter\n\t2 - Diferença de Idades\n\t3 - Areá do Quadrado\n\t4 - Areá do Retangulo\n\tq - exit");
                System.out.print("Opção:\t");
                option = scanner.nextLine().trim().charAt(0);

                switch (option) {
                    case '1' -> {
                        doGreeter(scanner);
                    }
                    case '2' -> {
                        doDifferTwoPeopleAges(scanner);
                    }
                    case '3' -> {
                        doCalculateSquare(scanner);
                    }
                    case '4' -> {
                        doCalculateReatangle(scanner);
                    }
                    case 'q' -> {
                        // Mensagem para quando o usuário decide sair.
                        System.out.println("Saindo...");
                    }
                    default -> {
                        System.out.println("Entrada Inválida!");
                    }
                }
            }
        } finally {
            scanner.close();
        }
    }
}
