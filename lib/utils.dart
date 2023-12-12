import 'package:juego_memoria/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';


//Gruardar y extraer el nomnre de la memoria del disposiyivo
class NombreHandler {
  static Future<void> guardarNombre(String nombre) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nombre_guardado', nombre);
    print('Nombre guardado');
  }

  static Future<String> obtenerNombreGuardado() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('nombre_guardado') ?? '';
  }
}


List images = [];
List imagesCorrectas = [];

//Obtener imagenes de la Api

Future<void> obtenerImagenes() async {
  for (var i = 0; i < 10; i++) {
    while (true) {
      final response = await http.get(Uri.parse("https://dog.ceo/api/breeds/image/random")); 
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(jsonData);
        images.add(jsonData['message']);
        print(images[i]);
        break;
      } else {
        print('Fallo la solicitud con código de estado: ${response.statusCode}');
        print('Reintentando');
        break;
      }
    } 
  }

  for (var i = 0; i < 5; i++) {
    imagesCorrectas.add(images[i]);
  }

}










