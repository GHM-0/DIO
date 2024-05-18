from datetime import datetime

from src.Banco.Transacao.ContaCorrente import ContaCorrente
from src.Banco.Usuario.PessoaFisica import PessoaFisica, Endereco
from src.Banco.Usuario.PessoaJuridica import PessoaJuridica

from src.Banco.Transacao.Deposito import Deposito
from src.Banco.Transacao.Saque import Saque
from src.Banco.Transacao.Transferencia import Transferencia

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
    test_Deposit(conta_origem())
    test_Deposit_Invalid(conta_origem())
    test_Withdraw(conta_origem())
    test_Withdraw_Invalid_saldo_insuficiente(conta_origem())
    test_Withdraw_Invalid_num_max_saques(conta_origem())
    test_Withdraw_Invalid_valor_menor(conta_origem())
    test_Transference(conta_origem(), conta_destino())
    test_Transference_Failed(conta_origem(), conta_destino())


def test_Deposit(conta_origem):
    conta1 = conta_origem
    assert conta1.saldo == 0.00

    deposito1 = Deposito(156.78, conta1)
    assert conta1.saldo == 156.78

    #Objeto Transação
    assert str(deposito1) == (f"Transação(Deposito - data={datetime.now().strftime('%Y-%m-%d %H:%M:%S')},"
                              f" Origem={conta1.numero},"
                              f" Destino={conta1.numero},"
                              f" Valor R${deposito1.valor},"
                              f" Resultado={deposito1.result})")
    #Objeto Conta
    log = conta1.log

    assert log[1] == f"Deposito efetuado com conta:{conta1.numero} Deposito={deposito1.valor}"

    #Objeto Histórico
    assert deposito1.registro.entradas == [(datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
                                            conta1.numero,
                                            conta1.numero, deposito1.__class__.__name__, 156.78, True)]


def test_Deposit_Invalid(conta_origem):
    conta1 = conta_origem

    deposito1 = Deposito(0.00, conta1)

    # Objeto Transação
    assert str(deposito1) == (f"Transação(Deposito - data={datetime.now().strftime('%Y-%m-%d %H:%M:%S')},"
                              f" Origem={conta1.numero},"
                              f" Destino={conta1.numero},"
                              f" Valor R${deposito1.valor},"
                              f" Resultado={deposito1.result})")

    # Objeto Conta
    log = conta1.log

    assert log[1] == f"Valor deve ser maior ou igual a 5"

    # Objeto Histórico
    last_entry = [deposito1.registro.entradas[-1]]
    assert last_entry == [(datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
                           conta1.numero,
                           conta1.numero,
                           deposito1.__class__.__name__,
                           0.00, False)]


def test_Withdraw(conta_origem):
    conta1 = conta_origem
    assert conta1.saldo == 0.00

    deposito1 = Deposito(400.25, conta1)
    assert conta1.saldo == 400.25

    saque1 = Saque(400, conta1)

    log = conta1.log

    assert log[1] == f"Saque efetuado conta:{conta1.numero} Saque=R$400"
    assert conta1.saldo == 0.25

    # Objeto Histórico
    last_entry = [saque1.registro.entradas[-1]]
    assert last_entry == [(datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
                           conta1.numero,
                           conta1.numero,
                           saque1.__class__.__name__,
                           400, True)]


def test_Withdraw_Invalid_saldo_insuficiente(conta_origem):
    conta1 = conta_origem
    assert conta1.saldo == 0.00

    deposito1 = Deposito(400.25, conta1)
    assert conta1.saldo == 400.25

    saque1 = Saque(500, conta1)

    log = conta1.log

    assert log[1] == f"Operação Não permitida:Saldo Insuficiente"

    # Objeto Histórico
    last_entry = [saque1.registro.entradas[-1]]
    assert last_entry == [(datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
                           conta1.numero,
                           conta1.numero,
                           saque1.__class__.__name__,
                           500, False)]


