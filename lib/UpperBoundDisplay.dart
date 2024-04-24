import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'GameState.dart';

class UpperBoundDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);
    return gameState.upperBound != null
        ? Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${gameState.upperBound}',
              style: const TextStyle(fontSize: 24.0)),
          const Icon(Icons.arrow_downward, size: 30.0, color: Colors.red),
        ],
      ),
    )
        : Container();
  }
}