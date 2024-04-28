import 'package:flutter/material.dart';

enum Dificultad {
  facil("Fácil", 5, 1, 0, 10, Icons.sentiment_very_satisfied),
  medio("Medio", 10, 2, 0, 100, Icons.sentiment_satisfied),
  dificil("Difícil", 20, 5, 0, 1000, Icons.sentiment_very_dissatisfied);

  const Dificultad(
      this.nombre, this.intentos, this.tiempo, this.min, this.max, this.icono);

  final String nombre;
  final int intentos;
  final int tiempo;
  final int min;
  final int max;
  final IconData icono;
}
