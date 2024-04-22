import 'package:adivina_el_numero/GameScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'GameState.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => GameState(),
    child: const MaterialApp(
      home: GameScreen(min: 0, max: 100),
    ),
  ));
}
