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
  void initState() {
    super.initState();
    _obtenerNombreGuardado();
  }

 Future<void> _obtenerNombreGuardado() async {
    final nombreGuardado = await NombreHandler.obtenerNombreGuardado();
    if (nombreGuardado.isNotEmpty){
      print("No Vacio");

      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  Inicio()),
      );
    }else{
      print("Vacio");
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor:  Colors.white,
      body: Center(
        child: Padding(  
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
            child: Column(children: [
              Image.asset(
                'assets/carne-de-identidad.png', 
                fit: BoxFit.cover, 
                width: 100, 
                height: 100, 
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
                buildButton("Aceptar", () { 
                  print(nombreUsu);
                  NombreHandler.guardarNombre(nombreUsu); 
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Inicio()),
                  );
                })  
            ])
          )
      ),
    );
  }
}


