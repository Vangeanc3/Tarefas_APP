import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:tarefas_app/models/tarefa.dart';

import 'logging_interceptors_service.dart';

class TestService {
  static const String url2 = "https://vangeanceapp.azurewebsites.net/";
  static const String recurso = "tarefa/buscar";

  http.Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );

}
