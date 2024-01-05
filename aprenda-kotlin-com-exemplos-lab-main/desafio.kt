// [Template no Kotlin Playground](https://pl.kotl.in/WcteahpyN)

enum class Nivel { BASICO, INTERMEDIARIO, DIFICIL }

data class Usuario(var nome:String, val matricula:String)

//ex.: reassign -> Nome=JavaScript Basico/ ABC do Javascript; non-reassin Nivel=BASICO Duracao=60
data class ConteudoEducacional(var nome: String, var duracao: Int = 60,val nivel:Nivel)

class Formacao(var nome: String,var nivel:Nivel,  vararg grade: ConteudoEducacional) {

    var inscritos = mutableListOf<Usuario>()
    var grade=grade.asList()

    fun matricular(usuario: Usuario) {
        inscritos.add(usuario)
        println("${usuario} inscrição realizada com sucesso na formação $nome")
    }

    fun addToGrade(vararg ngrade: ConteudoEducacional){
        if(inscritos.size==0){
            ngrade.forEach { n -> if (n in grade){
            println("Erro ao adicionar ${n.nome}, já está contido na grade curricular da fromação $nome")
        }else{
            grade+=n;  //add não funciona?
            println("Sucesso! ${n.nome} incluído na fromação $nome")
         } }
        }else{
            println("Error, Já há inscritos na Formação $nome")
            }
        }

    fun cancelarMatricula(usuario: Usuario){
        if(usuario in inscritos){
            inscritos.remove(usuario)
            println("${usuario.nome}," +
                    "${usuario.matricula}"+
                    " inscrição cancelada com sucesso na formação $nome")
        }else{
            println("${usuario.nome}," +
                    "${usuario.matricula}" +
                    "Falha ao Cancelar Inscrição, usuário não cadastrado na formação:$nome")
        }
    }
}


fun main() {
//    TODO("Analise as classes modeladas para este domínio de aplicação e pense em formas de evoluí-las.")
    // Inscrito == Matriculado? Escolher uma nomenclatura clara e homogenia
    // Uma vez havendo inscritos a grade deveria ser imutável

//    TODO("Simule alguns cenários de teste. Para isso, crie alguns objetos usando as classes em questão.")

    // Instâncias de Conteúdo Educacional
    var java1=ConteudoEducacional("Java - Básico", duracao = 120, Nivel.BASICO);
    var java2=ConteudoEducacional("Java - Programação Funcional", duracao = 60, Nivel.INTERMEDIARIO);
    var java3=ConteudoEducacional("Java - Meta Programação", duracao = 40, Nivel.INTERMEDIARIO);
    var java4=ConteudoEducacional("Java - Abstração de Dados", duracao = 60, Nivel.BASICO);

    // Instância de Formação
    var Curso_Java=Formacao("Java",Nivel.INTERMEDIARIO,java1,java2,java3);

    // Mostrar Grade Curricular
    println("Grade Curricular ${Curso_Java.nome}, número de componentes=${Curso_Java.grade.size}");
    Curso_Java.grade.forEach { e -> println(e.nome) };
    println("");

    // Instâncias de Usuário
    var user1=Usuario("Um","UM1");
    var user2=Usuario("Dois","DOIS2");
    var user3=Usuario("Três","TRÊS3");
    var user4=Usuario("Quatro","QUATRO4");

    // Inscrição do Usuário na Formação
    println("Inscrições para a Formação de JAVA:");
    Curso_Java.matricular(user1);
    Curso_Java.matricular(user2);
    println("");

    // Cancelamento de Inscrição
    println("Cancelamento de Inscrições para a Formação de JAVA:");
    Curso_Java.cancelarMatricula(user3);
    Curso_Java.cancelarMatricula(user2);
    println("");

    // Adicionar a grade Curricular
    println("Adicionar curso a Formação ${Curso_Java.nome}");
    Curso_Java.addToGrade(java3);
    Curso_Java.addToGrade(java4);
    println("");
    println("Nova Grade Curricular:");
    Curso_Java.grade.forEach { e -> println(e.nome) };

}
