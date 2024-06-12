import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final Function onClickedFunction;

  // Constructor
  const MenuButton(this.onClickedFunction, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 60,
      minWidth: 200,
      child: ElevatedButton(
        // Define la acción al presionar el botón
        onPressed: () {
          onClickedFunction();
        },
        // Estilo del botón
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 117, 129, 236), // Color del botón
        ),
        // Contenido del botón
        child: const Icon(Icons.add_reaction_outlined), // Ícono dentro del botón
      ),
    );
  }
}
