from src.Banco.endereco import Endereco

class Usuario:
    """
    Representa um usuário
    """

    _cpfs = set()

    def __init__(self, nome:str, cpf:str, endereco: Endereco):
        """
        Inicializa uma Instância de Usuário.

        Args:
            nome (str): Nome do Usuário.
            cpf (str): Número do CPF.
            endereco (Endereco): Endereço.
        """
        self.nome = nome
        self.cpf = self._checar_cpf(self._formatar_cpf(cpf))
        self.endereco = endereco

    @staticmethod
    def _formatar_cpf(cpf: str):
        """
        Formata um CPF removendo pontos e traços.

        Args:
            cpf (str): CPF formatado.

        Returns:
            str: CPF formatado.
        """
        return cpf.translate(str.maketrans("", "", ".-"))

    @classmethod
    def _checar_cpf(cls, cpf: str) -> str:
        """
        Checa se o CPF já existe. Se não, adiciona-o ao set _cpfs.

        Args:
            cpf (str): O CPF a s er checado e adicionado.

        Returns:
            str: O CPF validado.

        Raises:
            ValueError: Se o CPF já existe.
        """
        if cpf in cls._cpfs:
            raise ValueError("CPF já existe.")
        cls._cpfs.add(cpf)
        return cpf

    def __str__(self):
        return f"Nome={self.nome} CPF={self.cpf}"
