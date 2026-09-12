# Exemplos para mostrar ao usuário

Mostre o bloco inteiro. Explique depois. Ele copia/adapta; você não grava no `lib/` sem pedido.

## Onde estamos no casco

`MyApp` → `home: AppShell()` → `_AppShellState` desenha o `Scaffold`.

A barra **não** é um `Row` de textos no `body`. É `bottomNavigationBar: NavigationBar(...)`.

## `_AppShellState` com 4 abas

```dart
class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          switch (_currentIndex) {
            0 => 'Início',
            1 => 'Despesas',
            2 => 'Empréstimos',
            _ => 'Configurações',
          },
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_alt),
            label: 'Despesas',
          ),
          NavigationDestination(
            icon: Icon(Icons.handshake_outlined),
            label: 'Empréstimos',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: 'Configurações',
          ),
        ],
      ),
    );
  }
}
```

Se o `switch` no `Text` assustar, equivalente com `if`:

```dart
String title = 'Início';
if (_currentIndex == 1) title = 'Despesas';
if (_currentIndex == 2) title = 'Empréstimos';
if (_currentIndex == 3) title = 'Configurações';
// body: Center(child: Text(title))
```

## Peça por peça

| Código | Significado |
|--------|-------------|
| `_currentIndex` | Qual aba está ativa (0, 1, 2 ou 3) |
| `body` | Só o miolo; muda conforme o índice |
| `bottomNavigationBar` | Barra colada embaixo, sempre visível |
| `NavigationBar` | O widget da barra (Material 3) |
| `destinations` | Lista das 4 abas (ícone + texto) |
| `selectedIndex` | Qual ícone fica marcado |
| `onDestinationSelected` | Função que roda no toque; `index` é a aba tocada |
| `setState` | “Redesenha com o índice novo” |

`AppShell` (a classe de cima) **não** ganha esse `Scaffold`. Só o State.

## Extrair uma tela (não colar no `main.dart`)

Arquivo novo `lib/features/home/home_screen.dart`:

```dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Resumo das suas finanças'),
    );
  }
}
```

No `_AppShellState` do `main.dart` (ainda, até mover o shell):

```dart
import 'package:my_app/features/home/home_screen.dart';

// no build, no lugar de body: Center(child: Text('Conteúdo'))
body: _currentIndex == 0
    ? const HomeScreen()
    : const Center(child: Text('Conteúdo')),
```

Pacote = `my_app` (veja `name:` no `pubspec.yaml`).
