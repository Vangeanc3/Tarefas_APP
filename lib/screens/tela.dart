// ignore: file_names
import 'package:flutter/material.dart';
import 'package:tarefas_app/components/tarefa_card.dart';
import 'package:tarefas_app/data/tarefa_dao.dart';
import 'package:tarefas_app/models/tarefa.dart';
import 'package:tarefas_app/services/tarefa_service.dart';

class Tela extends StatefulWidget {
  const Tela({super.key});

  @override
  State<Tela> createState() => _TelaState();
}

class _TelaState extends State<Tela> {
  final _tarefaService = TarefaService();
  List<Tarefa_Card> tarefaCards = [];

  @override
  void initState() {
    carregaTarefaCards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text("Tarefas"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  tarefaCards;
                });
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        child: ListView(
          children: tarefaCards,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navegarAtualizar(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void navegarAtualizar(BuildContext context) async {
    await Navigator.of(context).pushNamed("/formulario").then((value) {
      switch (value) {
        case false:
          setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Erro em adicionar uma tarefa"),
          ));
          break;
        case true:
          setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Sucesso em adicionar a tarefa"),
          ));
          break;
        default:
      }
    });
  }

  void carregaTarefaCards() async {
    List<Tarefa> tarefas = await TarefaService().getTarefas();

    setState(() {
      tarefaCards;
      for (var tarefa in tarefas) {
        tarefaCards.add(Tarefa_Card(tarefa));
      }
    });
  }
}
