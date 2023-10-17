package src;

//import java.util.concurrent.ThreadLocalRandom;

public class Candidato{
    double pretencaoSalarial;
    String nome;
    String telefone;

    public Candidato(String nome,String telefone,double pretencaoSalarial){
        this.nome=nome;
        this.telefone=telefone;
        this.pretencaoSalarial=pretencaoSalarial;
    }

    public double getPretencaoSalarial() {
        return pretencaoSalarial;
    }

    public String getNome() {
        return nome;
    }

    public String getTelefone() {
        return telefone;
    }
    //To Mock candidato
    //static double valorPretendido(){
    //static double valorPretendido(){
    // return ThreadLocalRandom.current().nextDouble(1800,2200);
    //}
}