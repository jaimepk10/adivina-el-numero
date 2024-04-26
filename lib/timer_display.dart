import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_state.dart';

class TimerDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);
    return Stack(alignment: Alignment.center, children: <Widget>[
      Align(
        alignment: Alignment.center,
        child: Text(
          '${gameState.timeRemaining ~/ 60}:${(gameState.timeRemaining % 60).toString().padLeft(2, '0')}',
          style: TextStyle(fontSize: 24),
        ),
      ),
      Positioned(right: 150.0, child: const Icon(Icons.access_time))
    ]);
  }
}
