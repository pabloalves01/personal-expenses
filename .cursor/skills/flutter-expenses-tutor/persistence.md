# Persistência: MySQL + várias pessoas

## Por que o Flutter não fala com o MySQL

Colocar `mysql_client` no app e a senha no código **quebra** o requisito de várias pessoas:

- Qualquer um extrai a senha do APK e lê/apaga o banco
- MySQL não foi feito para mil celulares abrindo porta 3306
- Wi-Fi, 4G e firewall bloqueiam essa porta
- Quem pode ver o quê (só as minhas despesas) tem que ser regra no **servidor**

Certo:

```
App Flutter  --HTTP JSON-->  API (sua máquina agora, um VPS depois)  -->  MySQL
```

O MySQL que ele já instalou fica **atrás da API**, em `localhost`. Só a API conhece usuário e senha.

## O que deixar pronto no MySQL (quando for o marco)

No cliente MySQL (Workbench, `mysql` no terminal, DBeaver):

```sql
CREATE DATABASE personal_expenses
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

CREATE USER 'expenses_app'@'localhost' IDENTIFIED BY 'troque-esta-senha';
GRANT ALL ON personal_expenses.* TO 'expenses_app'@'localhost';
FLUSH PRIVILEGES;
```

Não use `root` no código da API. Não commite a senha: use variável de ambiente (`MYSQL_PASSWORD`).

Tabelas entram **depois**, uma de cada vez. Esboço (não criar tudo agora):

```sql
-- várias pessoas
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  email VARCHAR(190) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- cada linha pertence a um usuário
CREATE TABLE expenses (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  title VARCHAR(200) NOT NULL,
  amount DECIMAL(12, 2) NOT NULL,
  date DATE NOT NULL,
  category VARCHAR(80) NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);
```

`DECIMAL(12,2)` para dinheiro, não `FLOAT`. `user_id` é o que separa “os dados da Ana” dos “dados do Bruno”.

Empréstimos ganham tabela própria no marco correspondente (`lent` / `borrowed`).

## API no projeto Laravel (outro repo)

Não crie API Dart aqui. Quando o app precisar de um dado:

- migration + model no Laravel
- rota REST (`GET /expenses`, `POST /expenses`)
- mais tarde: `POST /login` devolve token; as rotas exigem o token

O app usa o pacote `http` e um `ExpenseRepository`. Trocar URL (emulador vs celular) é configuração, não SQL.

## Estudo na sua máquina vs “várias pessoas de verdade”

| Situação | MySQL | API | App aponta para |
|----------|--------|-----|-----------------|
| Só você no emulador | localhost | `localhost:8080` | Android: `http://10.0.2.2:8080` |
| Amigo no mesmo Wi-Fi | localhost | escuta `0.0.0.0:8080` | `http://IP-DA-SUA-LAN:8080` |
| Cada um em casa | MySQL + API num servidor (VPS) | HTTPS | URL pública |

Instalar o MySQL no celular de cada um **não** compartilha dados. Compartilhar = um MySQL + uma API.

## O que não fazer

- Porta 3306 aberta na internet
- Senha no `lib/` ou no git
- Um banco sem `users` / `user_id` se o app é multi-pessoa
- SQLite “enquanto isso” e migrar depois — o modelo já nasce com `userId`
