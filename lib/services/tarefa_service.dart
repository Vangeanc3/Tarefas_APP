import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
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

  void getTarefas() async {
    http.Response response = await client.get(Uri.parse("$url$buscar"));
    print(response.body);
  }

  void criarTarefa(Tarefa tarefa) async {
    var mapTarefa = tarefa.toMap();
    var jsonTarefa = json.encode(mapTarefa);
    await client.post(
      Uri.parse("$url$criar"),
      headers: {'Content-Type': 'application/json'},
      body: jsonTarefa,
    );
  }
}
