import 'package:flutter/material.dart';
import 'package:tarefas_app/services/tarefa_service.dart';
import '../components/tarefa_card.dart';
import '../data/tarefa_dao.dart';
import '../models/tarefa.dart';

class CriarTarefa extends StatefulWidget {
  const CriarTarefa({super.key});

  @override
  State<CriarTarefa> createState() => _CriarTarefaState();
}

class _CriarTarefaState extends State<CriarTarefa> {
  var nomeController = TextEditingController();
  var dificuldadeController = TextEditingController();
  var imageController = TextEditingController();
  final service = TarefaService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: (AppBar(
          title: const Text("Nova Tarefa"),
        )),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: 650,
              width: 375,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 3)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      controller: nomeController,
                      validator: (String? value) {
                        if (validarValor(value)) {
                          return ("Insira o nome da tarefa");
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Nome",
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      controller: dificuldadeController,
                      validator: (value) {
                        if (validarDificuldade(value)) {
                          return ("Insira uma dificuldade entre 1 e 5");
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Dificuldade",
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      controller: imageController,
                      validator: (value) {
                        if (validarValor(value)) {
                          return ("Insira uma URL de uma imagem");
                        } else {
                          return null;
                        }
                      },
                      onChanged: (text) {
                        setState(() {});
                      },
                      keyboardType: TextInputType.url,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Imagem",
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 72,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 2, color: Colors.blue),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        imageController.text,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return (Image.asset("assets/images/nophoto.png"));
                        },
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          inserirTarefa(context);
                        }
                      },
                      child: const Text("Adicionar"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  inserirTarefa(BuildContext context) async {
    Tarefa tarefa = Tarefa(
        titulo: nomeController.text,
        dificuldade: int.parse(dificuldadeController.text),
        urlFoto: imageController.text);

    service.criarTarefa(tarefa).then((value) {
        Navigator.of(context).pop(value);
      });
    }
  }

  bool validarValor(String? valor) {
    if (valor != null && valor.isEmpty) {
      return true;
    }
    return false;
  }

  bool validarDificuldade(String? valor) {
    if (valor != null && valor.isEmpty) {
      if (int.parse(valor) > 5 || int.parse(valor) < 1) {
        return true;
      }
    }
    return false;
  }
