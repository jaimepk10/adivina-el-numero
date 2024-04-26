import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'GameState.dart';
import 'WinnerScreen.dart';

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
        if (num == gameState.numberToGuess) {
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
                          style: const TextStyle(color: Colors.black),
                        )
                      : index == 9
                          ? const Icon(Icons.backspace,
                              size: 30.0, color: Colors.black)
                          : index == 10
                              ? const Text(
                                  '0',
                                  style: TextStyle(color: Colors.black),
                                )
                              : const Icon(Icons.check,
                                  size: 30.0, color: Colors.black),
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
