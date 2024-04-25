import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'GameState.dart';
import 'difficulty_screen.dart';

class LoserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: Text('Perdiste'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.sentiment_very_dissatisfied,
                  color: Colors.red,
                  size: 100.0,
                ),
                const SizedBox(height: 50.0),
                Text('Perdiste!',
                    style:
                        TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20.0),
                Text(
                  'Mejor suerte la próxima vez',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 50.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    gameState.resetGame();
                    Navigator.pop(context);
                  },
                  child: Text('Volver a jugar'),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      gameState.resetGame();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DifficultyScreen()),
                      );
                    },
                    child: Text('Cambiar de dificultad')),
              ],
            ),
          ),
        ));
  }
}
