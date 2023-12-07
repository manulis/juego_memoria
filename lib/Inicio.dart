import 'package:flutter/material.dart';
import 'package:juego_memoria/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:juego_memoria/widgets.dart';


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
      backgroundColor: Colors.white,
      body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
            child: Container(
              child: Column(children: [

                Image.asset(
                  'assets/saludo-vulcano.gif', // Ruta de la imagen en los recursos
                  fit: BoxFit.cover, // Ajuste de la imagen
                  width: 200, // Ancho de la imagen
                  height: 200, // Alto de la imagen
                ),

                const SizedBox(height: 50),

                Titulos('Bienvenido ' + nombre),

                const SizedBox(height: 20),

                 TextButton(onPressed:(){

                  }, 
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(20.0), // Ajusta el relleno del botón
                      minimumSize: Size(200.0, 60.0),
                      backgroundColor: Colors.black,
                       foregroundColor: Colors.white,
                       // Tamaño mínimo del botón
                    ),
                      child: const Text('Jugar')
                  ),

                  const SizedBox(height: 40),

                  TextButton(onPressed:(){
                  }, 
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(20.0), // Ajusta el relleno del botón
                      minimumSize: Size(200.0, 60.0),
                      backgroundColor: Colors.black,
                       foregroundColor: Colors.white,
                       // Tamaño mínimo del botón
                    ),
                      child: const Text('Puntuación')
                  )
              ],
              ),
            ),
            ),
      ),
    );
  }
}