import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pacman/pixel.dart';
import 'package:pacman/path.dart';
import 'package:pacman/player.dart';
import 'package:pacman/ghost.dart';

// Definición de la clase HomePage que extiende StatefulWidget
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// Estado de la clase HomePage
class _HomePageState extends State<HomePage> {
  static int numberInRow = 11; // Número de filas en el grid
  int numberOfSquares = numberInRow * 17; // Número total de cuadrados en el grid
  int player = numberInRow * 15 + 1; // Posición inicial del jugador
  int ghost = numberInRow * 2 + 9; // Posición inicial del fantasma
  bool mouthClosed = true; // Estado de la boca del jugador (abierta/cerrada)
  List<int> barriers = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    176,
    177,
    178,
    179,
    180,
    181,
    182,
    183,
    184,
    185,
    186,
    11,
    22,
    33,
    44,
    55,
    66,
    77,
    99,
    110,
    121,
    132,
    143,
    154,
    165,
    176,
    21,
    32,
    43,
    54,
    65,
    76,
    87,
    109,
    120,
    131,
    142,
    153,
    164,
    175,
    186,
    24,
    35,
    46,
    57,
    26,
    37,
    38,
    39,
    28,
    30,
    41,
    52,
    63,
    78,
    79,
    80,
    81,
    70,
    59,
    61,
    72,
    83,
    84,
    85,
    86,
    30,
    41,
    52,
    63,
    100,
    101,
    102,
    103,
    114,
    125,
    123,
    134,
    145,
    156,
    147,
    158,
    148,
    149,
    160,
    127,
    116,
    105,
    106,
    107,
    108,
    129,
    140,
    151,
    162
  ]; // Lista de índices que representan las barreras en el grid
  List<int> food = []; // Lista de índices que representan la comida en el grid
  String direction = 'right'; // Dirección inicial del jugador
  bool gameStarted = false; // Estado del juego (iniciado/no iniciado)
  int score = 0; // Puntuación del jugador
  Timer? gameTimer;
  Timer? ghostTimer;

  // Función para iniciar el juego
  void startGame() {
    // Cancela el temporizador existente si el juego ya ha comenzado
    if (gameTimer != null) {
      gameTimer!.cancel();
    }
    // Cancela el temporizador del fantasma existente si el juego ya ha comenzado
    if (ghostTimer != null) {
      ghostTimer!.cancel();
    }

    // Restablece las variables del estado del juego a sus valores iniciales
    setState(() {
      player = numberInRow * 15 + 1; // Posición inicial del jugador
      ghost = numberInRow * 2 + 9; // Posición inicial del fantasma
      mouthClosed = true; // Estado de la boca del jugador (abierta/cerrada)
      direction = 'right'; // Dirección inicial del jugador
      gameStarted = false; // Estado del juego (iniciado/no iniciado)
      score = 0; // Puntuación del jugador
      food = []; // Lista de índices que representan la comida en el grid
    });

    moveGhost(); // Inicia el movimiento del fantasma
    gameStarted = true; // Cambia el estado del juego a iniciado
    getFood(); // Genera la comida en el grid
    Duration duration = Duration(milliseconds: 100); // Intervalo de tiempo para el movimiento del jugador
    gameTimer = Timer.periodic(duration, (timer) {
      if (food.contains(player)) {
        food.remove(player); // Elimina la comida si el jugador la consume
        score++; // Incrementa la puntuación
      }

      setState(() {
        mouthClosed = !mouthClosed; // Alterna el estado de la boca del jugador
      });

      if (player == ghost) {
        ghost = -1; // Si el jugador colisiona con el fantasma, el fantasma desaparece
      }

      // Movimiento del jugador basado en la dirección
      switch (direction) {
        case 'left':
          moveLeft();
          break;
        case 'right':
          moveRight();
          break;
        case 'up':
          moveUp();
          break;
        case 'down':
          moveDown();
          break;
      }
    });
  }

  String ghostDirection = "left"; // Dirección inicial del fantasma
  // Función para mover el fantasma
  void moveGhost() {
    Duration ghostSpeed = Duration(milliseconds: 400); // Intervalo de tiempo para el movimiento del fantasma
    ghostTimer = Timer.periodic(ghostSpeed, (timer) {
      // Lógica para cambiar la dirección del fantasma evitando las barreras
      if (!barriers.contains(ghost - 1) && ghostDirection != "right") {
        ghostDirection = "left";
      } else if (!barriers.contains(ghost - numberInRow) &&
          ghostDirection != "down") {
        ghostDirection = "up";
      } else if (!barriers.contains(ghost + numberInRow) &&
          ghostDirection != "up") {
        ghostDirection = "down";
      } else if (!barriers.contains(ghost + 1) && ghostDirection != "left") {
        ghostDirection = "right";
      }

      // Movimiento del fantasma basado en la dirección
      switch (ghostDirection) {
        case "right":
          setState(() {
            ghost++;
          });
          break;

        case "up":
          setState(() {
            ghost -= numberInRow;
          });
          break;

        case "left":
          setState(() {
            ghost--;
          });
          break;

        case "down":
          setState(() {
            ghost += numberInRow;
          });
          break;
      }
    });
  }

  // Función para generar la comida en el grid
  void getFood() {
    for (int i = 0; i < numberOfSquares; i++) {
      if (!barriers.contains(i)) {
        food.add(i);
      }
    }
  }

  // Funciones para mover el jugador en las cuatro direcciones
  void moveLeft() {
    if (!barriers.contains(player - 1)) {
      setState(() {
        player--;
      });
    }
  }

  void moveRight() {
    if (!barriers.contains(player + 1)) {
      setState(() {
        player++;
      });
    }
  }

  void moveUp() {
    if (!barriers.contains(player - numberInRow)) {
      setState(() {
        player -= numberInRow;
      });
    }
  }

  void moveDown() {
    if (!barriers.contains(player + numberInRow)) {
      setState(() {
        player += numberInRow;
      });
    }
  }

  // Construcción de la interfaz de usuario
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Establece el color de fondo de la pantalla
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                // Detecta el deslizamiento vertical y cambia la dirección del jugador
                if (details.delta.dy > 0) {
                  direction = 'down';
                } else if (details.delta.dy < 0) {
                  direction = 'up';
                }
                print(direction);
              },
              onHorizontalDragUpdate: (details) {
                // Detecta el deslizamiento horizontal y cambia la dirección del jugador
                if (details.delta.dx > 0) {
                  direction = 'right';
                } else if (details.delta.dx < 0) {
                  direction = 'left';
                }
                print(direction);
              },
              child: Container(
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(), // Desactiva el desplazamiento del grid
                  itemCount: numberOfSquares, // Número total de cuadrados en el grid
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: numberInRow, // Número de columnas en el grid
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    // Construye cada celda del grid
                    if (player == index) {
                      // Si la celda es la posición del jugador
                      if (mouthClosed) {
                        // Si la boca del jugador está cerrada
                        return Padding(
                          padding: EdgeInsets.all(1),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 199, 14),
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      } else {
                        // Si la boca del jugador está abierta
                        if (direction == "right") {
                          return MyPlayer();
                        } else if (direction == "up") {
                          return Transform.rotate(
                            angle: 3 * pi / 2, child: MyPlayer());
                        } else if (direction == "left") {
                          return Transform.rotate(
                            angle: pi, child: MyPlayer());
                        } else if (direction == "down") {
                          return Transform.rotate(
                            angle: pi / 2, child: MyPlayer());
                        }
                      }
                    } else if (ghost == index) {
                      // Si la celda es la posición del fantasma
                      return MyGhost();
                    } else if (barriers.contains(index)) {
                      // Si la celda es una barrera
                      return MyPixel(
                        innerColor: Colors.blue[800],
                        outerColor: Colors.blue[900],
                      );
                    } else if (food.contains(index)) {
                      // Si la celda contiene comida
                      return MyPath(
                        innerColor: Colors.yellow,
                        outerColor: Colors.black,
                      );
                    } else {
                      // Si la celda es un camino vacío
                      return MyPath(
                        innerColor: Colors.black,
                        outerColor: Colors.black,
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribuye los widgets hijos de manera uniforme a lo largo de la fila
                children: [
                  Text(
                    'Score: ' + score.toString(), // Muestra la puntuación actual del jugador
                    style: TextStyle(color: Colors.white, fontSize: 40), // Estilo del texto de la puntuación
                  ),
                  GestureDetector(
                    onTap: startGame, // Inicia el juego cuando se toca el texto "P L A Y"
                    child: Text(
                      'P L A Y', // Texto del botón de inicio del juego
                      style: TextStyle(color: Colors.white, fontSize: 40), // Estilo del texto del botón
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
