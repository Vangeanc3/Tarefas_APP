import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:tarefas_app/models/tarefa.dart';

import 'logging_interceptors_service.dart';

class TarefaService {
  static const String url = "https://192.168.38.78:7056/tarefa/";

  http.Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );

  // var cliente = http.IOClient(HttpClient(context: getContext()));
  // var clienteTeste = http.HttpClient()

  String URL() {
    return url;
  }

  Uri getUri() {
    return Uri.parse("${URL()}buscar/");
  }

  Uri postUri() {
    return Uri.parse("${URL()}criar");
  }

  Uri updateUri() {
    return Uri.parse("${URL()}atualizar/");
  }

  Uri deleteUri() {
    return Uri.parse("${URL()}deletar/");
  }

  criarTarefa(Tarefa tarefa) async {
    // var context = SecurityContext()
    //   ..setTrustedCertificatesBytes(
    //     (await rootBundle.load('assets/cert.pem')).buffer.asUint8List(),
    //   );

    // http.Client cliente = InterceptedClient.build(
    //     interceptors: [LoggingInterceptor()],
    //     client: IOClient(
    //       HttpClient(context: context)
    //         ..badCertificateCallback =
    //             (X509Certificate cert, String host, int port) => true,
    //     ));

    String tarefaJSON = json.encode(tarefa.toMap());

    http.post(postUri(),
        body: tarefaJSON, headers: {'Content-type': 'application/json'});
    // http.Response response = await client.post(
    //   postUri(),
    //   headers: {'Content-type': 'application/json'},
    //   body: tarefaJSON,
    // );
  }

  buscarTarefas() async {
    // var context = SecurityContext()
    //   ..setTrustedCertificatesBytes(
    //     (await rootBundle.load('assets/cert.pem')).buffer.asUint8List(),
    //   );
    // http.Client cliente = InterceptedClient.build(
    //     interceptors: [LoggingInterceptor()],
    //     client: IOClient(HttpClient(context: context)));
    http.Response response = await client.get(getUri());

    print(response);
  }
}
