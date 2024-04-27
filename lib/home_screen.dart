import 'package:adivina_el_numero/difficulty_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_state.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<GameState>(builder: (context, gameState, child) {
      return Center(
        child: Column(
          children: <Widget>[
            const Spacer(flex: 2),
            Text(
              'No es suerte, adivina!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: UnderlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Introduce tu nombre',
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  gameState.setPlayerName(_controller.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DifficultyScreen()),
                  );
                },
                child: const Text(
                  'Jugar!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Spacer(flex: 3),
          ],
        ),
      );
    }));
  }
}
