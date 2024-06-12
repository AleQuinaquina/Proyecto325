import 'package:flutter/material.dart';
import 'main.dart';
import 'menuButton.dart';
import 'settings.dart';

// Definición del estado del widget Menu
class Menu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  var configuraciones = Settings();
  VelocidadJuego velocidadActual = VelocidadJuego.VELOCIDAD_1X;

  // Función para cambiar la velocidad del juego
  void cambiarVelocidadJuego() {
    setState(() {
      if (velocidadActual == VelocidadJuego.VELOCIDAD_1X) {
        velocidadActual = VelocidadJuego.VELOCIDAD_2X;
      } else if (velocidadActual == VelocidadJuego.VELOCIDAD_2X) {
        velocidadActual = VelocidadJuego.VELOCIDAD_3X;
      } else if (velocidadActual == VelocidadJuego.VELOCIDAD_3X) {
        velocidadActual = VelocidadJuego.VELOCIDAD_1X;
      }
    });
  }

  // Función para obtener la velocidad actual del juego en formato de cadena
  String obtenerVelocidadJuego() {
    switch (velocidadActual) {
      case VelocidadJuego.VELOCIDAD_1X:
        return '1';
      case VelocidadJuego.VELOCIDAD_2X:
        return '2';
      case VelocidadJuego.VELOCIDAD_3X:
        return '3';
      default:
        return ''; // Valor predeterminado
    }
  }

  // Función para navegar a la pantalla del juego
  void alClicEnJugar() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GameScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double anchoPantalla = MediaQuery.of(context).size.width;
    double altoPantalla = MediaQuery.of(context).size.height;
    configuraciones.setupPlayingField(anchoPantalla, altoPantalla);

    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Tetris',
            style: TextStyle(
              fontSize: 70.0,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 249, 194, 15),
              shadows: [
                Shadow(
                  color: Colors.black,
                  blurRadius: 8.0,
                  offset: Offset(2.0, 2.0),
                )
              ],
            ),
          ),
          MenuButton(alClicEnJugar),
          ButtonTheme(
            height: 40,
            minWidth: 160,
            child: ElevatedButton(
              onPressed: cambiarVelocidadJuego,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 135, 206, 250), // Cambié el color de fondo a azul claro
              ),
              child: Text('Velocidad del Juego: x' + obtenerVelocidadJuego()),
            ),
          ),
        ],
      ),
    );
  }
}

// Enumeración para definir las velocidades del juego
enum VelocidadJuego {
  VELOCIDAD_1X,
  VELOCIDAD_2X,
  VELOCIDAD_3X,
}
