from src.Banco.Transacao.Conta import Conta, Usuario


class ContaCorrente(Conta):
    def __init__(self, titular: Usuario, numero: int = None, saldo: float = 0.00, agencia: int = 1):
        super().__init__(titular, numero, saldo, agencia)
