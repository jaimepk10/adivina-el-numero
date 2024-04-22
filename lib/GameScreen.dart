import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final _formKey = GlobalKey<FormState>();
  String _number = '';
  int _upperBound = 100; // Inicializa con un valor alto
  int _lowerBound = 0; // Inicializa con un valor bajo
  int _numberToGuess = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adivina el número'),
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
                    child: Container(
                      width: 200, // Width of the input field
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          setState(() {
                            int num = int.parse(_number);
                            if (num > _numberToGuess && num < _upperBound) {
                              _upperBound = num;
                            } else if (num < _numberToGuess &&
                                num > _lowerBound) {
                              _lowerBound = num;
                            }
                          });
                        }
                      },
                      child: Icon(Icons.check),
                      shape: CircleBorder(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('$_upperBound', style: TextStyle(fontSize: 24.0)),
                    Icon(Icons.arrow_downward, size: 30.0),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('$_lowerBound', style: TextStyle(fontSize: 24.0)),
                    Icon(Icons.arrow_upward, size: 30.0),
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
