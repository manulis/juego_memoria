import 'package:flutter/material.dart';
import 'package:juego_memoria/widgetsPrincipales.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {



  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Formulario',
      home: 

      
      
      Formulario(title: 'Formulario'),

    );
  }
}
