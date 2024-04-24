import 'package:flutter/material.dart';
import 'GameState.dart';
import 'WinnerScreen.dart';

class NumberInputForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final GameState gameState;

  NumberInputForm({
    required this.formKey,
    required this.controller,
    required this.gameState,
  });

  @override
  _NumberInputFormState createState() => _NumberInputFormState();
}

class _NumberInputFormState extends State<NumberInputForm> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 200,
            child: TextFormField(
              controller: widget.controller,
              readOnly: true,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: 'Introduce un número',
                errorStyle: TextStyle(),
                errorMaxLines: 2,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor introduce un número';
                }
                int num = int.parse(value);
                if (widget.gameState.upperBound == null &&
                    num > widget.gameState.max) {
                  return 'El número introducido está fuera del rango permitido';
                }
                return null;
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
              if (widget.formKey.currentState!.validate()) {
                widget.formKey.currentState!.save();
                String number = widget.controller.text;
                setState(() {
                  int num = int.parse(number);
                  if (num == widget.gameState.numberToGuess) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WinnerScreen(
                                guessedNumber: widget.gameState.numberToGuess,
                              )),
                    );
                  } else if (num > widget.gameState.numberToGuess &&
                      (widget.gameState.upperBound == null ||
                          num < widget.gameState.upperBound!)) {
                    widget.gameState.setUpperBound(num);
                  } else if (num < widget.gameState.numberToGuess &&
                      (widget.gameState.lowerBound == null ||
                          num > widget.gameState.lowerBound!)) {
                    widget.gameState.setLowerBound(num);
                  }
                  widget.controller.clear();
                });
              }
            },
            shape: const CircleBorder(),
            child: const Icon(Icons.check),
          ),
        ),
      ],
    );
  }
}
