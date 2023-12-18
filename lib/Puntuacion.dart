import 'package:flutter/material.dart';
import 'package:juego_memoria/utils.dart';
import 'package:juego_memoria/widgets.dart';

class Puntuaciones extends StatefulWidget{
  @override
  State<Puntuaciones> createState() => _Puntuaciones();
}




class _Puntuaciones extends State<Puntuaciones>{
 

  Widget build(BuildContext context){
    return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
              SliverAppBar(
                title: Titulos("Puntuaciones"),
                pinned: true,
                automaticallyImplyLeading: true, 
                centerTitle: true,
              ),

          
          ]
        ),
    );
  }
}

ListView milista() {
  return ListView(
    children: <Widget>[
      
      ListTile(
     
        title: Text('Primero'),
       
        subtitle: Text('Este es el primer Tile'),
        
        leading: Icon(Icons.add),
       
        onTap: () {},
      ),
      ListTile(
        title: Text('Primero'),
        onTap: () {},
      )
    ],
  );
}