import 'dart:async';

import 'package:flutter/material.dart';
import 'package:juego_memoria/utils.dart';
import 'package:juego_memoria/widgets.dart';
import 'package:flutter/cupertino.dart';

class Juego extends StatefulWidget{
  @override
  State<Juego> createState() => _Juego();
}

bool botonEmpezar = true;
bool botonVisible = true;
bool mostrarCarga = false;
class _Juego extends State<Juego>{

  late final Timer timer;

  int _index = 0;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() => _index++);
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Padding(padding: 
        const EdgeInsets.symmetric(horizontal: 50, vertical: 350),
        child: Column(
          children: [
            if(botonVisible)
              mostrarCarga ?
              Container(child: Text("Cargando ..."),):
                botonEmpezar ? 
                  buildButton('Empezar', () async { 
                      print("Empezar");
                      setState(() {
                        mostrarCarga = true;
                      });
                      
                      await obtenerImagenes();
                      setState(() {
                        mostrarCarga = false;
                        botonVisible = false;
                      });
                      await Future.delayed(const Duration(seconds: 5));
                      setState(() {
                        botonEmpezar = false;
                        botonVisible = true;
                      });
                    }):buildButton('Resolver', () {  })
              else
                Container(
                  child: AnimatedSwitcher(duration: const Duration(microseconds: 500),
                    child: Image.network(imagesCorrectas[_index % imagesCorrectas.length], fit: BoxFit.cover, 
                    width: 200, 
                    height: 200, ),
                  ),
                )
          ],
        ),
        )
        )
      );
  }
}