def test_Withdraw_Invalid_num_max_saques(conta_origem):
    conta2 = conta_origem
    assert conta2.saldo == 0.00

    deposito1 = Deposito(500, conta2)
    assert conta2.saldo == 500

    saque1 = Saque(101, conta2)

    # Objeto Histórico
    last_entry = [saque1.registro.entradas[-1]]
    assert last_entry == [(datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
                           conta2.numero,
                           conta2.numero,
                           saque1.__class__.__name__,
                           101, True)]

    saque2 = Saque(102, conta2)

    # Objeto Histórico
    last_entry = [saque1.registro.entradas[-1]]
    assert last_entry == [(datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
                           conta2.numero,
                           conta2.numero,
                           saque1.__class__.__name__,
                           102, True)]

    saque3 = Saque(103, conta2)

    # Objeto Histórico
    last_entry = [saque1.registro.entradas[-1]]
    assert last_entry == [(datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
                           conta2.numero,
                           conta2.numero,
                           saque1.__class__.__name__,
                           103, True)]

    saqueE = Saque(100, conta2)
    # Objeto Histórico
    last_entry = [saque1.registro.entradas[-1]]
    assert last_entry == [(datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
                           conta2.numero,
                           conta2.numero,
                           saque1.__class__.__name__,
                           100, False)]

    log = conta2.log

    assert log[1] == f"Operação Não permitida:Número máximo de saques atingido"


def test_Withdraw_Invalid_valor_menor(conta_origem):
    conta2 = conta_origem
    conta2.reset_saques()
    assert conta2.saldo == 0.00

    deposito1 = Deposito(400, conta2)
    saque1 = Saque(2, conta2)

    last_entry = [saque1.registro.entradas[-1]]
    assert last_entry == [(datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
                           conta2.numero,
                           conta2.numero,
                           saque1.__class__.__name__,
                           2, False)]

    log = conta2.log

    assert log[1] == f"Operação Não permitida:Valor é inferior ao minimo permitido"


def test_Transference(conta_origem, conta_destino):
    conta_empresa = conta_destino
    assert conta_empresa.saldo == 0.00

    depositar1 = Deposito(100000000, conta_empresa)
    assert conta_empresa.saldo == 100000000

    conta_empresa.max_saque(5000)

    conta_pessoa_fisica = conta_origem

    transferencia1 = Transferencia(2000, conta_empresa, conta_pessoa_fisica)

    # Objeto Histórico
    last_entry = [transferencia1.registro.entradas[-1]]
    assert last_entry == [(datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
                           conta_empresa.numero,
                           conta_pessoa_fisica.numero,
                           transferencia1.__class__.__name__,
                           2000, True)]

    log1 = conta_empresa.log
    log2 = conta_pessoa_fisica.log

    assert log1[1] == (f"Transferência para conta {conta_pessoa_fisica.numero}"
                       f" titular {conta_pessoa_fisica.titular} valor:2000")

    assert log2[1] == (f"Transferência da conta {conta_empresa.numero}"
                       f" titular {conta_empresa.titular} valor:2000")

    assert conta_empresa.saldo == 99998000.0
    assert conta_pessoa_fisica.saldo == 2000.0


def test_Transference_Failed(conta_origem, conta_destino):
    conta_empresa = conta_destino
    assert conta_empresa.saldo == 0.00

    deposito1 = Deposito(100000000, conta_empresa)
    assert conta_empresa.saldo == 100000000

    conta_pessoa_fisica = conta_origem
    assert conta_pessoa_fisica.saldo == 0.00

    deposito2 = Deposito(400, conta_pessoa_fisica)
    conta_pessoa_fisica.max_saque(5000)

    assert conta_pessoa_fisica.saldo == 400

    transferencia1 = Transferencia(2000, conta_pessoa_fisica, conta_empresa)

    last_entry = [transferencia1.registro.entradas[-1]]
    assert last_entry == [(datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
                           conta_pessoa_fisica.numero,
                           conta_empresa.numero,
                           transferencia1.__class__.__name__,
                           2000, False)]

    log1 = conta_pessoa_fisica.log

    assert log1[1] == f"Transferência falhou: Saldo insúficiente"


if __name__ == "__main__":
    main()
