from src.Banco.Usuario.Usuario import Endereco, Usuario


class PessoaFisica(Usuario):

    def __init__(self, nome: str, id_: str, endereco: Endereco):
        super().__init__(nome, id_, endereco)
