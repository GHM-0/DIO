package src;

import java.util.ArrayList;
import java.util.Random;

public class Main {

    public static ArrayList<Candidate> selectionCandidate(
            ArrayList<Candidate> candidates,int selectedCandidates,Double baseSalary,int attempts){

        var selected=new ArrayList<Candidate>(selectedCandidates);

        //candidate Salary higher than baseSalary
        candidates.stream().filter(c -> c.getSalary() >= baseSalary).forEach(c -> System.out.println( c.getName() + "... aguardar Analise dos demais candidatos"));

        //candidate Salary equals baseSalary
        candidates.stream().filter(c -> c.getSalary().equals(baseSalary)).forEach(c ->
                System.out.println("Ligar com Contra Proposta Para o Candidato! " + c.getName() + " " + c.getTelephone())
        );

        //candidate Salary lower than baseSalary
        candidates.stream().filter(c -> c.getSalary()<=baseSalary).forEach( c->{

            //contact attempts
            // Try to attempt with c.getName()
            //True until full array charge.
            if(selected.size()<selectedCandidates) {

                for(int attempt=1;attempt<=attempts;attempt++){
                    System.out.println("Ligar Para o Candidato! " + c.getName() + " " + c.getTelephone());
                    //new Boolean condition
                    var recebeligacao = new Random().nextBoolean();
                    if(recebeligacao){
                        //Contated successfull in attempt
                        System.out.println("candidato" + c.getName() + " contactado apos " + attempt + " tentavias");
                        selected.add(c);
                        break;
                    }else{
                        //Contact unsuccessfull in attempt
                        System.out.println("candidato n�o pode ser contatado " + attempt);
                    }

                }
                System.out.println("---------------------------------------------------------------\n"
                        +" n Selecionados:"+selected.size());
            }
        });


        return selected;
    }

    public static void main(String[] args) {

        Double baseSalary = 2000.0;
        int selectedCandidates=5;
        int attempts=3;
        var candidates=new ArrayList<Candidate>();

        var c01 = new Candidate("Gladison Acasio","",2300.0);
        var c02 = new Candidate("Adelio Bispo","",2420.0);
        var c03 = new Candidate("Fabio Assunçao","",2000.0);
        var c04 = new Candidate("Adele Fitsgeralds","",1950.0);
        var c05 = new Candidate("Romeu de Paula","",2200.0);
        var c06 = new Candidate("Flavio Albanese","",1999.0);
        var c07 = new Candidate("Tony Toscano","",2120.0);
        var c08 = new Candidate("Diogo Oliveira","",2200.0);
        var c09 = new Candidate("Pablo Neruda","",2000.0);
        var c10 = new Candidate("Pepe Mugica","",1900.0);
        var c11 = new Candidate("Mario Andrade","",2100.0);
        var c12 = new Candidate("Ezequiel de Almeida","",2000.0);
        var c13 = new Candidate("Wanessa Borbado","",1800.0);
        var c14 = new Candidate("Queness Martins","",2600.0);
        var c15 = new Candidate("Rebeca da Silva","",3200.0);
        var c16 = new Candidate("Caio Tofolli","",3000.0);
        var c17 = new Candidate("Everton Orlento","",2000.0);
        var c18 = new Candidate("Claudio De Andrade","",1900.0);
        candidates.add(c01);
        candidates.add(c02);
        candidates.add(c03);
        candidates.add(c04);
        candidates.add(c05);
        candidates.add(c06);
        candidates.add(c07);
        candidates.add(c08);
        candidates.add(c09);
        candidates.add(c10);
        candidates.add(c11);
        candidates.add(c12);
        candidates.add(c13);
        candidates.add(c14);
        candidates.add(c15);
        candidates.add(c16);
        candidates.add(c17);
        candidates.add(c18);

        selectionCandidate(candidates,selectedCandidates,baseSalary,attempts).forEach(c->{
            System.out.println(c.getName());
        });


    }
}
