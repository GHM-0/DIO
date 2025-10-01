package org.example.core.domain.cliente;

import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.NonNull;
import lombok.Setter;

import org.example.core.domain.cliente.validation.ValidaIdentidade;
import org.example.core.domain.local.agencia.Agencia;
import org.example.core.domain.local.Endereco;
import org.example.core.domain.exception.BusinessException;

import java.time.LocalDate;
import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Collectors;

/**
     * Classe abstrata que representa um cliente genérico no sistema.
     * Define os atributos e comportamentos básicos que todos os tipos de clientes devem ter.
     * Utiliza validações para garantir a integridade dos dados e implementa o padrão State para gerenciar o estado de cliente.
     *
     * @Getter Anotação do Lombok para gerar automaticamente os getters
     * @ValidaIdentidade Anotação customizada para validar a identidade do cliente
     */

@Getter
@ValidaIdentidade
public abstract class Cliente implements ITitular{

    /**
     * ID único do cliente, gerado automaticamente
     */
    private final String id;

    /**
     * Identificador único do cliente (como CPF, CNPJ, etc.)
     */
    // @Setter
    @NotBlank private String identificador;

    /**
     * Endereços do cliente
     */
    // @Setter
   @NonNull private Set<Endereco> enderecos =  new TreeSet<>();

    /**
     * Nome do cliente (nome para pessoa física, nome fantasia para jurídica)
     */
    // @Setter
    @NonNull private String idNominal;

    /**
     * Afiliação do cliente (sobrenome para pessoa física, razão social para jurídica)
     */
    // @Setter
    @NonNull private String idSupraNominal;

    /**
     * Agência à qual o cliente está vinculado
     */
    // @Setter
    @NonNull private Agencia agencia;

    /**
     * Data de criação do cadastro do cliente
     */
    @NonNull private LocalDate dataOrigem;

    /**
     * Estado atual do cliente (implementa o padrão State)
     * Controla o comportamento do cliente baseado em seu estado (Ativo, Inativo, etc.)
     */
    @Setter private EstadoCliente estado;

    protected Cliente(
           @NonNull String nome,
           @NonNull String sobrenome,
           @NonNull String identificador,
           @NonNull LocalDate dataOrigem,
           @NonNull Agencia agencia,
           @NonNull Endereco endereco){


        this.id = this.criarId();

        // Validação de Blank e Nulidade
        this.idNominal = nome;
        this.idSupraNominal = sobrenome;

        // Validação de Nulidade
        this.agencia = agencia;
        this.dataOrigem = dataOrigem;

        // TODO -> Validar com anotação, Especifica para subclasses
        this.identificador = identificador;

        this.setEstado(new ClienteAtivo());
        this.addEndereco(endereco);
    }

    public void setEnderecoPrincipal(Endereco enderecoPrincipal) throws BusinessException {

        if (!enderecoPrincipal.status().isAtivo()) {
            throw new IllegalStateException("Endereço inativo não pode ser principal");
        }

        boolean enderecoExiste = enderecos.stream()
                .anyMatch(e -> e.equals(enderecoPrincipal));

        if (!enderecoExiste) {
            throw new BusinessException("Endereço não pertence a este cliente");
        }


        this.enderecos = enderecos.stream()
                .map(endereco -> {
                    if (endereco.equals(enderecoPrincipal)) {
                        return endereco.setPrincipal(endereco);
                    } else if (endereco.status().isPrincipal()) {
                        return endereco.setSecundario(endereco);
                    }
                    return endereco;
                })
                .collect(Collectors.toCollection(TreeSet::new));
    }

    public void addEndereco(@NonNull Endereco endereco) {
        if (!endereco.status().isAtivo()) {
            throw new IllegalArgumentException("Endereço inativo não pode ser adicionado");
        }

        if (this.enderecos.contains(endereco)) {
            return;
        }

        this.enderecos.add(endereco);
    }

    @Override
    public String toString(){
        return "Cliente [ "+this.getClass().getSimpleName()+
                ", id:"+this.id+
                ", nome:"+this.idNominal+" "+this.idSupraNominal+", "+
                this.identificador+" "+
                this.getStatus()+" "+
                this.enderecos.toString()+"]";
    }

    @Override
    public boolean isAtivo() {
        return this.getStatus() == ClienteStatus.ATIVO;
    }

    public ClienteStatus getStatus() {
        return estado.getStatus();
    }

    // TODO
    protected abstract String criarId();
}
