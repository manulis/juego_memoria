import 'package:flutter/material.dart';
import 'package:juego_memoria/utils.dart';
import 'package:juego_memoria/widgets.dart';


//Pantalla Puntuaciones
class Puntuaciones extends StatefulWidget{
  @override
  State<Puntuaciones> createState() => _Puntuaciones();
}

class _Puntuaciones extends State<Puntuaciones> {

  Future<List<Map<String, dynamic>>> obtenerPuntuacion() async {
    return await PuntuacionHandler.obtenerPuntuacion();
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: FutureBuilder<List<Map<String, dynamic>>>(
      future: obtenerPuntuacion(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error al obtener datos'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No hay datos disponibles'));
        } else {
          snapshot.data!.sort((a, b) => b['puntuacion'].compareTo(a['puntuacion']));
          return CustomScrollView(
            slivers: <Widget>[
              const SliverAppBar(
                title: Titulos("Puntuaciones"),
                pinned: true,
                automaticallyImplyLeading: true,
                backgroundColor: Colors.amber,
                centerTitle: true,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final puntuacion = snapshot.data![index];
                    return InkWell(
                      onTap: () {
                        print('${puntuacion['nombre']}');
                      },
                      child: ListTile(
                        title: TextoListas('${puntuacion['nombre']}: ${puntuacion['puntuacion']} puntos'),
                      ),
                    );
                  },
                  childCount: snapshot.data!.length,
                ),
              ),
            ],
          );
        }
      },
    ),
  );
}
}
