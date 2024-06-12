import 'package:flutter/material.dart';

class ScoreDisplay extends StatelessWidget {
  final int score;

  // Constructor que acepta el puntaje como parámetro
  const ScoreDisplay(this.score, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, // Ancho del contenedor
      height: 100, // Altura del contenedor
      alignment: Alignment.center, // Centra el contenido dentro del contenedor
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.blue), // Bordes del contenedor
        borderRadius: BorderRadius.circular(10.0), // Bordes redondeados
      ),
      // Texto que muestra el puntaje
      child: Text(
        "Score\n$score", // Muestra el texto "Score" y el puntaje en una nueva línea
        textAlign: TextAlign.center, // Centra el texto
        style: const TextStyle(
          color: Colors.white, // Color del texto
          fontSize: 20.0, // Tamaño de la fuente
          fontWeight: FontWeight.bold, // Negrita en el texto
        ),
      ),
    );
  }
}
