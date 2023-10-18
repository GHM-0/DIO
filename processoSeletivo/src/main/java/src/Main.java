package src;

import src.Candidato;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class Main {

 // salarioBase=2000 by DEFAULT Criterio

    static List<Candidato> processoSeletivo(List<Candidato> candidatos,Double criterio){
        List<Candidato> selecionados=new ArrayList<Candidato>(){};
        candidatos.stream().forEach(c->{

                if (!(c.getPretencaoSalarial() >= criterio)) {
                    System.out.println("Ligar Para o Candidato! " + c.getNome() + " " + c.getTelefone());
                    selecionados.add(c);
                } else if (c.getPretencaoSalarial() == criterio) {
                    System.out.println("Ligar com Contra Proposta Para o Candidato! " + c.getNome() + " " + c.getTelefone());
                    //? result Contra proposta?
                } else {
                    System.out.println("... aguardar Analise dos demais candidatos");
                }
        });
        return selecionados;
    }

    static void contatarCandidato(List<Candidato> candidatos,int tentativas, int nSelecionados) {
       System.out.println("Candidatos Selecionados -> "+candidatos.size());
        List<Candidato> selecionados=new ArrayList<Candidato>(nSelecionados){}; //Universo

        Boolean recebeligacao = new Random().nextBoolean();                    //Criterio

        System.out.println("Inicial: n Contratados: "+selecionados.size() );
        System.out.println("SELECIONADOS :"+nSelecionados);

            for ( Candidato c : candidatos) {
                System.out.println("tentando Contatar :"+c.getNome());

                for(int count=1;count <= tentativas;count++) {
                    if(selecionados.size() < nSelecionados) {
                        if (recebeligacao.booleanValue()) {
                            System.out.println("candidato" + c.getNome() + " contactado apos " + count + " tentavias");

                            //Se n�o usar break
//                            if(!selecionados.contains(c)){
                                selecionados.add(c);
//                            }
                            break;
                        }
                        System.out.println("candidato n�o pode ser contatado " + count);
                }
            }
        }
        System.out.println("Final: n Contratados: "+selecionados.size() );
            selecionados.forEach(c->{
                System.out.println(" CONTRATADO -> "+c.getNome());
            });
    }


    public static void main(String[] args) {
        int nSelecionados=5;
        Double salarioBase=2000.0;
        List<Candidato> candidatos= new ArrayList<Candidato>();
        Candidato c01 = new Candidato("Gladison Acasio","",2300);
        Candidato c02 = new Candidato("Adelio Bispo","",2420);
        Candidato c03 = new Candidato("Fabio Assunçao","",2000);
        Candidato c04 = new Candidato("Adele Fitsgeralds","",1950);
        Candidato c05 = new Candidato("Romeu de Paula","",2200);
        Candidato c06 = new Candidato("Flavio Albanese","",1999);
        Candidato c07 = new Candidato("Tony Toscano","",2120);
        Candidato c08 = new Candidato("Diogo Oliveira","",2200);
        Candidato c09 = new Candidato("Pablo Neruda","",2000);
        Candidato c10 = new Candidato("Pepe Mugica","",1900);
        Candidato c11 = new Candidato("Mario Andrade","",2100);
        Candidato c12 = new Candidato("Ezequiel de Almeida","",2000);
        Candidato c13 = new Candidato("Wanessa Borbado","",1800);
        Candidato c14 = new Candidato("Queness Martins","",2600);
        Candidato c15 = new Candidato("Rebeca da Silva","",3200);
        Candidato c16 = new Candidato("Caio Tofolli","",3000);
        Candidato c17 = new Candidato("Everton Orlento","",2000);
        Candidato c18 = new Candidato("Claudio De Andrade","",1900);
        candidatos.add(c01);
        candidatos.add(c02);
        candidatos.add(c03);
        candidatos.add(c04);
        candidatos.add(c05);
        candidatos.add(c06);
        candidatos.add(c07);
        candidatos.add(c08);
        candidatos.add(c09);
        candidatos.add(c10);
        candidatos.add(c11);
        candidatos.add(c12);
        candidatos.add(c13);
        candidatos.add(c14);
        candidatos.add(c15);
        candidatos.add(c16);
        candidatos.add(c17);
        candidatos.add(c18);

        contatarCandidato(
                processoSeletivo(candidatos,salarioBase),3,nSelecionados
        );
    }
}