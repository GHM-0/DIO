from src.Banco.conta import Conta
from src.Banco.endereco import Endereco
from src.Banco.usuario import Usuario


def main():
    end_org = Endereco(logradouro="Rua da Praça", numero="S/N", bairro="porto da Caixas", cidade="Itaboraí",
                       estado='RJ')
    end_dest = Endereco("Outra Rua", "234", "Glória", "Rio de Janeiro", 'rj')

    usuario_origem = Usuario("Origem", "ORIG.I-123", end_org)
    usuario_destino = Usuario("Destino", "DEST.D-098", end_dest)

    print("\n Usuarios CPFS:")
    print(f"{usuario_origem.cpf}")
    print(f"{usuario_destino.cpf}")

    print("\n Endereços:")
    print(f"{str(usuario_origem.endereco)}")
    print(f"{str(usuario_destino.endereco)}")

    conta_orig = Conta(usuario_origem, saldo=200)
    conta_orig2 = Conta(usuario_origem, saldo=1200)
    conta_destino = Conta(usuario_destino, saldo=200)

    print(f"Conta Origem Número={conta_orig.numero}")
    print(f"Conta Origem Número={conta_orig2.numero}")
    print(f"Conta Destino Número={conta_destino.numero}")

    print("\n\n Contas Criadas Saldos = 200")
    conta_orig.visualizar_extrato()
    conta_orig2.visualizar_extrato()
    conta_destino.visualizar_extrato()

    print("\n Conta 2 Deposito de 120 saldo=320")
    conta_destino.depositar(120)
    print("\n Conta 1 transferência 200 saldo=0")
    conta_orig.transferir(200, conta_destino)

    print("\n\n Extratos:")
    print("\n Conta 1 Operação de saque/transferência =200 saldo 0")
    conta_orig.visualizar_extrato()
    print("\n\n Conta 2 Operação de deposito/transferência =200 saldo 520")
    conta_destino.visualizar_extrato()

    print("\nDev ser Zerado o saldo:")
    conta_orig.visualizar_extrato()


if __name__ == '__main__':
    main()
