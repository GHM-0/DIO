from dataclasses import dataclass
from typing import Dict


@dataclass
class Endereco:
    """Representa um endereço

    Attributes:
        logradouro (str): O nome da rua ou avenida
        numero (str): O número do endereço
        bairro (str): O bairro do endereço
        cidade (str): A cidade do endereço
        estado (str): O estado do endereço (sigla com dois caracteres)

    Methods:
        to_dict(): Retorna uma representação do endereço como um dicionário
    """

    logradouro: str
    numero: str
    bairro: str
    cidade: str
    estado: str

    def __post_init__(self):
        self.bairro = self.bairro
        self.cidade = self.cidade
        self.estado = self.__set_estado(self.estado)

    def to_dict(self) -> Dict[str, str]:
        """Retorna uma representação do endereço como um dicionário"""
        return {
            "logradouro": self.logradouro,
            "numero": self.numero,
            "bairro": self.bairro,
            "cidade": self.cidade,
            "estado": self.estado,
        }

    @staticmethod
    def __set_estado(estado: str) -> str:
        """Define o estado do endereço, verificando se tem dois caracteres e convertendo para maiúsculas

        Args:
            estado (str): O estado do endereço (sigla com dois caracteres)

        Returns:
            str: O estado do endereço em maiúsculas

        Raises:
            ValueError: Se o estado não tiver exatamente dois caracteres
        """

        if len(estado) != 2:
            raise ValueError("Estado deve ter dois caracteres apenas")
        return estado.upper()

    def __str__(self) -> str:
        """Retorna uma representação do endereço como uma string

        Returns:
            str: uma representação do endereço como uma string
        """

        return f"{self.__class__.__name__}: {', '.join([f'{attr}={value}' for attr, value in self.__dict__.items()])}"
