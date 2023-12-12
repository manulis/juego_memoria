import 'package:flutter/material.dart';
import 'package:juego_memoria/Inicio.dart';
import 'package:juego_memoria/utils.dart';
import 'package:juego_memoria/Formulario.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Formulario(),
    );
  }
}
