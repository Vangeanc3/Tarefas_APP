// ignore: file_names
import 'package:flutter/material.dart';
import 'package:tarefas_app/components/tarefa_card.dart';
import 'package:tarefas_app/data/tarefa_dao.dart';

class Tela extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  const Tela({super.key});

  @override
  State<Tela> createState() => _TelaState();
}

class _TelaState extends State<Tela> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text("Tarefas"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder<List<Tarefa_Card>>(
            future: TarefaDao().findAll(),
            builder: (context, snapshot) {
              List<Tarefa_Card>? items = snapshot.data;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(
                    child: Column(
                      children: const [
                        CircularProgressIndicator(),
                        Text('Carregando'),
                      ],
                    ),
                  );

                case ConnectionState.waiting:
                  return Center(
                    child: Column(
                      children: const [
                        CircularProgressIndicator(),
                        Text('Carregando'),
                      ],
                    ),
                  );
                case ConnectionState.active:
                  return Center(
                    child: Column(
                      children: const [
                        CircularProgressIndicator(),
                        Text('Carregando'),
                      ],
                    ),
                  );
                case ConnectionState.done:
                  if (snapshot.hasData && items != null) {
                    if (items.isNotEmpty) {
                      return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Tarefa_Card tarefa = items[index];
                            return tarefa;
                          });
                    }
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // não implementado em vídeo por descuido meu, desculpem.
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // essa linha de layout deixa o conteudo totalmente centralizado.
                      children: const [
                        Icon(
                          Icons.error_outline,
                          size: 128,
                        ),
                        Text(
                          'Não há nenhuma Tarefa',
                          style: TextStyle(fontSize: 32),
                        ),
                      ],
                    ));
                  }
                  return const Text('Erro ao carregar tarefas');
              }
            }),
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
}
