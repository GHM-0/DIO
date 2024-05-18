from src.Banco.Usuario.PessoaFisica import PessoaFisica, Usuario, Endereco
from src.Banco.Usuario.PessoaJuridica import PessoaJuridica
import pytest


@pytest.fixture
def clean_up():
    yield


def main():
    test_Usuario_pessoa_fisica()
    test_Usuario_pessoa_juridica()
    test_Conta_ID_Error()


def test_Usuario_pessoa_fisica():
    usuario1 = PessoaFisica("Usuario_CPF", "0001",
                            Endereco(logradouro="Rua A", numero="123", bairro="Centro", cidade="São Paulo",
                                     estado="SP"))

    assert isinstance(usuario1, Usuario) == True
    assert usuario1.nome == "Usuario_CPF"
    assert usuario1.id_ == "0001"

    expected_str = 'PessoaFisica: nome=Usuario_CPF, id_=0001, endereco=Endereco: logradouro=Rua A, numero=123, bairro=Centro, cidade=São Paulo, estado=SP.'

    assert usuario1.__str__() == expected_str
    assert isinstance(usuario1, PessoaJuridica) == False


def test_Usuario_pessoa_juridica():
    usuario2 = PessoaJuridica("Usuario_CNPJ", "9999",
                              Endereco(logradouro="Rua X", numero="412", bairro="Porto", cidade="Cuiba", estado="SC"))

    assert isinstance(usuario2, Usuario) == True
    assert usuario2.nome == "Usuario_CNPJ"
    assert usuario2.id_ == "9999"

    expected_str = 'PessoaJuridica: nome=Usuario_CNPJ, id_=9999, endereco=Endereco: logradouro=Rua X, numero=412, bairro=Porto, cidade=Cuiba, estado=SC.'

    assert usuario2.__str__() == expected_str
    assert isinstance(usuario2, PessoaFisica) == False


def test_Conta_ID_Error():
    with pytest.raises(ValueError) as e:
        usuario3 = PessoaFisica("Usuario_CPF", "0001",
                                Endereco(logradouro="Rua A", numero="123", bairro="Centro", cidade="São Paulo",
                                         estado="SP"))
    assert str(e.value) == "ID já existe."

    with pytest.raises(ValueError) as e:
        usuario4 = PessoaJuridica("Usuario_CNPJ", "9999",
                                  Endereco(logradouro="Rua X", numero="412", bairro="Porto", cidade="Cuiba",
                                           estado="SC"))
    assert str(e.value) == "ID já existe."


if __name__ == "__main__":
    main()
