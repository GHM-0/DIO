class Conta:
    """
    A classe representa uma conta bancaria.
    """

    """
    Constants:
        MIN_DEPOSITO (float): Minimo deposito permitido.
        MIN_SAQUE (float): Minimo saque permitido.
        LOG (str): Log das transações.
    """
    MIN_DEPOSITO = 5
    MAX_SAQUE = 500
    num_saques_dia = 3
    LOG = ""

    """
        __init__(numero:int,titular:str,saldo:float=0.00)
            Inicializa uma nova Conta.

        Args:
            numero (int)
            titular (str)
            saldo (float)
    """

    def __init__(self, numero: int, titular: str, saldo: float = 0.00):
        self.numero = numero
        self.titular = titular
        self.saldo = saldo
        self.append_log(f"Conta:{self.numero} Titular={self.titular} Criada com sucesso Saldo=R${self.saldo}")

    """
        sacar(valor: float)
            Retira dinheiro de uma conta.

        Args:
            valor (float): quantia a sacar.
        Raises:
            ValueError: Se a quantia for insuficiente para realização do saque.
    """

    def sacar(self, valor):
        try:

            if int(self.num_saques_dia) > 0:

                if valor > self.MAX_SAQUE:
                    print("Operation denied = Max Saque excedido")
                    raise ValueError("Valor Máximo de Saque excedido")
                else:
                    if self.saldo >= valor:
                        self.saldo -= valor
                        self.append_log(f"Saque efetuado conta:{self.numero} Saque=R${valor}")
                        self.num_saques_dia -= 1
                    else:
                        print("Operation denied = Saldo")
                        raise ValueError("Saldo Insuficiente")
            else:
                print("Operation denied = Limite de Saques")
                raise ValueError("Número máximo de saques atingido")

        except ValueError:
            print(" Final Operation denied")
            self.append_log(f"Operação Não permitida")

    """
        depositar(valor: float)
            Deposita uma contia na conta.

        Args:
                valor (float): quantia a depositar.
        Raises:
                ValueError:  Se a quantia for insuficiente para realização do deposito.
    """

    def depositar(self, valor):
        try:
            if valor > 0 and valor >= self.MIN_DEPOSITO:
                self.saldo += valor
                self.append_log(f"Deposito efetuado com conta:{self.numero} Deposito={valor}")
        except ValueError:
            self.append_log(f"Valor deve ser positivo e maior ou igual a {self.MIN_DEPOSITO}")

    """
        append_log(log: str)
            cria novas entradas a LOG da conta.

        Args:
            log (str): adiciona mensagem ao LOG.
    """

    def append_log(self, log):
        self.LOG += log + "\n"

    """
        visualizar_extrato()
            Mostra o saldo atual e o extrato
    """

    def visualizar_extrato(self):
        print(f"{self.LOG}\nSaldo Atual={self.saldo}")

    """
        transferir(other,value)
            transfere fundos de uma conta para outra.
    """

    def transferir(self, valor, other):
        try:
            if self.sacar(valor) and other:
                self.append_log(f"Transferência para conta {other.numero} titular {other.titular} valor:{valor}")
                other.depositar(valor)
                other.append_log(f"Transferência da conta {self.numero} titular {self.titular} valor:{valor}")

        except ValueError:
            self.append_log(f"Saldo atual {self.saldo}, insuficiente para transferência de {valor} para {other.numero}")
