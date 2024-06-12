import 'point.dart';
import 'package:flutter/material.dart';
import '../settings.dart' as settings; // Alias para evitar conflictos
import '../move_dir.dart'; // Importa el enum MoveDir

class Block {
  List<Point> points = List.generate(4, (_) => Point(0, 0)); // Inicializa con puntos predeterminados
  late Point rotationCenter; // Marcar como late para asegurar que se inicialice antes de su uso
  Color? color; 

  // Método para mover el bloque en una dirección especificada
  void move(MoveDir dir) {
    switch (dir) {
      case MoveDir.LEFT:
        if (canMoveToSide(-1)) {
          points.forEach((p) => p.x -= 1);
        }
        break;
      case MoveDir.RIGHT:
        if (canMoveToSide(1)) {
          points.forEach((p) => p.x += 1);
        }
        break;
      case MoveDir.DOWN:
        points.forEach((p) => p.y += 1);
        break;
    }
  }

  // Método para verificar si el bloque puede moverse hacia un lado específico
  bool canMoveToSide(int moveAmt) {
    var gameSettings = settings.Settings();
    bool retVal = true;

    points.forEach((point) {
      if (point.x + moveAmt < 0 || point.x + moveAmt >= gameSettings.boardWidth) {
        retVal = false;
      }
    });

    return retVal;
  }

  // Método para verificar si todos los puntos del bloque están dentro del tablero
  bool allPointsInside() {
    bool retVal = true;
    var gameSettings = settings.Settings();

    points.forEach((point) {
      if (point.x < 0 || point.x >= gameSettings.boardWidth) {
        retVal = false;
      }
    });

    return retVal;
  }

  // Método para rotar el bloque hacia la derecha
  void rotateRight() {
    points.forEach((point) {
      int x = point.x;
      point.x = rotationCenter.x - point.y + rotationCenter.y;
      point.y = rotationCenter.y + x - rotationCenter.x;
    });

    if (!allPointsInside()) {
      rotateLeft(); // Si algún punto queda fuera del tablero, se revierte la rotación
    }
  }

  // Método para rotar el bloque hacia la izquierda
  void rotateLeft() {
    points.forEach((point) {
      int x = point.x;
      point.x = rotationCenter.x + point.y - rotationCenter.y;
      point.y = rotationCenter.y - x + rotationCenter.x;
    });

    if (!allPointsInside()) {
      rotateRight(); // Si algún punto queda fuera del tablero, se revierte la rotación
    }
  }

  // Método para verificar si el bloque está en la parte inferior del tablero
  bool isAtBottom() {
    var gameSettings = settings.Settings();
    int lowestPoint = points.map((p) => p.y).reduce((curr, next) => curr > next ? curr : next);

    return lowestPoint >= gameSettings.boardHeight - 1;
  }
}
