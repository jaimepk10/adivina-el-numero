import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_state.dart';

class LoserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context, listen: false);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text('Perdiste'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.sentiment_very_dissatisfied,
                  color: Colors.red,
                  size: screenHeight * 0.1,
                ),
                SizedBox(height: screenHeight * 0.05),
                Text('Perdiste!',
                    style: TextStyle(
                        fontSize: screenHeight * 0.036,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Mejor suerte la próxima vez',
                  style: TextStyle(fontSize: screenHeight * 0.018),
                ),
                SizedBox(height: screenHeight * 0.05),
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
        ));
  }
}
