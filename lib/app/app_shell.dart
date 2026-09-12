import 'package:flutter/material.dart';
import 'package:my_app/screens/home/home_screen.dart';
import 'package:my_app/screens/despesas/despesas_screen.dart';
import 'package:my_app/screens/emprestimos/emprestimos_screen.dart';
import 'package:my_app/screens/configuracoes/configuracoes_scree.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  // aqui fica tudo que é acumulavel
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    String titulo = 'Início';
    Widget tela = const HomeScreen();

    if (_currentIndex == 1) {
      titulo = 'Despesas';
      tela = const DespesasScreen();
    }
    if (_currentIndex == 2) {
      titulo = 'Emprestimos';
      tela = const EmprestimosScreen();
    }
    if (_currentIndex == 3) {
      titulo = 'Configurações';
      tela = const ConfiguracoesScreen();
    }

    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: tela,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.money), label: 'Despesas'),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Emprestimos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
      ),
    );
  }
}
