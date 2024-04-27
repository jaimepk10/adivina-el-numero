import 'dart:async';
import 'package:flutter/foundation.dart';
import 'dart:math';
import 'package:adivina_el_numero/difficulty_enum.dart';

class GameState extends ChangeNotifier {
  int _min = 0;
  int _max = 0;
  late int _numberToGuess;
  int? _upperBound;
  int? _lowerBound;
  late Timer _timer;
  late int _timeLimit;
  late int _timeRemaining;
  late int _tries;
  String _playerName = '';
  late Dificultad _difficulty;

  GameState();

  int get min => _min;
  int get max => _max;
  int get numberToGuess => _numberToGuess;
  int? get upperBound => _upperBound;
  int? get lowerBound => _lowerBound;
  int get timeRemaining => _timeRemaining;
  int? get tries => _tries;

  void resetGame() {
    _numberToGuess = _min + Random().nextInt(_max - _min);
    _upperBound = null;
    _lowerBound = null;
    _timeRemaining = _timeLimit * 60;
    _timer.cancel();
    _tries = _difficulty.intentos;
    startTimer();
    notifyListeners();
  }

  void setDifficulty(Dificultad difficulty) {
    _difficulty = difficulty;
    _min = difficulty.min;
    _max = difficulty.max;
    _numberToGuess = min + Random().nextInt(max - min);
    _upperBound = null;
    _lowerBound = null;
    _timeLimit = difficulty.tiempo;
    _timeRemaining = _timeLimit * 60;
    _tries = difficulty.intentos;
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

  void setPlayerName(String name) {
    _playerName = name;
    notifyListeners();
  }

  void decreaseTries() {
    _tries = _tries - 1;
    notifyListeners();
    notifyListeners();
  }
}
