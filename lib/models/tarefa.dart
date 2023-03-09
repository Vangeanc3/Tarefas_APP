class Tarefa {
  String titulo;
  int dificuldade;
  String urlFoto;

  Tarefa({
    required this.titulo,
    required this.dificuldade,
    required this.urlFoto,
  });

  Tarefa.fromMap(Map<String, dynamic> map)
      : titulo = map["titulo"],
        dificuldade = map["dificuldade"],
        urlFoto = map["urlFoto"];

  Map<String, dynamic> toMap() {
    return {'titulo': titulo, 'dificuldade': dificuldade, 'urlfoto': urlFoto};
  }
}
