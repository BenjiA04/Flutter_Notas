import 'package:flutter/material.dart';
import 'package:flutter_application_notas/View/NotasView.dart';
import 'package:flutter_application_notas/View/PerfilView.dart';
import 'package:flutter_application_notas/View/inicioView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const Pantalla1(),
    );
  }
}

class Pantalla1 extends StatefulWidget {
  const Pantalla1({super.key});

  @override
  State<Pantalla1> createState() => _Pantalla1State();
}

class _Pantalla1State extends State<Pantalla1> {
  int _selectedIndex = 0;
  List<Map<String, String>> notas = [];

  void agregarNota(String titulo, String contenido) {
    setState(() {
      notas.add({'titulo': titulo, 'contenido': contenido});
    });
  }

  void eliminarNota(int index) {
    setState(() {
      notas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screen = MediaQuery.of(context).size.width;

    final List<Widget> pages = [
      PaginaInicio(notas: notas, eliminarNota: eliminarNota),
      PaginaNotas(agregarNota: agregarNota),
      TotalNotasScreen(totalNotas: notas.length),
    ];

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: screen >= 800,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: const [
              NavigationRailDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: Text(
                    "Inicio",
                    style: TextStyle(fontSize: 15),
                  )),
              NavigationRailDestination(
                  icon: Icon(Icons.note_add_outlined),
                  selectedIcon: Icon(Icons.note_add),
                  label: Text(
                    "Agregar Nota",
                    style: TextStyle(fontSize: 15),
                  )),
              NavigationRailDestination(
                  icon: Icon(Icons.person_2_outlined),
                  selectedIcon: Icon(Icons.person_2),
                  label: Text(
                    "Agregar Nota",
                    style: TextStyle(fontSize: 15),
                  )),
            ],
          ),
          const VerticalDivider(width: 1, thickness: 1, color: Colors.grey),
          Expanded(child: pages[_selectedIndex])
        ],
      ),
    );
  }
}
