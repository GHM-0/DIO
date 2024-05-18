from src.Banco.Transacao.Conta import Conta
from src.Banco.Usuario.Endereco import Endereco
from src.Banco.Usuario.Usuario import Usuario


def main():
    usuarios = []
    contas = []

    while True:
        print("\n1. Criar novo usuário")
        print("2. Visualizar usuários")
        print("3. Operar conta")
        print("4. Visualizar contas")
        print("5. Sair")

        choice = input("\nEscolha uma opção: ")

        if choice == '1':
            criar_usuario(usuarios)
        elif choice == '2':
            visualizar_usuarios(usuarios)
        elif choice == '3':
            operar_conta(usuarios, contas)
        elif choice == '4':
            visualizar_contas(contas)
        elif choice == '5':
            print("Saindo...")
            break
        else:
            print("Opção inválida. Por favor, escolha uma opção válida.")


def criar_usuario(usuarios):
    print("\nCadastro de novo usuário:")
    nome = input("Nome do usuário: ")
    cpf = input("CPF do usuário: ")
    endereco = cadastrar_endereco()
    usuario = Usuario(nome, cpf, endereco)
    usuarios.append(usuario)
    print("Usuário cadastrado com sucesso!")


def cadastrar_endereco():
    logradouro = input("Logradouro: ")
    numero = input("Número: ")
    bairro = input("Bairro: ")
    cidade = input("Cidade: ")
    estado = input("Estado (sigla): ")
    return Endereco(logradouro, numero, bairro, cidade, estado)


def visualizar_usuarios(usuarios):
    if not usuarios:
        print("Nenhum usuário cadastrado.")
    else:
        print("\nLista de Usuários:")
        for i, usuario in enumerate(usuarios, 1):
            print(f"{i}. Nome: {usuario.nome}, CPF: {usuario.cpf}")


def operar_conta(usuarios, contas):
    if not usuarios:
        print("Nenhum usuário cadastrado. Por favor, cadastre um usuário primeiro.")
        return

    print("\nOperações da Conta:")
    print("1. Criar nova conta")
    print("2. Visualizar extrato")
    print("3. Realizar saque")
    print("4. Realizar depósito")
    print("5. Transferir entre contas")
    print("6. Voltar")

    choice = input("\nEscolha uma opção: ")

    if choice == '1':
        criar_conta(usuarios, contas)
    elif choice == '2':
        visualizar_extrato(contas)
    elif choice == '3':
        realizar_saque(contas)
    elif choice == '4':
        realizar_deposito(contas)
    elif choice == '5':
        transferir_entre_contas(contas)
    elif choice == '6':
        print("Voltando ao menu principal...")
    else:
        print("Opção inválida. Por favor, escolha uma opção válida.")


def criar_conta(usuarios, contas):
    print("\nCriação de nova conta:")
    cpf = input("CPF do usuário associado à conta: ")
    usuario = encontrar_usuario_por_cpf(usuarios, cpf)

    if usuario:
        conta = Conta(usuario)
        contas.append(conta)
        print("Conta criada com sucesso!")
    else:
        print("Usuário não encontrado.")


def encontrar_usuario_por_cpf(usuarios, cpf):
    for usuario in usuarios:
        if usuario.cpf == cpf:
            return usuario
    return None


def visualizar_contas(contas):
    if not contas:
        print("Nenhuma conta criada.")
    else:
        print("\nLista de Contas:")
        for i, conta in enumerate(contas, 1):
            print(f"{i}. Número da Conta: {conta.numero}, Titular: {conta.titular.nome}")


def visualizar_extrato(contas):
    numero_conta = input("\nDigite o número da conta para visualizar o extrato: ")
    for conta in contas:
        if conta.numero == numero_conta:
            print("\nExtrato da conta:")
            print(conta.visualizar_extrato())
            return
    print("Conta não encontrada.")


def realizar_saque(contas):
    numero_conta = input("\nDigite o número da conta para realizar o saque: ")
    for conta in contas:
        if conta.numero == numero_conta:
            valor = float(input("Digite o valor do saque: "))
            conta.sacar(valor=valor)
            print("Saque realizado com sucesso.")
            return
    print("Conta não encontrada.")


def realizar_deposito(contas):
    numero_conta = input("\nDigite o número da conta para realizar o depósito: ")
    for conta in contas:
        if conta.numero == numero_conta:
            valor = float(input("Digite o valor do depósito: "))
            conta.depositar(valor)
            print("Depósito realizado com sucesso.")
            return
    print("Conta não encontrada.")


def transferir_entre_contas(contas):
    numero_conta_origem = input("\nDigite o número da conta de origem: ")
    for conta_origem in contas:
        if conta_origem.numero == numero_conta_origem:
            numero_conta_destino = input("Digite o número da conta de destino: ")
            for conta_destino in contas:
                if conta_destino.numero == numero_conta_destino:
                    valor = float(input("Digite o valor da transferência: "))
                    if conta_origem.transferir(valor, conta_destino):
                        print("Transferência realizada com sucesso.")
                        return
                    else:
                        print("Falha ao transferir. Verifique o saldo da conta de origem.")
                        return
            print("Conta de destino não encontrada.")
            return
    print("Conta de origem não encontrada.")


if __name__ == '__main__':
    main()
