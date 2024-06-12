import 'package:flutter/material.dart';
import 'blocks/block.dart';
import 'blocks/Iblock.dart';
import 'blocks/Jblock.dart';
import 'blocks/Lblock.dart';
import 'blocks/SBlock.dart';
import 'blocks/sqBlock.dart';
import 'blocks/Tblock.dart';
import 'blocks/Zblock.dart';
import 'dart:math';
import 'settings.dart';

// Función para obtener un bloque aleatorio
Block getRandomBlock() {
  // Genera un número aleatorio entre 0 y 6
  int randomNr = Random().nextInt(7);
  var settings = Settings();

  // Retorna un tipo de bloque basado en el número aleatorio generado
  switch (randomNr) {
    case 0:
      return IBlock(settings.boardWidth);
    case 1:
      return JBlock(settings.boardWidth);
    case 2:
      return LBlock(settings.boardWidth);
    case 3:
      return SBlock(settings.boardWidth);
    case 4:
      return SquareBlock(settings.boardWidth);
    case 5:
      return TBlock(settings.boardWidth);
    case 6:
      return ZBlock(settings.boardWidth);
    default:
      throw Exception("Invalid block type"); // Manejo de errores para casos no esperados
  }
}

// Función para obtener un punto de Tetris con un color específico
Widget getTetrisPoint(Color color) {
  var settings = Settings();

  return Container(
    // Define el tamaño del punto
    width: settings.pointSize,
    height: settings.pointSize,
    decoration: BoxDecoration(
      color: color, // Establece el color del punto
      shape: BoxShape.rectangle, // Define la forma del punto como un rectángulo
      borderRadius: BorderRadius.circular(2), // Añade bordes ligeramente redondeados
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3), // Añade una sombra para dar efecto 3D
          blurRadius: 4.0,
          offset: Offset(2.0, 2.0),
        ),
      ],
    ),
  );
}

// Función para mostrar el texto de "Game Over" con la puntuación final
Widget getGameOverText(int score) {
  return Center(
    child: Text(
      'Game Over\nEnd Score: $score',
      textAlign: TextAlign.center, // Alinea el texto al centro
      style: TextStyle(
        fontSize: 35.0,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
        shadows: [
          Shadow(
            color: Colors.black,
            blurRadius: 3.0,
            offset: Offset(2.0, 2.0), // Añade una sombra para dar efecto 3D
          ),
        ],
      ),
    ),
  );
}
