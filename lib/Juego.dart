import 'package:flutter/material.dart';
import 'package:juego_memoria/utils.dart';
import 'package:juego_memoria/widgets.dart';


class Juego extends StatefulWidget{
  @override
  State<Juego> createState() => _Juego();
}

class _Juego extends State<Juego>{
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Padding(padding: 
        const EdgeInsets.symmetric(horizontal: 50, vertical: 300),
        child: Column(
          children: [
            buildButton("Empezar", () { 

              


            })
          ],
        ),
        )
        )
      );
  }
}