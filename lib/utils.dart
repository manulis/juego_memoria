import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


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


class ObtenerImagenes{
final String ApiEndpoint = "https://api.thecatapi.com/v1/images/search?size=med&mime_types=jpg&format=json&has_breeds=true&order=RANDOM&page=0&limit=1";

List images = [];
List imagesCorrectas = [];




}
