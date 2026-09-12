import 'package:flutter/material.dart';
import 'package:my_app/screens/despesas/despesas_screen.dart';
import 'package:my_app/screens/emprestimos/emprestimos_screen.dart';
import 'package:my_app/screens/configuracoes/configuracoes_scree.dart';
import 'screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurpleAccent),
      ),
      home: AppShell(),
    );
  }
}

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
