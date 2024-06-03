from datetime import datetime
from typing import Optional, Dict
from uuid import uuid4
from fastapi import APIRouter, Body, HTTPException, status, Query, Depends
from pydantic import UUID4
from fastapi_pagination import Page, paginate, LimitOffsetPage

from workout_api.atleta.schemas import AtletaIn, AtletaOut, AtletaUpdate, Atleta
from workout_api.atleta.models import AtletaModel
from workout_api.categorias.models import CategoriaModel
from workout_api.centro_treinamento.models import CentroTreinamentoModel

from workout_api.contrib.dependencies import DatabaseDependency
from sqlalchemy.future import select
from sqlalchemy.exc import IntegrityError


router = APIRouter()


@router.post(
    '/',
    summary='Criar um novo atleta',
    status_code=status.HTTP_201_CREATED,
    response_model=AtletaOut
)
async def post(
        db_session: DatabaseDependency,
        atleta_in: AtletaIn = Body(...)
):
    categoria_nome = atleta_in.categoria.nome
    centro_treinamento_nome = atleta_in.centro_treinamento.nome

    categoria = (await db_session.execute(
        select(CategoriaModel).filter_by(nome=categoria_nome)
    )).scalars().first()

    if not categoria:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=f'A categoria {categoria_nome} não foi encontrada.'
        )

    centro_treinamento = (await db_session.execute(
        select(CentroTreinamentoModel).filter_by(nome=centro_treinamento_nome)
    )).scalars().first()

    if not centro_treinamento:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=f'O centro de treinamento {centro_treinamento_nome} não foi encontrado.'
        )

    try:
        # Como descompactar atleta_in
        atleta_model = AtletaModel(
            nome=atleta_in.nome,
            cpf=atleta_in.cpf,
            idade=atleta_in.idade,
            peso=atleta_in.peso,
            altura=atleta_in.altura,
            sexo=atleta_in.sexo,
            categoria_id=categoria.pk_id,
            centro_treinamento_id=centro_treinamento.pk_id
        )

        db_session.add(atleta_model)
        await db_session.commit()

        # Construir objeto AtletaOut para retornar
        atleta_out = AtletaOut(
            id=str(atleta_model.id),
            created_at=atleta_model.created_at,
            nome=atleta_model.nome,
            categoria_nome=categoria_nome,
            centro_treinamento_nome=centro_treinamento_nome
        )

        return atleta_out

    except IntegrityError as e:
        if 'cpf' in str(e).lower():
            raise HTTPException(
                status_code=status.HTTP_303_SEE_OTHER,
                detail=f"Já existe um atleta cadastrado com o CPF: {atleta_in.cpf}"
            )
        else:
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail='Ocorreu um erro ao inserir os dados no banco'
            )

    except Exception:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail='Ocorreu um erro ao inserir os dados no banco'
        )


@router.get(
    '/',
    summary='Consultar todos os Atletas',
    status_code=status.HTTP_200_OK,
    response_model=LimitOffsetPage[AtletaOut],
)
async def query(db_session: DatabaseDependency,
                nome: Optional[str] = Query(None, description="Nome completo do atleta"),
                cpf: Optional[str] = Query(None, description="CPF do atleta"),
                ) -> Page[AtletaOut]:
    selected = select(AtletaModel)

    if nome and cpf:
        selected = (selected.filter(AtletaModel.nome == nome).filter(AtletaModel.cpf == cpf))

    atletas: list[AtletaOut] = (await db_session.execute(selected)).scalars().all()
    atletas_out = []
    for atleta in atletas:
        atleta_out = AtletaOut(
            id=atleta.id,
            created_at=atleta.created_at,
            nome=atleta.nome,
            categoria_nome=atleta.categoria.nome,
            centro_treinamento_nome=atleta.centro_treinamento.nome
        )
        atletas_out.append(atleta_out)

    return paginate(atletas_out)


@router.get(
    '/{id}',
    summary='Consulta um Atleta pelo id',
    status_code=status.HTTP_200_OK,
    response_model=AtletaOut,

)
async def get(id: UUID4, db_session: DatabaseDependency) -> AtletaOut:
    atleta: AtletaModel = (  # Não é AtletOut o retorno dessa função é AtletaModel
        await db_session.execute(select(AtletaModel).filter_by(id=id))
    ).scalars().first()

    if not atleta:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f'Atleta não encontrado no id: {id}'
        )

    return AtletaOut(
        id=str(atleta.id),
        created_at=atleta.created_at,
        nome=atleta.nome,
        categoria_nome=atleta.categoria.nome,
        centro_treinamento_nome=atleta.centro_treinamento.nome,
    )


@router.patch(
    '/{id}',
    summary='Editar um Atleta pelo id',
    status_code=status.HTTP_200_OK,
    response_model=AtletaOut,
)
async def patch(id: UUID4, db_session: DatabaseDependency, atleta_up: AtletaUpdate = Body(...)) -> AtletaOut:
    atleta: AtletaOut = (
        await db_session.execute(select(AtletaModel).filter_by(id=id))
    ).scalars().first()

    if not atleta:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f'Atleta não encontrado no id: {id}'
        )

    atleta_update = atleta_up.model_dump(exclude_unset=True)
    for key, value in atleta_update.items():
        setattr(atleta, key, value)

    await db_session.commit()
    await db_session.refresh(atleta)

    return atleta


@router.delete(
    '/{id}',
    summary='Deletar um Atleta pelo id',
    status_code=status.HTTP_204_NO_CONTENT
)
async def delete(id: UUID4, db_session: DatabaseDependency) -> None:
    atleta: AtletaOut = (
        await db_session.execute(select(AtletaModel).filter_by(id=id))
    ).scalars().first()

    if not atleta:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f'Atleta não encontrado no id: {id}'
        )

    await db_session.delete(atleta)
    await db_session.commit()
