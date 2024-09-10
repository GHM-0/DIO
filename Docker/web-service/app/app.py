from flask import Flask
import psycopg2
import random
import os

app = Flask(__name__)

def get_random_name():
    # Conectar ao banco de dados PostgreSQL
    connection = psycopg2.connect(
        host='postgres',
        user=os.getenv('POSTGRES_USER', 'user_postgres'),
        password=os.getenv('POSTGRES_PASSWORD', 'user_passwd'),
        dbname=os.getenv('POSTGRES_DB', 'test_data')
    )
    cursor = connection.cursor()

    # Consulta para selecionar um nome aleatório
    cursor.execute("SELECT name FROM names ORDER BY RANDOM() LIMIT 1")
    result = cursor.fetchone()

    cursor.close()
    connection.close()

    return result[0] if result else 'World'

@app.route('/')
def hello_world():
    name = get_random_name()
    return f'Hello, {name}!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

