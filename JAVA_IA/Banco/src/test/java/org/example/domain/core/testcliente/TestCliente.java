package org.example.domain.core.testcliente;

import org.example.core.domain.model.cliente.pessoafisica.PessoaFisica;
import org.example.core.domain.model.local.Endereco;
import org.example.core.domain.model.local.EnderecoStatus;
import org.example.core.domain.model.local.agencia.Agencia;
import org.junit.jupiter.api.Test;

import java.time.LocalDate;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class TestCliente {
    @Test
    void criarPessoaFisica(){
        Endereco endAgencia = new Endereco("Rua da Agencia",
                "Bairro da Agencia","Cidade da Agencia","RJ",
                1,"20-000.00", EnderecoStatus.PRINCIPAL);

        Agencia agencia = new Agencia(endAgencia);

        Endereco endPessoaFisica = new Endereco("Rua da PF1",
                "Bairro da PF1","Cidade da PF1","RJ",
                23,"20-000.00", EnderecoStatus.PRINCIPAL);

        PessoaFisica pf = new PessoaFisica("PF1-nome","PF1-sobrenome","100000000", LocalDate.of(1987,2,19),agencia,endPessoaFisica);
        System.out.println(pf.toString());

        assertEquals(pf.getSobreNome(),"PF1-sobrenome");
    }

}
