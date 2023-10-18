import java.util.Scanner;

import static java.lang.Integer.parseInt;

public class Contador {
    public static void main(String[] args) {

        //Recebe dois numeros int como argumento
        //do command line

        Scanner input=new Scanner(System.in);

        //Trabalha  excessoes
        //Se o primeiro for maior que o segundo "ParametrosInvalidosException"
        // se n�o subritrai o segundo do primeiro n iteraç�es no for

        try{
            int parUm=Integer.valueOf(input.nextInt());
            int parDois=Integer.valueOf(input.nextInt());
                    try {
                        contar(parUm, parDois);
                    }catch (ParametrosInvalidosException p){
                        System.out.println(p.getMessage());
                    }

        }catch(Exception e){
            System.out.println(e.toString()+" Tipo do Input Invalido");
        }
    }

    static void contar(int parUm,int parDois){
           if(parUm<parDois) {
               System.out.println("Contando ate :" + (parDois - parUm));
               for (int count = 1; count <= (parDois - parUm); count++) {
                   System.out.println("-->:" + count);
               }
           }else{
               throw new ParametrosInvalidosException();
           }
    }
}
