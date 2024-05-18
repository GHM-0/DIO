from src.Banco.Transacao.Transacao import Transacao
from src.Banco.Transacao.Conta import Conta
from typing import override


class Saque(Transacao):

    def __init__(self, valor: float, conta_origem: Conta):
        super().__init__(valor, conta_origem)

    @override
    def _operation(self) -> bool:
        try:
            self.conta_origem.sacar(self.valor)
            return True
        except ValueError:
            return False
