import 'package:flutter/material.dart';
import 'package:juego_memoria/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:juego_memoria/widgetsgenericos.dart';

//Formulario
String nombreUsu = "";

Future<void> _guardarNombre(String nombre) async{
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('nombre_guardado', nombre);
  print('Texto guardado en SharedPreferences.');
}

class Formulario extends StatefulWidget{
  const Formulario({super.key, required this.title});
  final String title;
  @override
  State<Formulario> createState() => _Formulario();
}

class _Formulario extends State<Formulario>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor:  Colors.black,
      body: Center(
        child: Padding(  
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 150),
            child: Container(
              child: Column(children: [
                const Titulos("Meta un nombre"),
                const SizedBox(height: 20),
                TextField(
                   style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                    labelText: 'Nombre', labelStyle: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
                     contentPadding: EdgeInsets.only(bottom: 10),
                  ),
                  onChanged: (text){
                    setState(() {
                      nombreUsu = text;
                    });
                  },
                ),
                const SizedBox(height: 20),
                if (nombreUsu.isNotEmpty)
                  TextButton(onPressed:(){ 
                    print(nombreUsu);
                    NombreHandler.guardarNombre(nombreUsu); 
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Inicio(title: 'Inicio',)),
                    );
                  } ,   
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    backgroundColor: 
                      MaterialStateProperty.all<Color>(Colors.white), // Cambia el color de fondo aquí
                      ), 
                      child: const Text('Aceptar')
                  ),
              ]),
            )
          )
      ),
    );
  }
}


//PantallainicioJuego

class Inicio extends StatefulWidget{
 const Inicio({super.key, required this.title});
 final String title;
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
      backgroundColor: Colors.black,
      body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 150),
            child: Container(
              child: Column(children: [
                Titulos('Bienvenido ' + nombre),
              ],
              ),
            ),
            ),
      ),
    );
  }
}