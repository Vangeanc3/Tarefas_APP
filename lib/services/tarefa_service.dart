import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:tarefas_app/models/tarefa.dart';

class TarefaService {
  static String url = "https://localhost:7056/";
  static String tarefaResource = "tarefa/";
  static String journalResource = "journal/";

  String getUrl() {
    return "$url$tarefaResource";
  }

  Uri getUri() {
    return Uri.parse(getUrl());
  }

  Future<bool> criarTarefa(Tarefa tarefa) async {
    String tarefaJSON = json.encode(tarefa.toMap());
  
    http.Response response = clien
  }
}
