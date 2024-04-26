import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_state.dart';
import 'home_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => GameState(min: 0, max: 100, timeLimit: 1, tries: 10),
      child: MaterialApp(
        title: 'Adivina el Número',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      )));
}
