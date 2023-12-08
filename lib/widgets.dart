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

//Botones 1
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