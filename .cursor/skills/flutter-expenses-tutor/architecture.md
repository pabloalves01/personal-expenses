# Arquitetura profissional (feature-first)

Não empilhe telas no `main.dart`. Pasta = uma área do app. Arquivo = uma responsabilidade.

## Camadas

```
lib/
  main.dart                 # só: runApp(const ExpensesApp());
  app.dart                  # MaterialApp + tema (StatelessWidget)

  features/                 # telas, agrupadas por assunto
    shell/app_shell.dart    # Scaffold + barra + índice
    home/home_screen.dart
    expenses/
      expenses_screen.dart
      expense_form_screen.dart   # quando existir formulário
    loans/loans_screen.dart
    settings/settings_screen.dart

  data/                     # só quando for persistir (depois)
    models/
    api/api_client.dart
    repositories/

  widgets/                  # só o que 2+ features usam (depois)
```

Isto é o padrão de app Flutter que cresce (várias pessoas, várias telas). Não é `screens/` com 20 arquivos soltos.

## Regras de dependência

```
main.dart  →  app.dart  →  AppShell  →  *Screen
                                      ↘
data/ (repository)  ←  screens chamam repository, nunca o Laravel/MySQL direto
```

- `main.dart` não tem `Scaffold`
- Telas **não** importam umas às outras (Despesas não importa Configurações)
- Só o `AppShell` importa as 4 telas
- SQL/Eloquent só no Laravel (outro repo)
- `features/expenses/` ganha formulário, tile, etc. **nessa pasta**, não em `lib/`

## Import (nome do pacote)

O `pubspec.yaml` chama o app de `my_app`. Todo import interno:

```dart
import 'package:my_app/features/home/home_screen.dart';
```

Não use `../home/home_screen.dart` (quebra fácil quando o arquivo muda de pasta).

## Abas

| Index | Feature | Arquivo |
|-------|---------|---------|
| 0 | Início | `features/home/home_screen.dart` |
| 1 | Despesas | `features/expenses/expenses_screen.dart` |
| 2 | Empréstimos | `features/loans/loans_screen.dart` |
| 3 | Configurações | `features/settings/settings_screen.dart` |

Barra só no `AppShell`. Adicionar item = FAB + `Navigator`, não quinta aba.

## Como ensinar a extração

Um arquivo novo por recado. Primeiro `HomeScreen` + `body` na aba 0. Depois as outras. Por último mover `AppShell` e `MyApp`.
