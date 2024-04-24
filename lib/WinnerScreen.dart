import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'GameScreen.dart';
import 'GameState.dart';

class WinnerScreen extends StatelessWidget {
  final int guessedNumber;

  const WinnerScreen({Key? key, required this.guessedNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var gameState = Provider.of<GameState>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Has acertado!'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.emoji_events_outlined, size: 100.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.star_border, size: 50.0),
                Transform.translate(
                  offset: Offset(0, 20),
                  child: Icon(Icons.star_border, size: 50.0),
                ),
                Icon(Icons.star_border, size: 50.0),
              ],
            ),
            const SizedBox(height: 50.0),
            Text('Has adivinado el número $guessedNumber!',
                style: TextStyle(fontSize: 24.0)),
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
          ],
        ),
      ),
    );
  }
}
