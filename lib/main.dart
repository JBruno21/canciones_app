import 'package:flutter/material.dart';
import 'controllers/cancion_controlador.dart';
import 'views/inicio_vista.dart';

void main() async {
  // Necesario para usar async en main
  WidgetsFlutterBinding.ensureInitialized();
  
  // Cargar canciones del JSON
  await CancionControlador.cargarCanciones();
  
  runApp(const MiApp());
}


class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mis Canciones',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const InicioVista(),
    );
  }
}