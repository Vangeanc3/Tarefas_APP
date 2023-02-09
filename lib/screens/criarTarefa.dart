import 'package:flutter/material.dart';
import 'package:tarefas_app/data/tarefa_inherited.dart';

class CriarTarefa extends StatefulWidget {
  const CriarTarefa({super.key, required this.tarefaContext});

  final BuildContext tarefaContext;

  @override
  State<CriarTarefa> createState() => _CriarTarefaState();
}

class _CriarTarefaState extends State<CriarTarefa> {
  var nomeController = TextEditingController();
  var dificuldadeController = TextEditingController();
  var imageController = TextEditingController();

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
                        if (value != null && value.isEmpty) {
                          return ("Insira o nome da tarefa");
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
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
                        if (value!.isEmpty ||
                            int.parse(value) > 5 ||
                            int.parse(value) < 1) {
                          return ("Insira uma dificuldade entre 1 e 5");
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
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
                        if (value!.isEmpty) {
                          return ("Insira uma URL de uma imagem");
                        } else {
                          return null;
                        }
                      },
                      onChanged: (text) {
                        setState(() {});
                      },
                      keyboardType: TextInputType.url,
                      decoration: InputDecoration(
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
                          TarefaInherited.of(widget.tarefaContext).novaTarefa(
                              nomeController.text,
                              imageController.text,
                              int.parse(dificuldadeController.text));

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Salvando nova tarefa"),
                            ),
                          );

                          Navigator.pop(context);
                        }
                      },
                      child: Text("Adicionar"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
