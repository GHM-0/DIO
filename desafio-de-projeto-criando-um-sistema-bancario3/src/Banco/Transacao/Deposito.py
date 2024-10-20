from typing import override

from src.Banco.Transacao.Conta import Conta
from src.Banco.Transacao.Transacao import Transacao


class Deposito(Transacao):

    def __init__(self, valor: float, conta_origem: Conta):
        super().__init__(valor, conta_origem)

    @override
    def _operation(self) -> bool:
        try:
            self.conta_origem.depositar(self.valor)
            return True
        except ValueError:
            return False
