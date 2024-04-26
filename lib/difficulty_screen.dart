import 'package:flutter/material.dart';
import 'package:adivina_el_numero/difficulty_enum.dart';
import 'package:adivina_el_numero/game_screen.dart';
import 'package:provider/provider.dart';
import 'game_state.dart';

class DifficultyScreen extends StatelessWidget {
  const DifficultyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<GameState>(
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: Dificultad.values.map((dificultad) {
                      return ListTile(
                        title: Center(child: Text(dificultad.nombre)),
                        onTap: () {
                          gameState.setDifficulty(dificultad);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GameScreen(),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ));
  }
}
