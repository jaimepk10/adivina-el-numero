import 'package:flutter/foundation.dart';
import 'dart:math';

class GameState extends ChangeNotifier {
  int _min = 0;
  int _max = 100;
  int _numberToGuess = 0;
  int? _upperBound;
  int? _lowerBound;

  int get min => _min;
  int get max => _max;
  int get numberToGuess => _numberToGuess;
  int? get upperBound => _upperBound;
  int? get lowerBound => _lowerBound;

  void resetGame() {
    _numberToGuess = _min + Random().nextInt(_max - _min);
    _upperBound = null;
    _lowerBound = null;
    notifyListeners();
  }

  void setUpperBound(int value) {
    _upperBound = value;
    notifyListeners();
  }

  void setLowerBound(int value) {
    _lowerBound = value;
    notifyListeners();
  }
}
