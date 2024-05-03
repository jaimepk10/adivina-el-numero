import 'package:adivina_el_numero/pause_dialog.dart';
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
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.pause),
          onPressed: () {
            var gameState = Provider.of<GameState>(context, listen: false);
            gameState.stopTimer();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const PauseDialog();
              },
            ).then((_) => gameState.startTimer());
          },
        ),
        title: const Text('Adivina el número'),
      ),
      body: Consumer<GameState>(
        builder: (context, gameState, child) {
          if (gameState.timeRemaining == 0 || gameState.tries == 0) {
            gameState.stopTimer();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoserScreen()),
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
                        const TimerDisplay(),
                        const TriesDisplay(),
                        NumberInputForm(
                          formKey: _formKey,
                          controller: _controller,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        const UpperBoundDisplay(),
                        SizedBox(height: screenHeight * 0.02),
                        const LowerBoundDisplay(),
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
