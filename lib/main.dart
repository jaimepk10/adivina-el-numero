import 'package:adivina_el_numero/GameScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'GameState.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => GameState(min: 0, max: 100, timeLimit: 1),
    child: const MaterialApp(
      home: GameScreen(),
    ),
  ));
}
