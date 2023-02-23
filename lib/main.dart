import 'package:flutter/material.dart';
import 'package:tarefas_app/models/tarefa.dart';
import 'package:tarefas_app/screens/criarTarefa.dart';
import 'package:tarefas_app/screens/tela.dart';
import 'package:tarefas_app/services/tarefa_service.dart';

void main() {
  runApp(const MyApp());
  TarefaService().criarTarefa(
      Tarefa(titulo: "testando", dificuldade: 5, urlFoto: 'evnjvnvi'));
  // TarefaService().buscarTarefas();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/home",
      routes: {
        "/home": (context) => const Tela(),
        "/formulario": (context) => const CriarTarefa()
      },
    );
  }
}
