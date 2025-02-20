import 'package:flutter/material.dart';
import 'package:flutter_application_1/bomb.dart';
import 'package:flutter_application_1/numberbox.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// variables

  int numberOfSquares = 9 * 9;
  int numberInEachRow = 9;

  //numero de bombas reveladas
  var squareStatus = [];

  //locaciones de bomba

  final List<int> bombLocation = [
    4,
    5,
    6,
    32,
    18,
    20,
    25,
    41,
    42,
    43,
    61,
  ];

  bool bombsRevealed = false;

  @override
  void initState() {
    super.initState();

    //inicializar cuando hay 0 bombas y ninguna es revelada
    for (int i = 0; i < numberOfSquares; i++) {
      squareStatus.add([0, false]);
    }
    scanBombs();
  }

  void restartGame() {
    setState(() {
      bombsRevealed = false;
      for (int i = 0; i < numberOfSquares; i++) {
        squareStatus[i][1] = false;
      }
    });
  }

  void revealBoxNumbers(int index) {
    // revela cuando los numeros son 1,2,3...
    if (squareStatus[index][0] != 0) {
      setState(() {
        squareStatus[index][1] = true;
      });
    }

    // cuando es 0
    else if (squareStatus[index][0] == 0) {
      // revelar los 8 cuadros al rededor, a menos que este en una pared
      setState(() {
        squareStatus[index][1] = true;

        //revelar el cuadro izquierdo, a menos que este en una pared
        if (index % numberInEachRow != 0) {
          // cuando no se ha revelado y es 0
          if (squareStatus[index - 1][0] == 0 &&
              squareStatus[index - 1][1] == false) {
            revealBoxNumbers(index - 1);
          }

//revelar el cuadro izquierdo

          squareStatus[index - 1][1] = true;
        }

        //revelar el cuadro derecho, a menos que este en una pared
        if (index % numberInEachRow != 0 && index >= numberInEachRow) {
          // cuando no se ha revelado y es 0
          if (squareStatus[index - 1 - numberInEachRow][0] == 0 &&
              squareStatus[index - 1 - numberInEachRow][1] == false) {
            revealBoxNumbers(index - 1 - numberInEachRow);
          }

          squareStatus[index - 1 - numberInEachRow][1] = true;
        }

        //revelar el cuadro superior, a menos que este en una pared
        if (index >= numberInEachRow) {
          // cuando no se ha revelado y es 0
          if (squareStatus[index - numberInEachRow][0] == 0 &&
              squareStatus[index - numberInEachRow][1] == false) {
            revealBoxNumbers(index - numberInEachRow);
          }

          squareStatus[index - numberInEachRow][1] = true;
        }

        //revelar el cuadro superior, a menos que este en una pared
        if (index >= numberInEachRow &&
            index % numberInEachRow != numberInEachRow - 1) {
          // cuando no se ha revelado y es 0
          if (squareStatus[index + 1 - numberInEachRow][0] == 0 &&
              squareStatus[index + 1 - numberInEachRow][1] == false) {
            revealBoxNumbers(index + 1 - numberInEachRow);
          }

          squareStatus[index + 1 - numberInEachRow][1] = true;
        }

        //revelar el cuadro superior, a menos que este en una pared
        if (index % numberInEachRow != numberInEachRow - 1) {
          // cuando no se ha revelado y es 0
          if (squareStatus[index + 1][0] == 0 &&
              squareStatus[index + 1][1] == false) {
            revealBoxNumbers(index + 1);
          }

          squareStatus[index + 1][1] = true;
        }

        //revelar el cuadro superior, a menos que este en una pared
        if (index < numberOfSquares - numberInEachRow &&
            index % numberInEachRow != numberInEachRow - 1) {
          // cuando no se ha revelado y es 0
          if (squareStatus[index + 1 + numberInEachRow][0] == 0 &&
              squareStatus[index + 1 + numberInEachRow][1] == false) {
            revealBoxNumbers(index + 1 + numberInEachRow);
          }

          squareStatus[index + 1 + numberInEachRow][1] = true;
        }

        //revelar el cuadro superior, a menos que este en una pared
        if (index < numberOfSquares - numberInEachRow) {
          // cuando no se ha revelado y es 0
          if (squareStatus[index + numberInEachRow][0] == 0 &&
              squareStatus[index + numberInEachRow][1] == false) {
            revealBoxNumbers(index + numberInEachRow);
          }

          squareStatus[index + numberInEachRow][1] = true;
        }

        //revelar el cuadro superior, a menos que este en una pared
        if (index < numberOfSquares - numberInEachRow &&
            index % numberInEachRow != 0) {
          // cuando no se ha revelado y es 0
          if (squareStatus[index - 1 + numberInEachRow][0] == 0 &&
              squareStatus[index - 1 + numberInEachRow][1] == false) {
            revealBoxNumbers(index - 1 + numberInEachRow);
          }

          squareStatus[index - 1 + numberInEachRow][1] = true;
        }
      });
    }
  }

  void scanBombs() {
    for (int i = 0; i < numberOfSquares; i++) {
      //cuando no hay bombas al rededor inicializar
      int numberOfBombsAround = 0;

      // check square to the left, unless it is in the first column

      if (bombLocation.contains(i - 1) && i % numberInEachRow != 0) {
        numberOfBombsAround++;
      }

      // check square to the left, unlesss it is in he fisrst column
      if (bombLocation.contains(i - 1 - numberInEachRow) &&
          i % numberInEachRow != 0 &&
          i >= numberInEachRow) {
        numberOfBombsAround++;
      }

      if (bombLocation.contains(i - numberInEachRow) && i >= numberInEachRow) {
        numberOfBombsAround++;
      }

      // check square to the left, unlesss it is in he fisrst column
      if (bombLocation.contains(i + 1 - numberInEachRow) &&
          i >= numberInEachRow &&
          i % numberInEachRow != numberInEachRow - 1) {
        numberOfBombsAround++;
      }

      // check square to the left, unlesss it is in he fisrst column
      if (bombLocation.contains(i + 1) &&
          i % numberInEachRow != numberInEachRow - 1) {
        numberOfBombsAround++;
      }

      // check square to the left, unlesss it is in he fisrst column
      if (bombLocation.contains(i + 1 + numberInEachRow) &&
          i % numberInEachRow != numberInEachRow - 1 &&
          i < numberOfSquares - numberInEachRow) {
        numberOfBombsAround++;
      }

      // check square to the left, unlesss it is in he fisrst column
      if (bombLocation.contains(i + numberInEachRow) &&
          i < numberOfSquares - numberInEachRow) {
        numberOfBombsAround++;
      }

      // check square to the left, unlesss it is in he fisrst column
      if (bombLocation.contains(i - 1 + numberInEachRow) &&
          i < numberOfSquares - numberInEachRow &&
          i % numberInEachRow != 0) {
        numberOfBombsAround++;
      }

      //add total number of bombs aroun to square status

      setState(() {
        squareStatus[i][0] = numberOfBombsAround;
      });
    }
  }

  void playerLost() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey[800],
            title: Center(
              child: Text(
                "Has perdido",
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              MaterialButton(
                  color: Colors.grey[100],
                  onPressed: () {
                    restartGame();
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.refresh))
            ],
          );
        });
  }

  void playerWon() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[700],
          title: Center(
            child: Text(
              "HAS GANADO",
              style: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            MaterialButton(
                color: Colors.grey[100],
                onPressed: () {
                  restartGame();
                  Navigator.pop(context);
                },
                child: Icon(Icons.refresh))
          ],
        );
      },
    );
  }

  void checkWinner() {
    int unrevealedBoxes = 0;
    for (int i = 0; i < numberOfSquares; i++) {
      if (squareStatus[i][1] == false) {
        unrevealedBoxes++;
      }
    }

    if (unrevealedBoxes == bombLocation.length) {
      playerWon();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          //Menu y contadores
          Container(
            height: 150,
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //contador de bombas
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(bombLocation.length.toString(),
                        style: TextStyle(fontSize: 40)),
                    Text("Bombas"),
                  ],
                ),

                //boton de volver a cargar el juego
                GestureDetector(
                  onTap: restartGame,
                  child: Card(
                    color: Colors.grey[700],
                    child: Icon(Icons.refresh, color: Colors.white, size: 40),
                  ),
                ),

                Card(
                  color: Colors.grey[700],
                  child: Icon(Icons.refresh, color: Colors.white, size: 40),
                ),

                // Tiempo

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('0', style: TextStyle(fontSize: 40)),
                    Text("Tiempo"),
                  ],
                ),
              ],
            ),
          ),

          //grid
          Expanded(
            child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: numberOfSquares,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: numberInEachRow),
                itemBuilder: (context, index) {
                  if (bombLocation.contains(index)) {
                    return MyBomb(
                        revealed: bombsRevealed,
                        function: () {
                          setState(() {
                            bombsRevealed = true;
                          });
                          playerLost();
                          //player tapped the bomb, so player loses
                        });
                  } else {
                    return MyNumberBox(
                        child: squareStatus[index][0],
                        revealed: squareStatus[index][1],
                        function: () {
                          //reveal current box
                          revealBoxNumbers(index);
                          checkWinner();
                        });
                  }
                }),
          ),

          //Marca personal

          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text("Creado Por: Eduardo Ruiz"),
          )
        ],
      ),
    );
  }
}
