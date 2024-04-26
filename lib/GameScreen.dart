import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'GameState.dart';
import 'keyboard.dart';
import 'LoserScreen.dart';
import 'LowerBoundDisplay.dart';
import 'NumberInputForm.dart';
import 'TimerDisplay.dart';
import 'UpperBoundDisplay.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
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
                child: Keyboard(controller: _controller, formKey: _formKey),
              ),
              SizedBox(height: 40.0),
            ],
          );
        },
      ),
    );
  }
}
