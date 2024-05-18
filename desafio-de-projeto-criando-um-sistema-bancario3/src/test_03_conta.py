from datetime import datetime

from src.Banco.Transacao.ContaCorrente import ContaCorrente
from src.Banco.Usuario.PessoaFisica import PessoaFisica, Endereco
from src.Banco.Usuario.PessoaJuridica import PessoaJuridica

import pytest

# Deve ser inicializado uma única vez
usuario1 = PessoaFisica("Usuário_CPF", "1000",
                        Endereco(logradouro="Rua A", numero="123", bairro="Centro", cidade="São Paulo",
                                 estado="SP"))

usuario2 = PessoaJuridica("Usuário_CNPJ", "8888",
                          Endereco(logradouro="Rua X", numero="412", bairro="Porto", cidade="Cuiba", estado="SC"))


@pytest.fixture
def clean_up():
    yield


@pytest.fixture
def conta_origem() -> ContaCorrente:
    return ContaCorrente(usuario1, saldo=0.00)


@pytest.fixture
def conta_destino() -> ContaCorrente:
    return ContaCorrente(usuario2, saldo=0.00)


def main():
    test_Conta()
    test_Deposit(conta_origem())
    test_Deposit_Invalid(conta_origem())
    test_Withdraw(conta_origem())
    test_Withdraw_Invalid(conta_origem())
    test_Transference(conta_origem(), conta_destino())
    test_Transference_Failed(conta_origem(), conta_destino())


def test_Conta():
    usuario3 = PessoaFisica("Usuário_CPF", "0001",
                            Endereco(logradouro="Rua A", numero="123", bairro="Centro", cidade="São Paulo",
                                     estado="SP"))
    conta1 = ContaCorrente(usuario3)

    assert conta1.titular.nome == "Usuário_CPF"
    assert conta1.titular.id_ == "0001"
    assert conta1.saldo == 0.0

    log = conta1.log
    
    assert log[1] == (f"Conta {conta1.numero} criada para {conta1.titular.nome} ID:{conta1.titular.id_}."
                      f" Saldo inicial: R$={conta1.saldo}")


def test_Deposit(conta_origem):
    conta1 = conta_origem
    conta1.depositar(400.25)

    log = conta1.log

    
    assert log[1] == f"Deposito efetuado com conta:{conta1.numero} Deposito={400.25}."
    assert conta1.saldo == 400.25


def test_Deposit_Invalid(conta_origem):
    with pytest.raises(ValueError) as e:
        conta1 = conta_origem
        conta1.depositar(0.00)
        log = conta1.log
        
        assert log[1] == f"Valor deve ser maior ou igual a 5."
    assert str(e.value) == f"Valor deve ser maior ou igual a 5."


def test_Withdraw(conta_origem):
    conta1 = conta_origem
    conta1.depositar(400.25)
    conta1.sacar(valor=400)
    log = conta1.log
    
    assert log[1] == f"Saque efetuado conta:{conta1.numero} Saque=R$400."
    assert conta1.saldo == 0.25


def test_Withdraw_Invalid(conta_origem):
    # Valor do Saque excede o Saldo
    with pytest.raises(ValueError) as e:
        conta1 = conta_origem
        conta1.depositar(400.25)
        conta1.sacar(500)
        log = conta1.log
        
        assert log[1] == f"Saldo Insuficiente."
    assert str(e.value) == f"Saldo Insuficiente."

    # Numero Máximo de Saques
    with pytest.raises(ValueError) as e:
        conta1 = conta_origem
        conta1.depositar(400)
        conta1.sacar(valor=100)
        conta1.sacar(valor=100)
        conta1.sacar(valor=100)
        conta1.sacar(valor=100)
        log = conta1.log
        
        assert log[1] == f"Número máximo de saques atingido."
    assert str(e.value) == f"Número máximo de saques atingido."

    # Valor do Saque menor que o minímo permitido
    with pytest.raises(ValueError) as e:
        conta2 = conta_origem
        conta2.reset_saques()
        conta2.depositar(400)
        conta2.sacar(valor=2)
        log = conta2.log

        
        assert log[1] == f"Valor é inferior ao minimo permitido."
    assert str(e.value) == f"Valor é inferior ao minimo permitido."


def test_Transference(conta_origem, conta_destino):
    conta_empresa = conta_destino
    conta_empresa.depositar(valor=100000000)
    conta_pessoa_fisica = conta_origem
    assert conta_empresa.transferir(2000, conta_pessoa_fisica) == True

    log1 = conta_empresa.log
    log2 = conta_pessoa_fisica.log

    assert log1[0] == f"{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}"
    assert log1[1] == f"Transferência para conta {conta_pessoa_fisica.numero} titular {conta_pessoa_fisica.titular} valor:2000."

    assert log2[0] == f"{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}"
    assert log2[1] == f"Transferência da conta {conta_empresa.numero} titular {conta_empresa.titular} valor:2000."
    assert conta_empresa.saldo == 99998000.0
    assert conta_pessoa_fisica.saldo == 2000.0


def test_Transference_Failed(conta_origem, conta_destino):
    conta_empresa = conta_destino
    conta_empresa.depositar(valor=100000000)
    conta_pessoa_fisica = conta_origem
    conta_pessoa_fisica.depositar(400)
    conta_pessoa_fisica.transferir(2000, conta_empresa)

    log1 = conta_pessoa_fisica.log

    assert log1[0] == f"{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}"
    assert log1[1] == f"Transferência falhou: Saldo insúficiente."


if __name__ == "__main__":
    main()
