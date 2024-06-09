from decimal import Decimal
from typing import List, Optional
from fastapi import APIRouter, Body, Depends, HTTPException, Path, status, Query
from pydantic import UUID4, ValidationError
from store.core.exceptions import NotFoundException, ConflictException

from store.schemas.product import ProductIn, ProductOut, ProductUpdate, ProductUpdateOut
from store.usecases.product import ProductUsecase

router = APIRouter(tags=["products"])


@router.post(path="/", status_code=status.HTTP_201_CREATED)
async def post(
    body: ProductIn = Body(...), usecase: ProductUsecase = Depends()
) -> ProductOut:

    # 422 = Unprocessable Entity / Erros de validação # Ausência de campo obrigatório
    # 409 = Conflict, caso já haja uma entidade igual no banco de dados

    try:
        return await usecase.create(body=body)
    except ConflictException as exc:
        raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail=exc.message)
    except ValidationError as exc:
        raise HTTPException(status_code=status.HTTP_422_UNPROCESSABLE_ENTITY, detail=str(exc.message))


@router.get(path="/{id}", status_code=status.HTTP_200_OK)
async def get(
    id: UUID4 = Path(alias="id"), usecase: ProductUsecase = Depends()
) -> ProductOut:
    try:
        return await usecase.get(id=id)
    except NotFoundException as exc:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=exc.message)


# Implementar Filtro Valor Min Valor Max
@router.get(path="/", status_code=status.HTTP_200_OK)
async def query(usecase: ProductUsecase = Depends(),
                min_val: Optional[Decimal] = Query(None, description="Valor Minimo"),
                max_val: Optional[Decimal] = Query(None, description="Valor Máximo")) -> List[ProductOut]:
    return await usecase.query(min_val,max_val)


@router.patch(path="/{id}", status_code=status.HTTP_200_OK)
async def patch(
    id: UUID4 = Path(alias="id"),
    body: ProductUpdate = Body(...),
    usecase: ProductUsecase = Depends(),
) -> ProductUpdateOut:
    try:
        product = await usecase.get(id=id)
        # product == {"detail": ""}
        if not product:
            raise NotFoundException(f"Não foi encontrado o id:{id}") # Não etá sendo recuperado
        else:
            return await usecase.update(id=id, body=body)

        # If using Update and product doesn't exist should raise 404;
        # But Update Raises 500, So I changed this method to use two Operations it's far from ideal

    except ValidationError as exc:
        raise HTTPException(status_code=status.HTTP_422_UNPROCESSABLE_ENTITY, detail=str(exc.message))

    except NotFoundException as exc:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=str(exc.message))

    # 500? too


@router.delete(path="/{id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete(
    id: UUID4 = Path(alias="id"), usecase: ProductUsecase = Depends()
) -> None:
    try:
        await usecase.delete(id=id)
    except NotFoundException as exc:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=exc.message)
