enum Dificultad {
  facil("Fácil", 5, 10, 0, 10),
  medio("Medio", 5, 12, 0, 100),
  dificil("Difícil", 5, 15, 0, 1000);

  const Dificultad(this.nombre, this.intentos, this.tiempo, this.min, this.max);

  final String nombre;
  final int intentos;
  final int tiempo;
  final int min;
  final int max;
}
