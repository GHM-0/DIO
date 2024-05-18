from src.Banco.Usuario.Endereco import Endereco
import pytest


@pytest.fixture
def clean_up():
    yield


def main():
    test_endereco()


def test_endereco():
    endereco1 = Endereco(logradouro="Rua A", numero="123", bairro="Centro", cidade="São Paulo", estado="SP")

    assert endereco1.logradouro == "Rua A"
    assert endereco1.numero == "123"
    assert endereco1.bairro == "Centro"
    assert endereco1.cidade == "São Paulo"
    assert endereco1.estado == "SP"

    expected_dict = {
        "logradouro": "Rua A",
        "numero": "123",
        "bairro": "Centro",
        "cidade": "São Paulo",
        "estado": "SP"
    }
    assert endereco1.to_dict() == expected_dict

    print(endereco1)
    expected_str = "Endereco: logradouro=Rua A, numero=123, bairro=Centro, cidade=São Paulo, estado=SP"
    assert str(endereco1) == expected_str


if __name__ == '__main__':
    main()
