import 'dart:async';

// Definición de enums para las acciones del juego
enum LastButtonPressed { LEFT, RIGHT, ROTATE_LEFT, ROTATE_RIGHT, NONE }
enum MoveDir { LEFT, RIGHT, DOWN }
enum GameSpeed { SPEED_1X, SPEED_2X, SPEED_3X }

class Settings {
  // Implementación del patrón Singleton para asegurar una única instancia
  static final Settings _instance = Settings._internal();

  // Variables que pueden cambiar durante el juego
  late int gameSpeed;
  late int boardWidth;
  late int boardHeight;
  late double pointSize;
  late double pixelWidth;
  late double pixelHeight; // Altura debe ser el doble de la anchura
  late Timer timer; // Se inicializa posteriormente en el código

  bool _hasBeenCalculated = false;

  // Constructor del Singleton
  factory Settings() {
    return _instance;
  }

  // Constructor interno del Singleton
  Settings._internal() {
    gameSpeed = 400; // Velocidad inicial del juego
    boardWidth = 10; // Ancho inicial del tablero
    boardHeight = 20; // Altura inicial del tablero
    pointSize = 20; // Tamaño inicial del punto
    pixelWidth = 200; // Anchura inicial del tablero en píxeles
    pixelHeight = 400; // Altura inicial del tablero en píxeles
  }

  // Configura el campo de juego basado en el tamaño de la pantalla
  void setupPlayingField(double screenWidth, double screenHeight) {
    if (_hasBeenCalculated == true) return;

    _hasBeenCalculated = true;
    double userInputSize = 250.0; // Tamaño reservado para la entrada del usuario
    double newHeight = screenHeight - userInputSize; // Nueva altura
    double newWidth = newHeight / 2.0; // Nueva anchura basada en la proporción

    pixelHeight = newHeight;
    pixelWidth = newWidth;
    pointSize = pixelWidth / boardWidth; // Calcula el tamaño del punto en base a la anchura del tablero
    print(
        'calculated -> new height: $pixelHeight and new width: $pixelWidth and point size: $pointSize');
  }

  // Cambia la velocidad del juego basado en la selección del usuario
  void changeGameSpeed(GameSpeed newSpeed) {
    if (newSpeed == GameSpeed.SPEED_1X) {
      gameSpeed = 400;
    } else if (newSpeed == GameSpeed.SPEED_2X) {
      gameSpeed = 300;
    } else if (newSpeed == GameSpeed.SPEED_3X) {
      gameSpeed = 200;
    }
  }
}
