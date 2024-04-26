import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_state.dart';

class TimerDisplay extends StatelessWidget {
  const TimerDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = screenHeight * 0.024;
    final iconDistance = 10.0;

    return SizedBox(
      height: screenHeight * 0.1,
      width: screenWidth * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${gameState.timeRemaining ~/ 60}:${(gameState.timeRemaining % 60).toString().padLeft(2, '0')}',
            style: TextStyle(fontSize: fontSize),
          ),
          SizedBox(width: iconDistance),
          const Icon(Icons.access_time),
        ],
      ),
    );
  }
}
