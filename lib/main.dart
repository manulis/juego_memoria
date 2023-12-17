import 'package:flutter/material.dart';
import 'package:juego_memoria/Inicio.dart';
import 'package:juego_memoria/Juego.dart';
import 'package:juego_memoria/utils.dart';
import 'package:juego_memoria/Formulario.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
Future<void> main() async {
  await Supabase.initialize(
    url: 'https://ujrbnbiulrrmzmwulolo.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVqcmJuYml1bHJybXptd3Vsb2xvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI0NjcyNzcsImV4cCI6MjAxODA0MzI3N30.rjrWvWqqWN84weP-yx-KMUjbkOQGUMDPneyELpAh8CE',
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