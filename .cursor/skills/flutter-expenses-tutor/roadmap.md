# Roteiro de estudo

Um marco por vez. O agente **mostra exemplo completo** do conceito; o usuário digita no arquivo. Só edita `lib/` se ele pedir.

## 1. Casco no `main.dart`

Counter fora. `AppShell` + 4 abas + `setState`. Pode ficar tudo num arquivo **só enquanto aprende a barra**.

## 2. Extrair para `features/` (não criar tela no `main`)

Alvo em [architecture.md](architecture.md). Um arquivo por recado. Primeiro `HomeScreen`. Depois as outras abas. Por último `app.dart` + mover `AppShell`. `main.dart` termina só com `runApp`.

## 3. (reservado — pastas concluídas no 2)

## 4. Modelo `Expense` em Dart

Sem API ainda: `id`, `userId`, `title`, `amount`, `date`, `category`.

Lista falsa só para a UI. Avise que some ao fechar o app.

Exercício: "Por que `id` é `int?` e `amount` não é?"

## 5. MySQL de verdade (fora do Flutter)

Criar o banco `personal_expenses` e a tabela `users` (e depois `expenses`). Senha **não** vai para o git.

Conceitos: banco compartilhado vs arquivo no celular; várias pessoas = um servidor.

Exercício: "Se o MySQL estiver só na sua máquina e o amigo abrir o app em outro Wi-Fi, ele vê os dados? O que faltaria?"

Ver [persistence.md](persistence.md).

## 6. Primeira rota no Laravel (outro projeto)

Só quando a lista de despesas precisar de dados reais. Juntos: migration + rota (`GET /expenses`). O Flutter ainda não entra nessa pasta.

Exercício: "Por que a senha do MySQL mora no `.env` do Laravel e não no `pubspec` do app?"

## 7. Repository no Flutter + lista

`ExpenseRepository` usa `http`. Tela: vazio, carregando, erro.

Conceitos: `initState` + `_load()` async, `mounted`, JSON.

Exercício: "Por que não fazemos `await` dentro de `initState`?"

## 8. Formulário de despesa

FAB na aba Despesas → formulário → `POST` na API → lista atualiza.

Conceitos: `TextEditingController`, `Form`, `Navigator`, `dispose`.

## 9. Login (várias pessoas)

Tela de entrar/cadastrar. API devolve um token. Repository manda o token no header. Cada um vê as próprias despesas.

Só então modelar `Loan` (emprestei / peguei emprestado).

## 10. Empréstimos + Início com totais

Mesmo padrão: model → rota na API → tela. Início soma o mês do usuário logado.

`Provider` só quando passar o usuário/token por 4 telas ficar chato.

## Como saber o marco atual

| O que existe | Marco |
|--------------|--------|
| Só `main.dart` do counter | 1 |
| Abas no `main.dart`, sem `features/` | 1 feito → extraia pastas |
| `features/` + `app.dart`, `main` só `runApp` | 2 feito |
| Classe `Expense`, lista fake | 4 |
| Banco/tabelas no MySQL | 5 |
| Rota Laravel respondendo HTTP | 6 |
| Lista lendo a API | 7 |
| Formulário salvando | 8 |
| Login / `user_id` | 9+ |
