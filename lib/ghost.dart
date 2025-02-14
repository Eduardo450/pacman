import 'package:flutter/material.dart';

// Definición de la clase MyGhost que extiende StatelessWidget
class MyGhost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0), // Añade un padding de 2.0 alrededor del widget
      child: Image.asset(
        'lib/images/ghost.png', // Carga la imagen del fantasma desde los assets
      ),
    );
  }
}
