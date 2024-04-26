import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_state.dart';

class WinnerScreen extends StatelessWidget {
  final int guessedNumber;

  const WinnerScreen({Key? key, required this.guessedNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var gameState = Provider.of<GameState>(context, listen: false);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = screenHeight * 0.1;
    final spaceSize = screenHeight * 0.05;
    final textColor = Colors.white;
    final buttonColor = Colors.red;

    return Scaffold(
      appBar: AppBar(
        title: Text('Has acertado!'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.emoji_events_outlined, size: iconSize),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.star_border, size: iconSize * 0.5),
                Transform.translate(
                  offset: Offset(0, 20),
                  child: Icon(Icons.star_border, size: iconSize * 0.5),
                ),
                Icon(Icons.star_border, size: iconSize * 0.5),
              ],
            ),
            SizedBox(height: spaceSize),
            Text('Has adivinado el número $guessedNumber!',
                style: TextStyle(fontSize: screenHeight * 0.024)),
            SizedBox(height: spaceSize),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: textColor,
                backgroundColor: buttonColor,
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
