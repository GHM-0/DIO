from abc import ABC

from src.Banco.Usuario.Endereco import Endereco


class Usuario(ABC):
    """
    Representa um Usuário Genérico
    """
    """
    Class Attribute:
    _ids (set) : Representa Um set de ids de Usuários
    """
    _ids = set()

    def __init__(self, nome: str, id_: str, endereco: Endereco):
        """
        Inicializa uma Instância de Usuário

        Args:
            nome (str): Nome do Usuário
            id_ (str): Número do id
            endereco (Endereco): Endereço
        """
        self.nome = nome
        self.id_ = self._checar_id(self._formatar_id(id_))
        self.endereco = endereco

    @staticmethod
    def _formatar_id(id_: str):
        """
        Formata um ID removendo pontos e traços

        Args:
            id_ (str): ID formatado

        Returns:
            str: ID formatado
        """
        return id_.translate(str.maketrans("", "", ".-"))

    @classmethod
    def _checar_id(cls, id_: str) -> str:
        """
        Checa se o ID já existe. Se não, adiciona-o ao set _ids

        Args:
            id_ (str): O ID a s er checado e adicionado

        Returns:
            str: O ID validado

        Raises:
            ValueError: Se o ID já existe
        """
        if id_ in cls._ids:
            raise ValueError("ID já existe")
        cls._ids.add(id_)
        return id_

    def __str__(self):
        return f"{self.__class__.__name__}: {', '.join([f'{attr}={value}' for attr, value in self.__dict__.items()])}"
