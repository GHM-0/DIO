# Use uma imagem base do Python
FROM python:3.12-slim

# Defina o diretório de trabalho
WORKDIR /app

# Copie os arquivos de requisitos e instale as dependências
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copie o restante do código da aplicação
COPY app/ .

# Exponha a porta em que a aplicação irá rodar
EXPOSE 5000

# Defina o comando para iniciar a aplicação
CMD ["python", "app.py"]
