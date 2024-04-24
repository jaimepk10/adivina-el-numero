import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'GameState.dart';

class LowerBoundDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);
    return gameState.lowerBound != null
        ? Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${gameState.lowerBound}',
                    style: const TextStyle(fontSize: 24.0)),
                const Icon(Icons.arrow_upward, size: 30.0, color: Colors.red),
              ],
            ),
          )
        : Container();
  }
}
