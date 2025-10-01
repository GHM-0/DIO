package org.example.core.domain.local;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Null;
import org.example.core.domain.local.validation.ValidaCEP;

import java.util.Objects;


public record Endereco(
        @NotNull String logradouro,
        @NotNull String bairro,
        @NotNull String cidade,
        @NotNull String estado,
        @Null Integer numero,
        @ValidaCEP String cep,
        @NotNull EnderecoStatus status) implements Comparable<Endereco>  {

    // Descarta o status em quanto diferencial
    @Override
    public boolean equals(Object o){
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Endereco endereco = (Endereco) o;
        return logradouro.equals(endereco.logradouro) &&
                bairro.equals(endereco.bairro) &&
                cidade.equals(endereco.cidade) &&
                estado.equals(endereco.estado) &&
                Objects.equals(numero, endereco.numero) &&
                cep.equals(endereco.cep);
    }

    @Override
    public int hashCode() {
        return Objects.hash(logradouro, bairro, cidade, estado, numero, cep);
    }

    @Override
    public int compareTo(Endereco o) {
        return this.status.compareTo(o.status);
    }

    public Endereco setPrincipal(Endereco endereco) {
        if (!this.status.isAtivo()) {
            throw new IllegalStateException("Não pode tornar principal um endereço inativo");
        } else if (this.status.isPrincipal()) {
            throw new IllegalStateException("Já é o endereço principal");
        }
        return new Endereco(
                endereco.logradouro(),
                endereco.bairro(),
                endereco.cidade(),
                endereco.estado(),
                endereco.numero(),
                endereco.cep(),
                EnderecoStatus.PRINCIPAL
        );
    }

    public Endereco setSecundario(Endereco endereco) {
        if (!this.status.isAtivo()) {
            throw new IllegalStateException("Não pode tornar secundário um endereço inativo");
        }else if (this.status.isSecundario()) {
            throw new IllegalStateException("Já é um endereço secundário");
        }
        return new Endereco(
                endereco.logradouro(),
                endereco.bairro(),
                endereco.cidade(),
                endereco.estado(),
                endereco.numero(),
                endereco.cep(),
                EnderecoStatus.SECUNDARIO
        );
    }

    public Endereco setInativo(Endereco endereco) {
        if (!this.status.isAtivo()) {
            throw new IllegalStateException("Já é Inativo");
        }
        return new Endereco(
                endereco.logradouro(),
                endereco.bairro(),
                endereco.cidade(),
                endereco.estado(),
                endereco.numero(),
                endereco.cep(),
                EnderecoStatus.INATIVO
        );
    }


}
