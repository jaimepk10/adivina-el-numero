import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'GameState.dart';
import 'LoserScreen.dart';
import 'LowerBoundDisplay.dart';
import 'NumberInputForm.dart';
import 'TimerDisplay.dart';
import 'UpperBoundDisplay.dart';
import 'WinnerScreen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  String _number = '';

  @override
  void initState() {
    super.initState();
  }

  void handleButtonPress(int index, GameState gameState) {
    if (index < 9) {
      _controller.text = _controller.text + '${index + 1}';
    } else if (index == 9) {
      if (_controller.text.isNotEmpty) {
        _controller.text =
            _controller.text.substring(0, _controller.text.length - 1);
      }
    } else if (index == 10) {
      _controller.text = _controller.text + '0';
    } else if (index == 11) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        _number = _controller.text;
        setState(() {
          int num = int.parse(_number);
          if (num == gameState.numberToGuess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WinnerScreen(
                        guessedNumber: gameState.numberToGuess,
                        score: gameState.calculateScore(),
                      )),
            );
          } else if (num > gameState.numberToGuess &&
              (gameState.upperBound == null || num < gameState.upperBound!)) {
            gameState.setUpperBound(num);
          } else if (num < gameState.numberToGuess &&
              (gameState.lowerBound == null || num > gameState.lowerBound!)) {
            gameState.setLowerBound(num);
          }
          _controller.clear();
        });
      }
    }
  }

  Widget buildKeyboard(GameState gameState) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final buttonWidth = constraints.maxWidth / 3;
        final buttonHeight = constraints.maxHeight / 4;
        return GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 12,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: buttonWidth / buttonHeight,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(5),
              child: SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: index < 9
                      ? Text(
                          '${index + 1}',
                          style: TextStyle(color: Colors.black),
                        )
                      : index == 9
                          ? Icon(Icons.backspace,
                              size: 30.0, color: Colors.black)
                          : index == 10
                              ? Text(
                                  '0',
                                  style: TextStyle(color: Colors.black),
                                )
                              : Icon(Icons.check,
                                  size: 30.0, color: Colors.black),
                  onPressed: () => handleButtonPress(index, gameState),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adivina el número'),
      ),
      body: Consumer<GameState>(
        builder: (context, gameState, child) {
          if (gameState.timeRemaining == 0) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoserScreen()),
              );
            });
          }
          return Column(
            children: <Widget>[
              Expanded(
                flex: 6, // 60% of space
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TimerDisplay(),
                        NumberInputForm(
                          formKey: _formKey,
                          controller: _controller,
                        ),
                        const SizedBox(height: 20.0),
                        UpperBoundDisplay(),
                        const SizedBox(height: 20.0),
                        LowerBoundDisplay(),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4, // 40% of space
                child: buildKeyboard(gameState),
              ),
              SizedBox(height: 40.0),
            ],
          );
        },
      ),
    );
  }
}
