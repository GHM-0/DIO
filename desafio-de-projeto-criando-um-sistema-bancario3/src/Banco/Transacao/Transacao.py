from abc import ABC, abstractmethod
from datetime import datetime
from typing import Tuple

from src.Banco.Transacao.Conta import Conta
from src.Banco.Transacao.Historico import Historico


class Transacao(ABC):
    registro = Historico()

    def __init__(self, valor: float, conta_origem: Conta, conta_destino: Conta = None):
        self.valor = valor
        self.conta_origem = conta_origem

        if not conta_destino:
            self.conta_destino = conta_origem
        else:
            self.conta_destino = conta_destino

        self._date = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        self.result = self._operation()
        self.__registrar()

    def __registrar(self):
        self.registro.append_entrada((self._date, self.conta_origem.numero,
                                      self.conta_destino.numero, self.__class__.__name__, self.valor, self.result))

    @abstractmethod
    def _operation(self) -> bool:
        pass

    def __str__(self):
        return (f"Transação({self.__class__.__name__}"
                f" - data={self._date},"
                f" Origem={self.conta_origem.numero},"
                f" Destino={self.conta_destino.numero},"
                f" Valor R${self.valor},"
                f" Resultado={self.result})")
