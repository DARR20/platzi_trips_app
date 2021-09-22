import 'package:flutter/material.dart';

class ContadorPage extends StatefulWidget {
  @override
  createState() => _ContadorPageState();
}

class _ContadorPageState extends State<ContadorPage> {
  final _estiloTexto = new TextStyle(fontSize: 25.0);

  int _conteo = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Titulo'),
          centerTitle: true,
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Numero de clicks:',
              style: _estiloTexto,
            ),
            Text('$_conteo', style: _estiloTexto),
          ],
        )),
        floatingActionButton: _crearBotones());
  }

  Widget _crearBotones() {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      SizedBox(width: 30.0),
      FloatingActionButton(
          onPressed: () => _borrar(), child: Icon(Icons.exposure_zero)),
      Expanded(child: SizedBox(width: 5.0)),
      FloatingActionButton(
          onPressed: () => _disminuir(), child: Icon(Icons.remove)),
      SizedBox(width: 5.0),
      FloatingActionButton(onPressed: () => _agregar(), child: Icon(Icons.add)),
    ]);
  }

  void _agregar() {
    setState(() {
      _conteo++;
    });
  }

  void _disminuir() {
    setState(() {
      _conteo--;
    });
  }

  void _borrar() {
    setState(() {
      _conteo = 0;
    });
  }
}
