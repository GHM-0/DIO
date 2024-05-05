class Endereco:
    """Representa um endereço.

    Attributes:
        logradouro (str): O nome da rua ou avenida.
        número (str): O número do endereço.
        bairro (str): O bairro do endereço.
        cidade (str): A cidade do endereço.
        estado (str): O estado do endereço (sigla com dois caracteres).

    Methods:
        to_dict(): Retorna uma representação do endereço como um dicionário.
    """

    def __init__(self, logradouro: str, numero: str, bairro: str, cidade: str, estado: str):
        """Inicializa um novo objeto Endereco.

        Args:
            logradouro (str): O nome da rua ou avenida.
            número (str): O número do endereço.
            bairro (str): O bairro do endereço.
            cidade (str): A cidade do endereço.
            estado (str): O estado do endereço (sigla com dois caracteres).

        Raises:
            ValueError: Se o estado não tiver exatamente dois caracteres.
        """
        self.logradouro = logradouro
        self.numero = numero
        self.bairro = bairro.capitalize()
        self.cidade = cidade.capitalize()
        self._set_estado(estado)

    def to_dict(self) -> dict:
        """Retorna uma representação do endereço como um dicionário."""
        return {
            "logradouro": self.logradouro,
            "numero": self.numero,
            "bairro": self.bairro,
            "cidade": self.cidade,
            "estado": self.estado
        }

    def _set_estado(self, estado: str):
        """Define o estado do endereço, verificando se tem dois caracteres e convertendo para maiúsculas.

        Args:
            estado (str): O estado do endereço (sigla com dois caracteres).

        Raises:
            ValueError: Se o estado não tiver exatamente dois caracteres.
        """
        if len(estado) != 2:
            raise ValueError("Estado deve ter dois caracteres apenas.")
        self.estado = estado.upper()

    def __str__(self) -> str:
        """Retorna uma representação do endereço como uma string."""
        return f"{self.logradouro}, {self.numero}, {self.bairro}, {self.cidade}/{self.estado}"
