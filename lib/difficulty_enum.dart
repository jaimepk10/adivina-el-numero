enum Dificultad {
  facil("Fácil", 5, 10),
  medio("Medio", 5, 12),
  dificil("Difícil", 5, 15);

  const Dificultad(this.nombre, this.intentos, this.tiempo);

  final String nombre;
  final int intentos;
  final int tiempo;
}
