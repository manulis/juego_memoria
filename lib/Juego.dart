import 'dart:async';
import 'package:flutter/material.dart';
import 'package:juego_memoria/Inicio.dart';
import 'package:juego_memoria/usuario.dart';
import 'package:juego_memoria/utils.dart';
import 'package:juego_memoria/widgets.dart';

class Juego extends StatefulWidget {
  @override
  State<Juego> createState() => _JuegoState();
}

class _JuegoState extends State<Juego> {
  late final Timer _timer;
  int _index = 0;
  bool _EmpezarButtonEnabled = true;
  bool _buttonVisible = true;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      if (!_buttonVisible) {
        setState(() => _index++);
        if (_index == imagesCorrectas.length) {
          setState(() {
            _buttonVisible = true;
            _EmpezarButtonEnabled = false;
          });
          _timer.cancel();
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _handleStartButton() async {
    print("Empezar");
    setState(() => _loading = true);

    await obtenerImagenes(); // Lógica para obtener las imágenes

    setState(() {
      _loading = false;
      _buttonVisible = false;
    });
  }

  Widget _buildButton() {
    return _EmpezarButtonEnabled
        ? buildButton2('Empezar', () => _handleStartButton())
        : buildButton2('Resolver', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Resolucion()),
            );
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 200),
          child: Column(
            children: [
              if (_loading)
                Container(child: CircularProgressIndicator())
              else
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 800),
                  child: _buttonVisible
                      ? _buildButton()
                      : Image.network(
                          obtenerImagenActual(),
                          fit: BoxFit.cover,
                          width: 300,
                          height: 300,
                          key: UniqueKey(),
                        ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String obtenerImagenActual() {
    return imagesCorrectas[_index % imagesCorrectas.length];
  }
}


class Resolucion extends StatefulWidget{
  State<Resolucion> createState() => _Resolucion();
}

int Puntuacion = 0;
int fallos = 0;
int aciertos = 0;
class _Resolucion extends State<Resolucion>{

  deleteimage(int i){
    return images[i] = '';
  }
  Widget build(BuildContext context){
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Titulos("Puntuacion: ${Puntuacion}"),
            pinned: true,
            automaticallyImplyLeading: false, 
            centerTitle: true,
             
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20), // Ajusta el padding según sea necesario
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Center(
                    child: Column(
                      children: [
                        if(fallos==3 || aciertos==5)
                          Column(
                            children: [
                              if(fallos==0 && aciertos==5)
                                Column(
                                  children: [ 
                                    Image.asset('assets/premio.gif',fit: BoxFit.cover,width: 100,height: 100), 
                                    Text("Genial!!! acertastes todas y tuviste ${fallos} fallos "),
                                  ],
                                ),

                                if(fallos==3 && aciertos == 0)
                                   Column(
                                      children: [
                                        Image.asset('assets/perder.gif',fit: BoxFit.cover,width: 100,height: 100),
                                        Text("No has acertado ni una"),
                                    ],
                                  ),

                                if(fallos==3 && aciertos!=5 || fallos!=3 && aciertos==5 || fallos!=3 && aciertos!=5)
                                  Text("Has tenido ${fallos} fallos y ${aciertos} aciertos"),

                              const SizedBox(height: 50),
                              buildButton("Enviar Puntuación", () async { 
                                String nombre = await NombreHandler.obtenerNombreGuardado();
                                Usuario usuario = Usuario(nombre, Puntuacion);
                                print("${fallos} y ${aciertos}");
                                print("${usuario.nombre} tiene de puntuación: ${usuario.puntuacion} ");
                                await PuntuacioHandler.enviarPuntuacion(usuario.nombre, usuario.puntuacion);
                              }),
                              const SizedBox(height: 30),
                              buildButton("Salir", () { 
                                Puntuacion = 0;
                                aciertos = 0;
                                fallos = 0;
                                images = [];
                                imagesCorrectas = [];
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Inicio()),
                                );
                              })
                            ],
                          )
                        else
                          Container(
                            height: 400,
                            child: GridView(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 3),
                              scrollDirection: Axis.vertical,
                              children: [
                                for(var i=0; i<images.length; i++)
                                  InkWell(
                                    onTap: () {
                                      print(images[i]);
                                      if(images[i] != ''){
                                        if(comprobarImagen(images[i])){
                                          setState(() {
                                            aciertos++;
                                            Puntuacion+=3;
                                          });
                                        } else {
                                          setState(() {
                                            fallos++;
                                            Puntuacion-=3;
                                          });
                                        }
                                      }
                                      deleteimage(i);
                                    },
                                    splashColor: Colors.white10,
                                    child: Ink.image(
                                      fit: BoxFit.cover,
                                      width: 200,
                                      height: 200,
                                      image: NetworkImage(images[i])
                                    ),
                                  )
                                  
                              ],
                            ),
                          )  
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}