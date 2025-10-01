package src;

public class tabuada {

    public tabuada(int numero){

        if(numero > 0){
            System.out.println("Tabuada de Base "+numero+":");
            for (int i = 0; i < 10 ; i++) {
                System.out.println((i+1)+"="+(i+1)*numero);
            }

        }else{
            throw new Error("Invalid Number!");
        }
    }
}
