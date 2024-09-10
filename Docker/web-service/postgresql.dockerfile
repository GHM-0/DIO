# Use a imagem base oficial do PostgreSQL
FROM postgres:latest

LABEL test_postgres="latest"

# Definir variáveis de ambiente para o PostgreSQL
ENV POSTGRES_DB=test_data
ENV POSTGRES_USER=user_postgres
ENV POSTGRES_PASSWORD=user_passwd

# Volumes
VOLUME ["/var/lib/postgresql/data"]

# Copia os Schemas SQL e Insere os Registros
COPY ./init-db/ /docker-entrypoint-initdb.d/

EXPOSE 5432
