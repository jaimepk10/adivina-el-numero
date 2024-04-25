import 'package:adivina_el_numero/GameScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'GameState.dart';
import 'home_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => GameState(min: 0, max: 100, timeLimit: 1),
      child: MaterialApp(
        title: 'Adivina el Número',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: GameScreen(),
        // home: HomeScreen(), // TODO: Descomentar para ver la pantalla de inicio y desde alli invocar a GameScreen
      )));
}
