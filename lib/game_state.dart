import 'dart:async';
import 'package:flutter/foundation.dart';
import 'dart:math';
import 'package:adivina_el_numero/difficulty_enum.dart';

class GameState extends ChangeNotifier {
  // Attributes
  int _min = 0;
  int _max = 0;
  late int _numberToGuess;
  int? _upperBound;
  int? _lowerBound;
  Timer? _timer;
  late int _timeLimit;
  late int _timeRemaining;
  late int _tries;
  String _playerName = '';
  late Dificultad _difficulty;

  // Private constructor
  GameState._internal();

  // Singleton instance
  static final GameState _singleton = GameState._internal();

  // Factory constructor
  factory GameState() {
    return _singleton;
  }

  // Getters
  int get min => _min;
  int get max => _max;
  int get numberToGuess => _numberToGuess;
  int? get upperBound => _upperBound;
  int? get lowerBound => _lowerBound;
  int get timeRemaining => _timeRemaining;
  int? get tries => _tries;
  String get playerName => _playerName;
  Dificultad get difficulty => _difficulty;

  void resetGame() {
    _min = _difficulty.min;
    _max = _difficulty.max;
    _numberToGuess = _min + Random().nextInt(_max - _min);
    _upperBound = null;
    _lowerBound = null;
    _timeLimit = _difficulty.tiempo;
    _timeRemaining = _timeLimit * 60;
    _timer?.cancel();
    _tries = _difficulty.intentos;
    startTimer();
    notifyListeners();
  }

  void setDifficulty(Dificultad difficulty) {
    _difficulty = difficulty;
    resetGame();
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
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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
    _timer?.cancel();
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

  void stopTimer() {
    _timer?.cancel();
    notifyListeners();
  }
}
