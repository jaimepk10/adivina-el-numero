import 'package:flutter/material.dart';
import 'package:adivina_el_numero/difficulty_enum.dart';
import 'package:adivina_el_numero/game_screen.dart';
import 'package:provider/provider.dart';
import 'game_state.dart';

class DifficultyScreen extends StatelessWidget {
  const DifficultyScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    child: ListView(
                      children: Dificultad.values.map((dificultad) {
                        return Card(
                          margin: const EdgeInsets.all(10.0),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: Colors.grey[200],
                          child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              onTap: () {
                                gameState.setDifficulty(dificultad);
                                Future.delayed(const Duration(milliseconds: 50),
                                    () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const GameScreen(),
                                    ),
                                  );
                                });
                              },
                              child: ListTile(
                                contentPadding: EdgeInsets.all(15.0),
                                leading: Icon(dificultad.icono,
                                    color: Colors
                                        .red[700]), // Cambia el color aquí
                                title: Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    dificultad.nombre,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                subtitle: Text(
                                  'Rango: ${dificultad.min}-${dificultad.max}\n'
                                  'Tiempo: ${dificultad.tiempo} minutos\n'
                                  'Intentos: ${dificultad.intentos}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              )),
                        );
                      }).toList(),
                    ),
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
