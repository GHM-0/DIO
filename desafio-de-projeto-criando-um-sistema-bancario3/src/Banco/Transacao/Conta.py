from abc import ABC
from datetime import datetime, timedelta

from src.Banco.Usuario.Usuario import Usuario


class Conta(ABC):
    """
    A classe representa uma conta bancaria genérica.
    """
    """
    Constants:
        _MIN_DEPOSITO (float): Minimo deposito permitido.
        _MIN_SAQUE (float): Minimo saque permitido.
        _MAX_SAQUE (float): Máximo saque permitido.
    """
    _MIN_DEPOSITO = 5
    _MIN_SAQUE = 20
    _MAX_SAQUE = 500

    """
    Attributes:
        _NUM_SAQUES_DIA (int): Número máximo de saques diários
        _NUM_TRANSACOES_DIA (int): Número de máximo de Transações diárias
        _BLOQUEIO_OPERACOES (datatime) : Hora do bloqueio de transações
    """
    _NUM_SAQUES_DIA = 3
    _NUM_TRANSACOES_DIA = 10
    _BLOQUEIO_OPERACOES = None

    """
    Class Attributes:
        _numero_sequencial (int): Número de Instâncias de Conta
    """
    _numero_sequencial = 0

    def __init__(self, titular: Usuario, numero: int = None, saldo: float = 0.00, agencia: int = 1):
        """
        Inicializa uma nova conta bancária.

        Arguments:
            numero (int): O número da conta.
            agencia (int,optional): O número da Agência.
            titular (Usuario): O titular da conta.
            saldo (float,optional): O saldo inicial da conta. O padrão é 0.00
            _log (tuple(str,str)): Registro das entradas criadas pelo objeto
        """

        self.numero = "{:04d}".format(self._get_numero_sequencial(numero))
        self.agencia = "{:04d}".format(agencia)
        self.titular = titular
        self._saldo: float = saldo

        self._log = []

        self.__append_log(f"Conta {self.numero} criada para {self.titular.nome} ID:{self.titular.id_}."
                          f" Saldo inicial: R$={self._saldo}")

    @property
    def __get_current_date(self):
        """
        Obtém a Data Hora atual com precisão de Segundos

        Returns:
        String representando a data hora
        """
        return datetime.now().strftime('%Y-%m-%d %H:%M:%S')

    @property
    def saldo(self) -> float:
        return float(self._saldo.__format__("0.2f"))

    @classmethod
    def _get_numero_sequencial(cls, numero) -> int:
        """
        Gera um número sequencial para a conta se nenhum número for fornecido.

        Arguments:
            numero (int): O número da conta fornecido pelo usuário.

        Returns:
            int: O número sequencial atribuído à conta.
        """
        if numero is None:
            cls._numero_sequencial += 1
            return cls._numero_sequencial
        else:
            return numero

    def sacar(self, valor: float):
        """
        Retira dinheiro de uma conta.

        Arguments:
            valor (float): Quantia a sacar.

        Raises:
            ValueError: Se a quantia for insuficiente para realização do saque.
        """
        try:
            self._bloquear()
            if self._NUM_SAQUES_DIA > 0:  #Número de Saques Restantes

                if valor > self._MAX_SAQUE:  #Valor Máximo do Saque
                    raise ValueError(
                        f"Valor Máximo de Saque excedido.")
                else:
                    if self._saldo >= valor:
                        self._saldo -= valor
                        self.__append_log(
                            f"Saque efetuado conta:{self.numero} Saque=R${valor}.")
                        self._NUM_SAQUES_DIA -= 1
                    else:
                        raise ValueError(
                            f"Saldo Insuficiente.")
                if valor < self._MIN_SAQUE:
                    raise ValueError(
                        f"Valor é inferior ao minimo permitido.")
            else:
                raise ValueError(
                    f"Número máximo de saques atingido.")

        except ValueError as e:
            self.__append_log(
                f"Operação Não permitida:{str(e)}")
            raise

    def depositar(self, valor: float):
        """
        Deposita uma contia na conta.

        Arguments:
            valor (float): quantia a depositar.
        Raises:
            ValueError: Se a quantia for insuficiente para realização do depósito.
        """
        try:
            self._bloquear()
            if float(valor) > 0 and float(valor) >= self._MIN_DEPOSITO:
                self._saldo += valor
                self.__append_log(
                    f"Deposito efetuado com conta:{self.numero} Deposito={valor}.")
            else:
                if valor < self._MIN_DEPOSITO:
                    raise ValueError(
                        f"Valor deve ser maior ou igual a {self._MIN_DEPOSITO}.")
        except ValueError as e:
            self.__append_log(str(e))
            raise

    @property
    def log(self):
        """
        Retorna a última entrada do log
        """
        return self._log[-1]

    def visualizar_extrato(self):
        """
        Mostra o saldo atual e o extrato.

        Returns:
            str: O log completo da conta, incluindo o saldo atual.
        """
        entries_str = '\n'.join(f"{entry[0]} - {entry[1]}" for entry in self._log)
        return f"###########################################################\n" \
               f"Histórico:\n{entries_str}\nSaldo Atual=R${self.saldo}."

    def transferir(self, valor, other):
        """
        Transfere fundos de uma conta para outra.

        Arguments:
            valor (float): A quantia a ser transferida.
            other (Conta): A conta de destino da transferência.

        Returns:
            bool: "True" se a transferência for bem-sucedida, "False" caso contrário.
        """
        try:
            self._bloquear()
            self._MAX_SAQUE = max(self._saldo, self._MAX_SAQUE)
            if self._saldo >= valor > 0:
                self.sacar(valor=valor)
                self.__append_log(
                    f"Transferência para conta {other.numero} titular {other.titular} valor:{valor}.")
                other.depositar(valor)
                other.__append_log(
                    f"Transferência da conta {self.numero} titular {self.titular} valor:{valor}.")
                return True
            else:
                self.__append_log(
                    f"Transferência falhou: Saldo insúficiente.")
                return False
        except ValueError as e:
            self.__append_log(
                f"Falha Transferência: {e}.")
            raise

    def __append_log(self, mensagem: str):
        """
        Adiciona uma entrada ao log.

        Args:
            mensagem (str): mensagem.
        """
        self._log.append((self.__get_current_date, mensagem))

    def reset_saques(self):
        """
        Reseta o número de saques diários
        """
        self._NUM_SAQUES_DIA = 3

    def max_saque(self, valor: int):
        if valor > 0:
            self._MAX_SAQUE = valor

    def _bloquear(self) -> bool:
        result = False
        try:

            # Se hover Bloqueio
            if self._BLOQUEIO_OPERACOES is not None:
                # Se a datetime atual > que o limit do bloqueio
                if self._BLOQUEIO_OPERACOES + timedelta(days=1) <= datetime.now():
                    self._BLOQUEIO_OPERACOES = None
                    self.reset_saques()  #self._NUM_SAQUES_DIA = 3
                    self._NUM_TRANSACOES_DIA = 10

                    self.__append_log(f"Operações Desbloqueadas at"
                                      f" {datetime.now()}.")
                    result = False
                result = True
            # Se não houver bloqueio
            else:
                if self._NUM_TRANSACOES_DIA <= 0:
                    self._BLOQUEIO_OPERACOES = datetime.now()
                    raise ValueError(f"Operações Bloqueadas em {self._BLOQUEIO_OPERACOES}.")
                else:
                    self._NUM_TRANSACOES_DIA -= 1
                    self.__append_log(f"Operações Restantes {self._NUM_TRANSACOES_DIA}.")
                    return False

        except ValueError as e:
            raise e

        return True

    def __str__(self) -> str:
        return f"{self.__class__.__name__}: {', '.join([f'{attr}={value}' for attr, value in self.__dict__.items()])}."
