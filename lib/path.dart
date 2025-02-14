import 'package:flutter/material.dart';

// Definición de la clase MyPath que extiende StatelessWidget
class MyPath extends StatelessWidget {
  final innerColor; // Color interno del camino
  final outerColor; // Color externo del camino
  final child; // Widget hijo opcional

  // Constructor de la clase MyPath
  MyPath({this.innerColor, this.outerColor, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0), // Añade un padding de 1.0 alrededor del widget
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12), // Bordes redondeados con un radio de 12
        child: Container(
          padding: EdgeInsets.all(10), // Añade un padding de 10 dentro del contenedor
          color: outerColor, // Establece el color externo del contenedor
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10), // Bordes redondeados con un radio de 10
            child: Container(
              color: innerColor, // Establece el color interno del contenedor
              child: Center(child: child), // Centra el widget hijo opcional
            ),
          ),
        ),
      ),
    );
  }
}
