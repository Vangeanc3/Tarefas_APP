// ignore: file_names
import 'package:flutter/material.dart';
import 'package:tarefas_app/components/tarefas.dart';
import 'package:tarefas_app/data/tarefa_inherited.dart';
import 'package:tarefas_app/screens/criarTarefa.dart';

class Tela extends StatefulWidget {
  Tela({super.key});

  @override
  State<Tela> createState() => _TelaState();
}

class _TelaState extends State<Tela> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text("Tarefas"),
      ),
      body: ListView(
        // ignore: prefer_const_literals_to_create_immutables
        children: TarefaInherited.of(context).listaTarefas,
        padding: const EdgeInsets.only(top: 8, bottom: 70),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (contextNovo) => CriarTarefa(tarefaContext: context),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
