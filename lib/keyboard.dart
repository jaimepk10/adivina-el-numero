import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_state.dart';
import 'winner_screen.dart';

class Keyboard extends StatelessWidget {
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;

  const Keyboard({super.key, required this.controller, required this.formKey});

  void handleButtonPress(int index, BuildContext context) {
    GameState gameState = Provider.of<GameState>(context, listen: false);

    if (index < 9) {
      controller.text = '${controller.text}${index + 1}';
    } else if (index == 9) {
      if (controller.text.isNotEmpty) {
        controller.text =
            controller.text.substring(0, controller.text.length - 1);
      }
    } else if (index == 10) {
      controller.text = '${controller.text}0';
    } else if (index == 11) {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        String number = controller.text;
        int num = int.parse(number);
        if (num != gameState.numberToGuess) {
          gameState.decreaseTries();
        }
        if (num == gameState.numberToGuess) {
          gameState.stopTimer();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WinnerScreen(
                      guessedNumber: gameState.numberToGuess,
                    )),
          );
        } else if (num > gameState.numberToGuess &&
            (gameState.upperBound == null || num < gameState.upperBound!)) {
          gameState.setUpperBound(num);
        } else if (num < gameState.numberToGuess &&
            (gameState.lowerBound == null || num > gameState.lowerBound!)) {
          gameState.setLowerBound(num);
        }
        controller.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final buttonWidth = constraints.maxWidth / 3;
        final buttonHeight = constraints.maxHeight / 4;
        final iconSize = buttonHeight * 0.3;
        final textColor = Colors.black;

        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 12,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: buttonWidth / buttonHeight,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
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
                          style: TextStyle(color: textColor),
                        )
                      : index == 9
                          ? Icon(Icons.backspace,
                              size: iconSize, color: textColor)
                          : index == 10
                              ? Text(
                                  '0',
                                  style: TextStyle(color: textColor),
                                )
                              : Icon(Icons.check,
                                  size: iconSize, color: textColor),
                  onPressed: () => handleButtonPress(index, context),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
