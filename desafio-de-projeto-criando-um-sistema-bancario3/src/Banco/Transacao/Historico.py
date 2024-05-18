from datetime import datetime
from typing import List, Tuple

class Historico:
    def __init__(self):
        self._registro: List[Tuple[str, str, str, str, float, bool]] = []

    @property
    def entradas(self) -> List[Tuple[str, str, str, str, float, bool]]:
        return self._registro

    def append_entrada(self, transacao: Tuple[str, str, str, str, float, bool]):
        self._registro.append(transacao)
