import 'package:flutter/material.dart';
import 'helper.dart';
import 'dart:async';
import 'blocks/block.dart';
import 'blocks/alivePoint.dart';
import 'scoreDisplay.dart';
import 'userInput.dart';
import 'settings.dart' as settings; 
import 'enums.dart'; 
import 'move_dir.dart'; 

class Game extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Game();
}

class _Game extends State<Game> {
  LastButtonPressed performAction = LastButtonPressed.NONE;
  late Block currentBlock; // Marked as late
  List<AlivePoint> alivePoints = [];

  int score = 0;
  var gameSettings = settings.Settings(); // Use alias for settings

  @override
  void initState() {
    super.initState();
    startGame(); // Comienza el juego al iniciar el widget
  }

  // Función llamada cuando se presiona un botón de acción
  void onActionButtonPressed(LastButtonPressed newAction) {
    setState(() {
      performAction = newAction;
    });
  }

  // Inicializa el juego
  void startGame() {
    setState(() {
      currentBlock = getRandomBlock(); // Inicializa el bloque actual
    });

    // Inicia un temporizador para manejar el juego
    gameSettings.timer = Timer.periodic(
      Duration(milliseconds: gameSettings.gameSpeed),
      onTimeTick,
    );
  }

  // Comprueba si hay entrada de usuario y realiza acciones correspondientes
  void chechForUserInput() {
    if (performAction != LastButtonPressed.NONE) {
      setState(() {
        // Ejecuta la acción correspondiente al botón presionado
        switch (performAction) {
          case LastButtonPressed.LEFT:
            currentBlock.move(MoveDir.LEFT);
            break;
          case LastButtonPressed.RIGHT:
            currentBlock.move(MoveDir.RIGHT);
            break;
          case LastButtonPressed.ROTATE_LEFT:
            currentBlock.rotateLeft();
            break;
          case LastButtonPressed.ROTATE_RIGHT:
            currentBlock.rotateRight();
            break;
          default:
            break;
        }

        performAction = LastButtonPressed.NONE; // Reinicia la acción realizada
      });
    }
  }

  // Guarda el bloque actual antes de que colisione con otros bloques
  void saveOldBlock() {
    currentBlock.points.forEach((point) {
      AlivePoint newPoint = AlivePoint(point.x, point.y, currentBlock.color ?? Colors.grey); // Crea un nuevo punto con el color del bloque actual
      setState(() {
        alivePoints.add(newPoint); // Agrega el punto al listado de puntos vivos
      });
    });
  }

  // Comprueba si el bloque actual está sobre los bloques antiguos
  bool isAboweOldBlock() {
    bool retVal = false;
    alivePoints.forEach((oldPoint) {
      if (oldPoint.checkIfPointsCollide(currentBlock.points)) {
        retVal = true;
      }
    });

    return retVal;
  }

  // Elimina una fila completa del tablero
  void removeRow(int row) {
    setState(() {
      alivePoints.removeWhere((point) => point.y == row); // Elimina los puntos de la fila
      // Mueve los puntos encima de la fila eliminada hacia abajo
      alivePoints.forEach((point) {
        if (point.y < row) {
          point.y += 1;
        }
      });
      score += 1; // Incrementa el puntaje
    });
  }

  // Elimina todas las filas completas del tablero
  void removeFullRows() {
    for (int currentRow = 0; currentRow < gameSettings.boardHeight; currentRow++) {
      int counter = 0;
      alivePoints.forEach((point) {
        if (point.y == currentRow) {
          counter++;
        }
      });

      if (counter >= gameSettings.boardWidth) {
        // Si la fila está llena, elimínala
        removeRow(currentRow);
      }
    }
  }

  // Comprueba si el jugador ha perdido el juego
  bool playerLost() {
    bool retVal = false;

    alivePoints.forEach((point) {
      if (point.y <= 0) {
        retVal = true;
      }
    });

    return retVal;
  }

  // Función llamada en cada tic del temporizador para manejar la lógica del juego
  void onTimeTick(Timer time) {
    if (currentBlock == null || playerLost()) return;

    removeFullRows(); // Elimina las filas completas
    // Si el bloque actual está en el fondo o sobre bloques antiguos, guarda el bloque actual y genera uno nuevo
    if (currentBlock.isAtBottom() || isAboweOldBlock()) {
      saveOldBlock();
      setState(() {
        currentBlock = getRandomBlock();
              });
    } else {
      setState(() {
        currentBlock.move(MoveDir.DOWN); // Mueve el bloque hacia abajo
      });
      chechForUserInput(); // Comprueba si hay entrada de usuario
    }
  }

  // Dibuja los bloques en el tablero
  Widget drawTetrisBlocks() {
    if (currentBlock == null) return Container(); // Si no hay bloque actual, devuelve un contenedor vacío

    List<Positioned> visiblePoints = [];

    // Dibuja el bloque actual
    currentBlock.points.forEach((point) {
      visiblePoints.add(
        Positioned(
          left: point.x * gameSettings.pointSize, // Posición horizontal del punto
          top: point.y * gameSettings.pointSize, // Posición vertical del punto
          child: getTetrisPoint(currentBlock.color ?? Colors.grey), // Obtiene un punto con el color del bloque actual
        ),
      );
    });

    // Dibuja los bloques antiguos
    alivePoints.forEach((point) {
      visiblePoints.add(
        Positioned(
          left: point.x * gameSettings.pointSize, // Posición horizontal del punto
          top: point.y * gameSettings.pointSize, // Posición vertical del punto
          child: getTetrisPoint(point.color), // Obtiene un punto con el color del bloque antiguo
        ),
      );
    });

    return Stack(children: visiblePoints); // Devuelve un Stack con todos los puntos visibles
  }

  // Construye la interfaz del juego
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Center(
          child: Container(
            width: gameSettings.pixelWidth,
            height: gameSettings.pixelHeight,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black), // Bordes del contenedor del tablero
            ),
            child: playerLost() == false // Si el jugador no ha perdido
                ? drawTetrisBlocks() // Dibuja los bloques en el tablero
                : getGameOverText(score), // Muestra el mensaje de fin de juego
          ),
        ),
        // Muestra el puntaje y los botones de entrada del usuario
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ScoreDisplay(score), // Muestra el puntaje actual
            UserInput(onActionButtonPressed), // Muestra los botones de entrada del usuario
          ],
        )
      ],
    );
  }
}

