class Tarefa {
  String titulo;
  int dificuldade;
  String urlFoto;

  Tarefa({
    required this.titulo,
    required this.dificuldade,
    required this.urlFoto,
  });

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'dificuldade': dificuldade,
      'urlfoto': urlFoto
    };
  }
}