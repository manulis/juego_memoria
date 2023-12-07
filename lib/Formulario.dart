import 'package:flutter/material.dart';
import 'package:juego_memoria/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:juego_memoria/widgets.dart';
import 'package:juego_memoria/Inicio.dart';

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
      backgroundColor:  Colors.white,
      body: Center(
        child: Padding(  
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
            child: Container(
              child: Column(children: [

                Image.asset(
                  'assets/carne-de-identidad.png', // Ruta de la imagen en los recursos
                  fit: BoxFit.cover, // Ajuste de la imagen
                  width: 200, // Ancho de la imagen
                  height: 200, // Alto de la imagen
                ),

                const SizedBox(height: 20),
                const Titulos("Meta un nombre"),
                const SizedBox(height: 20),
                TextField(
                   style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                    labelText: 'Nombre', labelStyle: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
                     contentPadding: EdgeInsets.only(bottom: 10),
                  ),
                  onChanged: (text){
                    setState(() {
                      nombreUsu = text;
                    });
                  },
                ),
                const SizedBox(height: 30),
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
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    
                    backgroundColor: 
                      MaterialStateProperty.all<Color>(Colors.black), // Cambia el color de fondo aquí
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