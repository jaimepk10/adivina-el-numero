import 'package:adivina_el_numero/tries_display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_state.dart';
import 'keyboard.dart';
import 'loser_screen.dart';
import 'lower_bound_display.dart';
import 'number_input_form.dart';
import 'timer_display.dart';
import 'upper_bound_display.dart';

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
          if (gameState.timeRemaining == 0 || gameState.tries == 0) {
            gameState.stopTimer();
            WidgetsBinding.instance.addPostFrameCallback((_) {
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
                        TriesDisplay(), // Add the new widget
                        NumberInputForm(
                          formKey: _formKey,
                          controller: _controller,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        UpperBoundDisplay(),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            ],
          );
        },
      ),
    );
  }
}
