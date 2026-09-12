# Conceitos Flutter (na hora certa)

Ensine só o que o marco atual precisa. Analogias curtas; sem aula genérica.

## Widget

Tudo na tela é um Widget. Widget descreve **o que** mostrar; o Flutter desenha.

`build()` **devolve** a árvore. O Flutter chama de novo quando o estado muda.

## Stateless vs Stateful

São **dois arquivos mentais**, não duas telas.

- `AppShell` (`StatefulWidget`): capa. Só `createState()`. Sem `Scaffold`.
- `_AppShellState`: caderno. Aqui ficam `_currentIndex` e o `build` (o layout).

`StatelessWidget` (`MyApp`): nada muda (tema, `MaterialApp`).  
`StatefulWidget`: algo muda na tela (aba selecionada).

Exemplo mínimo de estado (não é a barra, só a ideia):

```dart
class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Text('Aba número $_currentIndex');
  }
}
```

## Scaffold

Uma “folha de papel” com buracos nomeados. Você preenche os que quiser:

```dart
Scaffold(
  appBar: AppBar(title: const Text('Título')),
  body: const Center(child: Text('Miolo')),
  bottomNavigationBar: /* a barra entra AQUI, não no body */,
)
```

- `body` = conteúdo do meio  
- `bottomNavigationBar` = faixa **fixa embaixo** (não é um `Row` de `Text` no `body`)

## setState

```dart
setState(() {
  _currentIndex = index;
});
```

Sem isso, o número muda na memória e o Flutter não redesenha.

## Navegação de abas vs Navigator

- Abas: um índice, troca o `body`. Não empilha.
- `Navigator.push`: empilha formulário/detalhe. `pop` volta.

Abas: Início / Despesas / Empréstimos / Configurações. `Navigator` para adicionar/editar e para login.

## async / Future / HTTP

Falar com a API demora. A função devolve `Future` e você `await`. A UI mostra "carregando".

`initState` não pode ser `async`. Padrão: chamar `_load()` sem await; `_load` é `async`.

## mounted

Depois de um `await`, o usuário pode ter saído da tela. Só `setState` se `mounted`.

## Classe e modelo

Modelo = regra de negócio, sem Flutter. `Expense` não importa `material.dart`.

`id` é `int?` porque o MySQL gera o id no `INSERT`.

## JSON (não Map do sqflite)

A API fala JSON (`{"title":"Almoço","amount":32.5}`). O repository traduz JSON ↔ `Expense`. A tela só conhece `Expense`.

## Controller e dispose

`TextEditingController` segura o texto. No `State`, `dispose()` no controller.

## API vs MySQL

O app chama o Laravel (`http://127.0.0.1:8000/api/expenses` no estudo). O **Laravel** abre o MySQL. O celular nunca vê a senha do banco.

No emulador Android, `localhost` do PC é `10.0.2.2`. No simulador iOS, `localhost` funciona. No celular físico, use o IP da LAN.

## Provider (só depois do login)

Quando Início, Despesas e Empréstimos precisam do mesmo usuário/token, um `ChangeNotifier` ajuda. Não comece por aqui.
