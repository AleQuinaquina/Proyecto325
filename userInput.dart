import 'package:flutter/material.dart';
import 'actionButton.dart';
import 'enums.dart'; // Importa el enum LastButtonPressed

class UserInput extends StatelessWidget {
  final Function(LastButtonPressed) onActionButtonPressed;

  // Constructor
  const UserInput(this.onActionButtonPressed, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        // Fila de botones de rotación
        Row(
          children: <Widget>[
            // Botón para rotar a la izquierda
            ActionButton(
              onActionButtonPressed,
              const Icon(Icons.rotate_left), // Icono de rotación a la izquierda
              LastButtonPressed.ROTATE_LEFT, // Acción asociada al botón
            ),
            // Botón para rotar a la derecha
            ActionButton(
              onActionButtonPressed,
              const Icon(Icons.rotate_right), // Icono de rotación a la derecha
              LastButtonPressed.ROTATE_RIGHT, // Acción asociada al botón
            ),
          ],
        ),
        // Fila de botones de movimiento lateral
        Row(
          children: <Widget>[
            // Botón para mover a la izquierda
            ActionButton(
              onActionButtonPressed,
              const Icon(Icons.arrow_left), // Icono de movimiento a la izquierda
              LastButtonPressed.LEFT, // Acción asociada al botón
            ),
            // Botón para mover a la derecha
            ActionButton(
              onActionButtonPressed,
              const Icon(Icons.arrow_right), // Icono de movimiento a la derecha
              LastButtonPressed.RIGHT, // Acción asociada al botón
            ),
          ],
        ),
      ],
    );
  }
}
