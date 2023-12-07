import 'package:shared_preferences/shared_preferences.dart';

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
