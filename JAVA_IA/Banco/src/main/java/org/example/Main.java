package org.example;

import org.example.domain.cliente.Cliente;
import org.example.domain.cliente.Endereco;
import org.example.domain.cliente.PessoaFisica;

public class Main {
    public static void main(String[] args) {
        Endereco endereco_UM = new Endereco("Rua UM","Bairro UM","Cidade UM","UM",3002);

        //System.out.println(endereco_UM);

        Cliente pessoa_F_UM = new PessoaFisica("CPF_UM","Nome_UM","sobreNome_UM",endereco_UM);
        System.out.println(pessoa_F_UM);

    }
}