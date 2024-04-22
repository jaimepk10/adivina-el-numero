import 'dart:math';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  final int min;
  final int max;

  const GameScreen({super.key, required this.min, required this.max});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final _formKey = GlobalKey<FormState>();
  String _number = '';
  int? _upperBound;
  int? _lowerBound;
  late final int _numberToGuess;

  @override
  void initState() {
    super.initState();
    _numberToGuess = widget.min + Random().nextInt(widget.max - widget.min);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adivina el número'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 200,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          labelText: 'Introduce un número',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor introduce un número';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _number = value!;
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    right: 20.0,
                    child: FloatingActionButton(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          setState(() {
                            int num = int.parse(_number);
                            if (num > _numberToGuess &&
                                (_upperBound == null || num < _upperBound!)) {
                              _upperBound = num;
                            } else if (num < _numberToGuess &&
                                (_lowerBound == null || num > _lowerBound!)) {
                              _lowerBound = num;
                            }
                          });
                        }
                      },
                      shape: const CircleBorder(),
                      child: const Icon(Icons.check),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              if (_upperBound != null)
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('$_upperBound',
                          style: const TextStyle(fontSize: 24.0)),
                      const Icon(Icons.arrow_downward,
                          size: 30.0, color: Colors.red),
                    ],
                  ),
                ),
              const SizedBox(height: 20.0),
              if (_lowerBound != null)
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('$_lowerBound',
                          style: const TextStyle(fontSize: 24.0)),
                      const Icon(Icons.arrow_upward,
                          size: 30.0, color: Colors.red),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
