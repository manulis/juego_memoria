import 'package:juego_memoria/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:juego_memoria/main.dart';


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

Future<void> obtenerImagenes() async {
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

comprobarImagen(image){
  for(var imageCorrecta in imagesCorrectas){
    if(image == imageCorrecta){
      return true;
    }
  }
  return false;
}

class PuntuacioHandler {

  static Future<void> enviarPuntuacion(nombre, puntuacion) async{
    final data = await supabase .from('Puntuaciones').select('*').eq('nombre', nombre);
    print(data.isEmpty);
    if(data.isEmpty){
      try{
        await supabase.from('Puntuaciones').insert({'nombre': nombre, 'puntuacion': puntuacion});     
      }on Exception catch(e){
        print("Error: ${e}");
      }
    }else{
      try{
        await supabase.from('Puntuaciones').update({ 'puntuacion': puntuacion }).match({ 'nombre': nombre });
      }on Exception catch (e){
        print("Error: ${e}");
      }catch (e){
        print("Algo desconocido ocurrio ${e}");
      }
    }
  }

  static Future<void> obtenerPuntuacion(nombre) async {


    


  }

}
