import 'package:flutter/material.dart';
import 'controllers/cancion_controlador.dart';
import 'views/inicio_vista.dart';

void main() {
  // Cargar las canciones antes de iniciar la app
  CancionControlador.cargarCanciones();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Canciones App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const InicioVista(),
    );
  }
}