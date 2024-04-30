import 'dart:async';
import 'package:flutter/foundation.dart';
import 'dart:math';
import 'package:adivina_el_numero/difficulty_enum.dart';

class GameState extends ChangeNotifier {
  int _min;
  int _max;
  int _numberToGuess = 0;
  int? _upperBound;
  int? _lowerBound;
  late Timer _timer;
  int _timeLimit;
  int _timeRemaining;
  int _tries;
  int _score;
  String _playerName = '';

  GameState(
      {required int min,
      required int max,
      required int timeLimit,
      required int tries})
      : _min = min,
        _max = max,
        _numberToGuess = min + Random().nextInt(max - min),
        _timeLimit = timeLimit,
        _timeRemaining = timeLimit * 60,
        _tries = tries,
        _score = 1000 {
    startTimer();
  }

  int get min => _min;
  int get max => _max;
  int get numberToGuess => _numberToGuess;
  int? get upperBound => _upperBound;
  int? get lowerBound => _lowerBound;
  int get timeRemaining => _timeRemaining;
  int get tries => _tries;
  int get score => _score;
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

  void setDifficulty(Dificultad difficulty) {
    resetGame();
    _min = difficulty.min;
    _max = difficulty.max;
    _numberToGuess = min + Random().nextInt(max - min);
    _timeLimit = difficulty.tiempo;
    _timeRemaining = _timeLimit * 60;
    _tries = difficulty.intentos;
    notifyListeners();
  }

  void setPlayerName(String name) {
    _playerName = name;
    print(name);
    notifyListeners();
  }

  int calculateScore() {
    // Points for time
    int timeScore = timeRemaining;
    // Points for attempts
    int attemptsPenalty = tries * 10;
    // Total score
    int totalScore = timeScore - attemptsPenalty;
    return totalScore;
  }
}
