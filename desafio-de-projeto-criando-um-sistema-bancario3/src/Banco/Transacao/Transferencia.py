from typing import override

from src.Banco.Transacao.Conta import Conta
from src.Banco.Transacao.Transacao import Transacao


class Transferencia(Transacao):

    def __init__(self, valor: float, conta_origem: Conta, conta_destino: Conta):
        super().__init__(valor, conta_origem, conta_destino)

    @override
    def _operation(self) -> bool:
        return self.conta_origem.transferir(self.valor, self.conta_destino)
