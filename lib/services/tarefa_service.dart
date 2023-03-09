import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:tarefas_app/models/tarefa.dart';

import 'logging_interceptors_service.dart';

class TarefaService {
  static const String url = "https://vangeanceapp.azurewebsites.net/";
  static const String buscar = "tarefa/buscar";
  static const String criar = "tarefa/criar";
  static const String atualizar = "tarefa/atualizar";
  static const String deletar = "tarefa/deletar";

  http.Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );

  Future<bool> criarTarefa(Tarefa tarefa) async {
    var mapTarefa = tarefa.toMap();
    var jsonTarefa = json.encode(mapTarefa);
    http.Response response = await client.post(
      Uri.parse("$url$criar"),
      headers: {'Content-Type': 'application/json'},
      body: jsonTarefa,
    );

    if (response.statusCode != 201 || response.statusCode != 200) {
      return false;
    }
    return true;
  }

  Future<List<Tarefa>> getTarefas() async {
    http.Response response = await client.get(Uri.parse("$url$buscar"));

    if (response.statusCode != 200) {
      throw Exception();
    }

    List<Tarefa> tarefas = [];

    List<dynamic> tarefasJSON = json.decode(response.body);
    print("chegaram $tarefasJSON");
    for (var tarefaJSON in tarefasJSON) {
      Tarefa tarefa = Tarefa.fromMap(tarefaJSON);
      tarefas.add(tarefa);
    }

    return tarefas;
  }
}
