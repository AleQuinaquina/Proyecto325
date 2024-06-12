import 'block.dart';
import 'point.dart';
import 'package:flutter/material.dart';

// Define un bloque específico para el Tetris (bloque I)
class IBlock extends Block {
  // Constructor de la clase que define la forma y posición inicial del bloque
  IBlock(int width) {
    // Define los puntos del bloque en función del ancho del tablero
    points[0] = Point((width / 2 - 2).floor(), -1);
    points[1] = Point((width / 2 - 1).floor(), -1);
    points[2] = Point((width / 2).floor(), -1);
    points[3] = Point((width / 2 + 1).floor(), -1);
    // Establece el centro de rotación del bloque
    rotationCenter = points[1];
    // Define el color del bloque
    color = Colors.cyanAccent;
  }
}
