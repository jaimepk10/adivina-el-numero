import 'package:flutter/material.dart';

import 'GameScreen.dart';

class WinnerScreen extends StatelessWidget {
  final int guessedNumber;

  const WinnerScreen({super.key, required this.guessedNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Has acertado!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Icon(Icons.emoji_events_outlined, size: 100.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.star_border, size: 50.0),
                Transform.translate(
                  offset: const Offset(0, 20),
                  child: const Icon(Icons.star_border, size: 50.0),
                ),
                const Icon(Icons.star_border, size: 50.0),
              ],
            ),
            const SizedBox(height: 50.0),
            Text('Has adivinado el número $guessedNumber!',
                style: const TextStyle(fontSize: 24.0)),
            const SizedBox(height: 50.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GameScreen(min: 0, max: 100)),
                );
              },
              child: const Text('Volver a jugar'),
            ),
          ],
        ),
      ),
    );
  }
}
