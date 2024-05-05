from src.Banco.usuario import Usuario


class Conta:
    """
    A classe representa uma conta bancaria.
    """

    """
    Constants:
        MIN_DEPOSITO (float): Minimo deposito permitido.
        MIN_SAQUE (float): Minimo saque permitido.
    """
    MIN_DEPOSITO = 5
    MIN_SAQUE = 20

    """
    Attributes:
        max_saque (int): Máximo saque permitido
        num_saques_dia (int): Número máximo de saques diários
    """
    max_saque = 500
    num_saques_dia = 3

    """
    Class Attributes:
        _numero_sequencial (int): Número de Instâncias de Conta
    """
    _numero_sequencial = 0

    def __init__(self, titular: Usuario, numero: int = None, saldo: float = 0.00, agencia: int = 1):
        """
        Inicializa uma nova conta bancária.

        Args:
            numero (int): O número da conta.
            agencia (int,optional): O número da Agência.
            titular (Usuario): O titular da conta.
            saldo (float,optional): O saldo inicial da conta. O padrão é 0.00
        """

        self.numero = "{:04d}".format(self._get_numero_sequencial(numero))
        self.agencia = "{:04d}".format(agencia)
        self.titular = titular
        self.saldo = saldo
        self._log = [
            f"Conta {self.numero} criada para {self.titular.nome} CPF:{self.titular.cpf}."
            f"Saldo inicial: R$={self.saldo}"
        ]

    @classmethod
    def _get_numero_sequencial(cls, numero):
        """
        Gera um número sequencial para a conta se nenhum número for fornecido.

        Args:
            numero (int): O número da conta fornecido pelo usuário.

        Returns:
            int: O número sequencial atribuído à conta.
        """
        if numero is None:
            cls._numero_sequencial += 1
            return cls._numero_sequencial
        else:
            return numero

    def sacar(self, *, valor):
        """
        Retira dinheiro de uma conta.

        Args:
            valor (float): quantia a sacar.

        Raises:
            ValueError: Se a quantia for insuficiente para realização do saque.
        """
        try:

            if self.num_saques_dia > 0:

                if valor > self.max_saque:
                    raise ValueError("Valor Máximo de Saque excedido")
                else:
                    if self.saldo >= valor:
                        self.saldo -= valor
                        self.__append_log(f"Saque efetuado conta:{self.numero} Saque=R${valor}")
                        self.num_saques_dia -= 1
                    else:
                        raise ValueError("Saldo Insuficiente")
            else:
                raise ValueError("Número máximo de saques atingido")

        except ValueError as e:
            self.__append_log(f"Operação Não permitida:{str(e)}")

    def depositar(self, valor, **kwargs):
        """
        Deposita uma contia na conta.

        Args:
            valor (float): quantia a depositar.
        Raises:
            ValueError: Se a quantia for insuficiente para realização do depósito.
        """
        try:
            if valor > 0 and valor >= self.MIN_DEPOSITO:
                self.saldo += valor
                self.__append_log(f"Deposito efetuado com conta:{self.numero} Deposito={valor}")
        except ValueError:
            self.__append_log(f"Valor deve ser positivo e maior ou igual a {self.MIN_DEPOSITO}")

    """
        append_log(log: str)
            cria novas entradas a LOG da conta.

        Args:
            log (str): adiciona mensagem ao LOG.
    """

    @property
    def log(self):
        """
        Registra as transações da conta.
        """
        return '\n'.join(self._log)

    """
    Mostra o saldo atual e o extrato.

    Returns:
        str: O log completo da conta, incluindo o saldo atual.
    """

    def visualizar_extrato(self):
        return f"{self._log}\nSaldo Atual={self.saldo}"

    """
        transferir(other,value)
            transfere fundos de uma conta para outra.
    """

    def transferir(self, valor, other):
        """
        Transfere fundos de uma conta para outra.

        Args:
            valor (float): A quantia a ser transferida.
            other (Conta): A conta de destino da transferência.

        Returns:
            bool: "Verdadeiro" se a transferência for bem-sucedida, "Falso" caso contrário.
        """
        try:
            self.max_saque = max(self.saldo, self.max_saque)
            if self.saldo >= valor > 0:
                self.sacar(valor=valor)
                self.__append_log(f"Transferência para conta {other.numero} titular {other.titular} valor:{valor}")
                other.depositar(valor)
                other.__append_log(f"Transferência da conta {self.numero} titular {self.titular} valor:{valor}")
                return True
            else:
                return False
        except ValueError as e:
            self.__append_log(f"Transferência falhou: {e}")
            return False

    def __append_log(self, mensagem):
        """
        Adiciona uma entrada ao log.

        Args:
            mensagem (str): mensagem.
        """
        self._log.append(mensagem)

    def __str__(self):
        return f"Titular={self.titular.nome}, Número={self.numero} e Agência {self.agencia}"
