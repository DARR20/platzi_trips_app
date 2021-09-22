import 'package:flutter/material.dart';
import 'package:platzi_trips_app/src/pages/contador_page.dart';
//import 'package:practica_holamundo/src/pages/home_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Center(
          //child: HomePage(),
          child: ContadorPage(),
        ));
  }
}
