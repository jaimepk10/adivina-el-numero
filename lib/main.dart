import 'package:adivina_el_numero/GameScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: GameScreen(min: 0, max: 100),
    ),
  );
}
