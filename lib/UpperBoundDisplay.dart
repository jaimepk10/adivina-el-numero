import 'package:flutter/material.dart';
import 'GameState.dart';

class UpperBoundDisplay extends StatelessWidget {
  final GameState gameState;

  UpperBoundDisplay({required this.gameState});

  @override
  Widget build(BuildContext context) {
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
