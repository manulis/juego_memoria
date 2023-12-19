import 'package:juego_memoria/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:juego_memoria/main.dart';


// Manejo del nombre del jugador
class NombreHandler {
  // Guardar el nombre del jugador en SharedPreferences
  static Future<void> guardarNombre(String nombre) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nombre_guardado', nombre);
    print('Nombre guardado');
  }
   // Obtener el nombre guardado desde SharedPreferences
  static Future<String> obtenerNombreGuardado() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('nombre_guardado') ?? '';
  }
}

// Listas para almacenar imágenes
List images = [];
List imagesCorrectas = [];

Future<void> obtenerImagenes() async {

  //Obtención y guardado de las imagenes de la API
  for (var i = 0; i < 10; i++) {
    while (true) {
      final response = await http.get(Uri.parse("https://random.imagecdn.app/v1/image?width=500&height=500&category=buildings&format=json")); 
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(jsonData);
        images.add(jsonData['url']);
        print(images[i]);
        break;
      } else {
        print('Fallo la solicitud con código de estado: ${response.statusCode}');
        print('Reintentando');
      }
    } 
  }


  // Seleccion aleatoria de imágenes correctas
  List<int> indexes = [];
  Random random = Random();


  while(imagesCorrectas.length<5) {
    int randomIndex = random.nextInt(images.length);
    if (!indexes.contains(randomIndex)) {
      indexes.add(randomIndex);
      imagesCorrectas.add(images[randomIndex]);
    }
  }
}

// Función para verificar si una imagen es correcta
comprobarImagen(image){
  for(var imageCorrecta in imagesCorrectas){
    if(image == imageCorrecta){
      return true;
    }
  }
  return false;
}

// Manejo de puntuaciones en la base de datos Supabase
class PuntuacionHandler {

  // Enviar o actualizar la puntuación del jugador
  static Future<bool> enviarPuntuacion(nombre, puntuacion) async{
    final data = await supabase.from('Puntuaciones').select('*').eq('nombre', nombre);
    if(data.isEmpty){
      try{
        await supabase.from('Puntuaciones').insert({'nombre': nombre, 'puntuacion': puntuacion});     
      }on Exception catch(e){
        print("Error: ${e}");
        return false;
      }
    }else{
      try{
        await supabase.from('Puntuaciones').update({ 'puntuacion': puntuacion }).match({ 'nombre': nombre });
      }on Exception catch (e){
        print("Error: ${e}");
        return false;
      }
    }
    return true;
  }
  //Obtener todas las puntuaciones de la base de datos
  static Future<List<Map<String, dynamic>>> obtenerPuntuacion() async {
    try{
     final data =  await supabase.from("Puntuaciones").select('*');
     return data;
    }on Exception catch (e){
      print("Error: ${e}");
      return [];
    }
  }
}
