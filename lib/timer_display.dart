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
    final iconPosition = screenWidth * 0.15;

    return Stack(alignment: Alignment.center, children: <Widget>[
      Align(
        alignment: Alignment.center,
        child: Text(
          '${gameState.timeRemaining ~/ 60}:${(gameState.timeRemaining % 60).toString().padLeft(2, '0')}',
          style: TextStyle(fontSize: fontSize),
        ),
      ),
      Positioned(right: iconPosition, child: const Icon(Icons.access_time))
    ]);
  }
}
