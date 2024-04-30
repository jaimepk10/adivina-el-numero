import 'package:adivina_el_numero/difficulty_screen.dart';
import 'package:adivina_el_numero/score_dialog.dart';
import 'package:adivina_el_numero/score_manager.dart';
import 'package:flutter/material.dart';

class PauseDialog extends StatelessWidget {
  const PauseDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 10,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(
              'Pausa',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceEvenly, // This will space your buttons evenly
              children: <Widget>[
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.stop_circle_outlined),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                    '¿Estás seguro de que quieres terminar el juego?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DifficultyScreen()),
                                          (Route<dynamic> route) => false);
                                    },
                                    child: Text('Sí'),
                                  ),
                                ],
                              );
                            });
                      },
                    ),
                    Text('Terminar'), // Text below the button
                  ],
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.play_circle_outline_outlined),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Text('Resumir'), // Text below the button
                  ],
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.scoreboard_outlined),
                      onPressed: () {
                        var scores = ScoreManager.loadBestScores();
                        //print all the scores 1 by 1 on console
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ScoresDialog(
                              scoresFuture: scores,
                            );
                          },
                        );
                      },
                    ),
                    Text('Puntuaciones'), // Text below the button
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
