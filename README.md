[README.md](https://github.com/user-attachments/files/22408078/README.md)
# NaVaga Backend

Node.js + Express backend for the NaVaga parking system.

## Features implemented
- POST /usuarios -> register user
- POST /login -> authenticate and return JWT
- Auth middleware (JWT)
- GET /vagas -> list vagas (optional ?local= filter)
- POST /sensores/vagas -> integrate sensor event to update vaga status
- GET /usuarios/:id/historico -> parking history for a user

## Setup
1. Install dependencies: `npm install`
2. Create a Postgres database and run the SQL in `NaVaga.sql` to create tables and sample data.
3. Copy `.env.example` to `.env` and set values.
4. Start: `npm start`

## Env variables (.env)
- DATABASE_URL (eg: postgres://user:password@localhost:5432/navaga_db)
- JWT_SECRET
- PORT (optional, default 3000)

