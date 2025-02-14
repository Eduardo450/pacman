import 'package:flutter/material.dart';

class MyPixel extends StatelessWidget {
  final innerColor; // Color interno del píxel
  final outerColor; // Color externo del píxel
  final child; // Widget hijo opcional

  // Constructor de la clase MyPixel
  MyPixel({this.innerColor, this.outerColor, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0), // Añade un padding de 1.0 alrededor del widget
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6), // Bordes redondeados con un radio de 6
        child: Container(
          padding: EdgeInsets.all(4), // Añade un padding de 4 dentro del contenedor
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
