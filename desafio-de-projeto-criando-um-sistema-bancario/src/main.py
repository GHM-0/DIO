from src.Banco.conta import Conta


def main():
    end_program = False

    conta_numero = 0000  #int(input("Digite o número da conta:"))
    conta_titular = "test"  #input("Digite o títular da conta:")

    conta_corrente = Conta(conta_numero, conta_titular, 2000)

    while not end_program:

        operacao = int(
            input("Escolha a Operação:\nDeposito 1\nSaque 2\nExtrato 3\nEntre a Operação:"))  #\nTransferência 03

        if operacao in range(1, 3):
            valor = int(input("Entre o Valor:"))
            if operacao == 1:
                conta_corrente.depositar(valor)
            else:
                conta_corrente.sacar(valor)
        elif operacao == 3:
            conta_corrente.visualizar_extrato()
            exit(0)
        else:
            print(f"Not recognized operation {operacao}")
            end_program = True
            exit(1)


if __name__ == '__main__':
    main()
