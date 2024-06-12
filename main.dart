import 'package:flutter/material.dart';
import 'settings.dart';
import 'menu.dart';
import 'game.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Configuración inicial de la aplicación con el tema y la ruta de inicio
    return MaterialApp(
      title: "Tetris",
      theme: ThemeData(
        // Define un tema global con colores azules que armonizan con el tema de Tetris
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Página principal que actúa como menú principal
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 75, 70, 232), // Color de fondo vibrante para el menú principal
      body: Menu(), // Incluye el menú como cuerpo principal de esta vista
    );
  }
}

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var settings = Settings(); // Instancia de configuraciones para manejar el juego
    
    // Pantalla del juego donde el usuario interactúa con el juego en sí
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () async {
            settings.timer.cancel(); // Cancela cualquier temporizador en ejecución al salir
            Navigator.pop(context); // Retorna al menú principal
          },
        ),
        title: Text('Juega y diviértete'),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 180, 205, 238), // Un fondo más claro para la pantalla del juego
      body: Game(), // El widget del juego se carga aquí
    );
  }
}
