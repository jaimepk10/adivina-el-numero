import 'dart:async';

import 'package:flutter/foundation.dart';
import 'dart:math';

class GameState extends ChangeNotifier {
  int _min;
  int _max;
  int _numberToGuess = 0;
  int? _upperBound;
  int? _lowerBound;
  late Timer _timer;
  final int _timeLimit;
  int _timeRemaining;

  GameState({required int min, required int max, required int timeLimit})
      : _min = min,
        _max = max,
        _numberToGuess = min + Random().nextInt(max - min),
        _timeLimit = timeLimit,
        _timeRemaining = timeLimit * 60 {
    startTimer();
  }

  int get min => _min;
  int get max => _max;
  int get numberToGuess => _numberToGuess;
  int? get upperBound => _upperBound;
  int? get lowerBound => _lowerBound;
  int get timeRemaining => _timeRemaining;

  void resetGame() {
    _numberToGuess = _min + Random().nextInt(_max - _min);
    _upperBound = null;
    _lowerBound = null;
    _timeRemaining = _timeLimit * 60;
    _timer.cancel();
    startTimer();
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

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeRemaining == 0) {
        timer.cancel();
      } else {
        _timeRemaining--;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
