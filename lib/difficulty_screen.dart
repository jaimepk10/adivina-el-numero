import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adivina_el_numero/difficulty_enum.dart';
import 'package:adivina_el_numero/game_screen.dart';
import 'package:provider/provider.dart';
import 'game_state.dart';

class DifficultyScreen extends StatefulWidget {
  const DifficultyScreen({super.key});

  @override
  _DifficultyScreenState createState() => _DifficultyScreenState();
}

class _DifficultyScreenState extends State<DifficultyScreen> {
  Dificultad dificultadSeleccionada = Dificultad.values[0];

  @override
  Widget build(BuildContext context) {
    const textColor = Colors.white;
    const buttonColor = Colors.red;

    return Scaffold(
      body: Consumer<GameState>(
        builder: (context, gameState, child) {
          return SafeArea(
            child: Center(
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 40.0),
                    child: Text(
                      'Selecciona la dificultad',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: CupertinoPicker(
                          itemExtent: 60,
                          onSelectedItemChanged: (index) {
                            setState(() {
                              dificultadSeleccionada = Dificultad.values[index];
                            });
                          },
                          children: Dificultad.values.map((dificultad) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    dificultad.nombre,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.info, color: Colors.blue),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(
                                              dificultad.nombre,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            content: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                'Rango: ${dificultad.min}-${dificultad.max}\n'
                                                'Tiempo: ${dificultad.tiempo} minutos\n'
                                                'Intentos: ${dificultad.intentos}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('OK'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                            backgroundColor: Colors.grey[200],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: textColor,
                      backgroundColor: buttonColor,
                    ),
                    onPressed: () {
                      gameState.setDifficulty(dificultadSeleccionada);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GameScreen(),
                        ),
                      );
                    },
                    child: const Text('Comenzar'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
