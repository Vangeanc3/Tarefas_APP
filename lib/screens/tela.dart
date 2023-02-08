// ignore: file_names
import 'package:flutter/material.dart';
import 'package:tarefas_app/components/tarefas.dart';

class Tela extends StatefulWidget {
  const Tela({super.key});

  @override
  State<Tela> createState() => _TelaState();
}

class _TelaState extends State<Tela> {
  @override
  bool opacidade = true;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text("Tarefas"),
      ),
      body: AnimatedOpacity(
        opacity: opacidade ? 1 : 0,
        duration: Duration(milliseconds: 1000),
        child: ListView(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Tarefa("Aprender Dart", "", 1),
            Tarefa("Aprender Flutter", "", 1),
            Tarefa("Encerrar chamados", "", 2),
            Tarefa("Finalizar API", "", 5),
            Tarefa("Finalizar API e testar a aplicação", "", 5),
            SizedBox(
              height: 80,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {
          opacidade = !opacidade;
        });
      }),
    );
  }
}
