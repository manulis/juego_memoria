import 'package:flutter/material.dart';
import 'package:juego_memoria/Juego.dart';
import 'package:juego_memoria/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:juego_memoria/widgets.dart';


//PantallainicioJuego

class Inicio extends StatefulWidget{
 @override
  State<Inicio> createState() => _Inicio();
}

class _Inicio extends State<Inicio>{

  String nombre = '';

  @override
  void initState() {
    super.initState();
    _obtenerNombreGuardado();
  }

  Future<void> _obtenerNombreGuardado() async {
    final nombreGuardado = await NombreHandler.obtenerNombreGuardado();
    setState(() {
      nombre = nombreGuardado;
    });
  }

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
            child: Column(children: [
              Image.asset(
                'assets/saludo-vulcano.gif', 
                fit: BoxFit.cover, 
                width: 200, 
                height: 200, 
              ),
              const SizedBox(height: 50),
              Titulos('Bienvenido ' + nombre),
              const SizedBox(height: 20),
            
              buildButton('Jugar', () { 
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Juego()),
                );
              }),
              const SizedBox(height: 40),
              buildButton('Puntuación', () {
                
            
            
              })
            ],
            ),
            ),
      ),
    );
  }
}