import 'package:flutter/material.dart';
import 'package:juego_memoria/Inicio.dart';
import 'package:juego_memoria/Juego.dart';
import 'package:juego_memoria/utils.dart';
import 'package:juego_memoria/Formulario.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://ujrbnbiulrrmzmwulolo.supabase.co',
    anonKey: '',
  );
  runApp(MainApp());
}

final supabase = Supabase.instance.client;

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Formulario(),
    );
  }
}