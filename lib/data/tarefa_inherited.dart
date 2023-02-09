import 'package:flutter/material.dart';
import 'package:tarefas_app/components/tarefas.dart';

class TarefaInherited extends InheritedWidget {
  TarefaInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final List<Tarefa> listaTarefas = [
    Tarefa("Aprender Dart", "assets/images/dash.jpg", 1),
    Tarefa("Finalizar API e testar a aplicação", "", 5),
  ];

  void novaTarefa(String nome, String urlFoto, int dificuldade) {
    listaTarefas.add(Tarefa(nome, urlFoto, dificuldade));
  }

  static TarefaInherited of(BuildContext context) {
    final TarefaInherited? result =
        context.dependOnInheritedWidgetOfExactType<TarefaInherited>();
    assert(result != null, 'No TarefaInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TarefaInherited old) {
    return old.listaTarefas.length != listaTarefas.length;
  }
}
