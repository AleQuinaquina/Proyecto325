import 'package:flutter/material.dart';
import 'enums.dart'; // Importar el enum

// Definición del botón de acción
class ActionButton extends StatelessWidget {
  // Declaración de variables
  final Function(LastButtonPressed) onClickedFunction;
  final Icon buttonIcon;
  final LastButtonPressed nextAction;

  // Constructor de la clase ActionButton
  ActionButton(this.onClickedFunction, this.buttonIcon, this.nextAction);

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Añade un padding alrededor del botón
      padding: EdgeInsets.all(5),
      child: ElevatedButton(
        // Acción a realizar cuando se presiona el botón
        onPressed: () {
          onClickedFunction(nextAction);
        },
        // Estilo del botón
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 82, 118, 217), // Establece el color de fondo del botón
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Ajusta el padding interno del botón
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Añade bordes redondeados
            side: BorderSide(color: const Color.fromARGB(255, 59, 70, 118), width: 2), // Añade un borde blanco
          ),
          elevation: 10, // Añade una sombra para dar efecto 3D
        ),
        // Icono del botón
        child: buttonIcon,
      ),
    );
  }
}
