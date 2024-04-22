import 'package:flutter/foundation.dart';
import 'dart:math';

class GameState extends ChangeNotifier {
  int _min = 0;
  int _max = 100;
  int _numberToGuess = 0;

  int get min => _min;
  int get max => _max;
  int get numberToGuess => _numberToGuess;

  void resetGame() {
    _numberToGuess = _min + Random().nextInt(_max - _min);
    notifyListeners();
  }
}
