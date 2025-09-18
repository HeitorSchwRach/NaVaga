[NaVaga - Backend do Sistema de Estacionamento Inteligente (1).md](https://github.com/user-attachments/files/22408090/NaVaga.-.Backend.do.Sistema.de.Estacionamento.Inteligente.1.md)
# NaVaga - Backend do Sistema de Estacionamento Inteligente

## Objetivo do Projeto

O projeto **NaVaga** consiste em um sistema de backend desenvolvido em Node.js com Express, projetado para gerenciar vagas de estacionamento inteligentes. Ele permite o registro e autenticação de usuários, o controle do status de vagas (livre/ocupada) através de sensores, e o registro do histórico de uso das vagas. A aplicação interage com um banco de dados PostgreSQL para persistir todas as informações.

## Funcionalidades

-   **Autenticação de Usuários:** Registro e login de usuários com JWT (JSON Web Tokens).
-   **Gerenciamento de Vagas:** Listagem e atualização do status de vagas de estacionamento.
-   **Integração com Sensores:** Processamento de eventos de sensores para atualizar o status das vagas e registrar o histórico.
-   **Histórico de Uso:** Registro detalhado de entrada e saída de veículos nas vagas.

## Estrutura do Projeto

O projeto está organizado da seguinte forma:

```
NaVaga/
├── app.js                  # Ponto de entrada da aplicação
├── db.js                   # Configuração da conexão com o banco de dados
├── package.json            # Metadados do projeto e dependências
├── package-lock.json       # Bloqueio de dependências
├── .env                    # Variáveis de ambiente (não incluído no controle de versão)
├── controllers/            # Lógica de negócio para cada recurso
│   ├── sensores.js
│   ├── usuarios.js
│   └── vagas.js
├── middlewares/            # Middlewares da aplicação (ex: autenticação)
│   └── auth.js
├── routes/                 # Definição das rotas da API
│   ├── sensores.js
│   ├── usuarios.js
│   └── vagas.js
└── sql/                    # Scripts SQL para o banco de dados
    └── NaVaga.sql          # Esquema do banco de dados e dados de exemplo
```

## Instalação

Siga os passos abaixo para configurar e executar o projeto localmente.

### Pré-requisitos

Certifique-se de ter os seguintes softwares instalados em sua máquina:

-   **Node.js** (versão 14 ou superior)
-   **npm** (gerenciador de pacotes do Node.js)
-   **PostgreSQL** (versão 12 ou superior)

### Passos de Instalação

1.  **Clonar o Repositório:**

    ```bash
    git clone <URL_DO_REPOSITORIO>
    cd NaVaga
    ```
    *(Nota: Para este teste, o código já foi descompactado para `/home/ubuntu/NaVaga/NaVaga`)*

2.  **Instalar Dependências:**

    Navegue até o diretório raiz do projeto e instale as dependências:

    ```bash
    cd /home/ubuntu/NaVaga/NaVaga
    npm install
    ```

3.  **Configurar o Banco de Dados PostgreSQL:**

    a.  **Criar o Banco de Dados:**

        Abra um terminal e execute os comandos para criar o banco de dados `navaga` e definir uma senha para o usuário `postgres` (se ainda não tiver uma):

        ```bash
        sudo service postgresql start # Garante que o PostgreSQL esteja rodando
        sudo -u postgres psql -c "CREATE DATABASE navaga;"
        sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'postgres';"
        ```

    b.  **Configurar Autenticação (pg_hba.conf):**

        Edite o arquivo de configuração `pg_hba.conf` para permitir autenticação por senha (md5) para conexões locais. Substitua `peer` por `md5` nas linhas relevantes para `127.0.0.1/32` e `::1/128`.

        ```bash
        sudo nano /etc/postgresql/14/main/pg_hba.conf
        ```
        Procure pelas linhas:
        ```
        host    all             all             127.0.0.1/32            scram-sha-256
        host    all             all             ::1/128                 scram-sha-256
        ```
        E altere-as para:
        ```
        host    all             all             127.0.0.1/32            md5
        host    all             all             ::1/128                 md5
        ```
        Salve e saia do editor (`Ctrl+X`, `Y`, `Enter`).

    c.  **Configurar Criptografia de Senha (postgresql.conf):**

        Edite o arquivo `postgresql.conf` para garantir que a criptografia de senha padrão seja `md5`.

        ```bash
        sudo nano /etc/postgresql/14/main/postgresql.conf
        ```
        Procure pela linha (pode estar comentada):
        ```
        #password_encryption = scram-sha-256
        ```
        E altere-a para:
        ```
        password_encryption = md5
        ```
        Salve e saia do editor (`Ctrl+X`, `Y`, `Enter`).

    d.  **Reiniciar PostgreSQL:**

        ```bash
        sudo service postgresql restart
        ```

    e.  **Importar Esquema e Dados:**

        Importe o esquema do banco de dados e os dados de exemplo usando o arquivo `NaVaga.sql`:

        ```bash
        sudo -u postgres psql -d navaga -f ./sql/NaVaga.sql
        ```

4.  **Configurar Variáveis de Ambiente:**

    Crie um arquivo `.env` na raiz do projeto (`/home/ubuntu/NaVaga/NaVaga/.env`) com o seguinte conteúdo:

    ```env
    DB_HOST=localhost
    DB_PORT=5432
    DB_USER=postgres
    DB_PASSWORD=postgres
    DB_NAME=navaga
    JWT_SECRET=seu_segredo_jwt # Altere para uma string secreta forte
    ```

5.  **Iniciar a Aplicação:**

    ```bash
    node app.js
    ```
    Você deverá ver a mensagem: `NaVaga backend running on port 3000` e `Conexão com o banco de dados estabelecida com sucesso!`

## Como Fazer as Requisições (Endpoints da API)

A API está disponível em `http://localhost:3000`. Abaixo estão os principais endpoints:

### Autenticação

#### 1. Registrar Usuário

-   **URL:** `/usuarios/register`
-   **Método:** `POST`
-   **Corpo da Requisição (JSON):**
    ```json
    {
      "nome": "Seu Nome",
      "email": "seu.email@example.com",
      "senha": "sua_senha_segura"
    }
    ```
-   **Exemplo de Resposta (Sucesso - 201 Created):**
    ```json
    {
      "id": 1,
      "nome": "Seu Nome",
      "email": "seu.email@example.com"
    }
    ```

#### 2. Login de Usuário

-   **URL:** `/usuarios/login`
-   **Método:** `POST`
-   **Corpo da Requisição (JSON):**
    ```json
    {
      "email": "seu.email@example.com",
      "senha": "sua_senha_segura"
    }
    ```
-   **Exemplo de Resposta (Sucesso - 200 OK):**
    ```json
    {
      "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
    }
    ```

### Vagas

#### 1. Listar Vagas

-   **URL:** `/vagas`
-   **Método:** `GET`
-   **Parâmetros de Query (Opcional):** `?local=termo_de_busca` (para filtrar por localização)
-   **Exemplo de Resposta (Sucesso - 200 OK):**
    ```json
    [
      {
        "id": 1,
        "localizacao": "Shopping Beira-Mar - Piso 1",
        "status": "livre"
      },
      {
        "id": 2,
        "localizacao": "Shopping Beira-Mar - Piso 2",
        "status": "ocupada"
      }
    ]
    ```

### Sensores

#### 1. Evento de Sensor (Atualizar Status da Vaga)

-   **URL:** `/sensores/event`
-   **Método:** `POST`
-   **Corpo da Requisição (JSON):**
    ```json
    {
      "codigo_sensor": "SENSOR001",
      "status": "ocupada",
      "usuario_id": 1 // Opcional, se um usuário específico ocupar a vaga
    }
    ```
    Ou para liberar:
    ```json
    {
      "codigo_sensor": "SENSOR001",
      "status": "livre"
    }
    ```
-   **Exemplo de Resposta (Sucesso - 200 OK):**
    ```json
    {
      "ok": true,
      "vaga_id": 1,
      "status": "ocupada"
    }
    ```

### Histórico (Requer Autenticação)

Para acessar os endpoints de histórico, inclua o token JWT obtido no login no cabeçalho `Authorization` como `Bearer <TOKEN>`.

#### 1. Obter Histórico de um Usuário

-   **URL:** `/usuarios/:id/historico` (onde `:id` é o ID do usuário)
-   **Método:** `GET`
-   **Cabeçalhos:** `Authorization: Bearer <SEU_TOKEN_JWT>`
-   **Exemplo de Resposta (Sucesso - 200 OK):**
    ```json
    [
      {
        "id": 1,
        "vaga_id": 2,
        "localizacao": "Shopping Beira-Mar - Piso 2",
        "data_entrada": "2025-08-18T13:00:00.000Z",
        "data_saida": "2025-08-18T15:00:00.000Z"
      }
    ]
    ```

## Comentários no Código

Todos os arquivos `.js` principais (`app.js`, `db.js`, `controllers/*.js`, `middlewares/*.js`) foram comentados extensivamente para facilitar a compreensão do código, explicando o propósito de cada seção, função e lógica implementada.

## Autor

Heitor Schwinden Rachadel


