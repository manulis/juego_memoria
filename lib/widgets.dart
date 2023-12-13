import 'package:flutter/material.dart';


//Formato de los Titulos
class Titulos extends StatefulWidget {
  final String texto;
  const Titulos(this.texto);
  @override
  _TitulosState createState() => _TitulosState();
}

class _TitulosState extends State<Titulos> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.texto,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 30,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}

//Boton 1
Widget buildButton(String text, VoidCallback onPressed) {
  return TextButton(
    onPressed: onPressed,
    
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(20.0),
      minimumSize: const Size(200.0, 60.0),
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    child: Text(text),
  );
}

//Boton 2
Widget buildButton2(String text, VoidCallback onPressed){
  return TextButton(
    onPressed: onPressed, 
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(20.0),
      minimumSize: const Size(400.0, 400.0),
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    child: Text(text)
  );

}

//Spinner
class LoadingSpinner extends StatefulWidget {
  @override
  _LoadingSpinnerState createState() => _LoadingSpinnerState();
}

class _LoadingSpinnerState extends State<LoadingSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), 
    )..repeat(); 
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Container(
        width: 100,
        height: 100,
        child: const Icon(
          Icons.autorenew_rounded, 
          size: 50,
          color: Colors.blue, 
        ),
      ),
    );
  }
}


