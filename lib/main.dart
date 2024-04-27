import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_state.dart';
import 'home_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => GameState(),
      child: MaterialApp(
        title: 'No es suerte, advina!',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      )));
}
