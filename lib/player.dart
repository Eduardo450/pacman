import 'package:flutter/material.dart';

// Definición de la clase MyPlayer que extiende StatelessWidget
class MyPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'lib/images/pacman.png' // Carga la imagen de Pac-Man desde los assets
    );
  }
}