import 'package:flutter/material.dart';
import 'package:tarefas_app/data/tarefa_dao.dart';
import '../models/tarefa.dart';
import 'dificuldade.dart';

class Tarefa_Card extends StatefulWidget {
  Tarefa tarefa;

  Tarefa_Card(this.tarefa, {super.key});

  int nivel = 0;

  @override
  State<Tarefa_Card> createState() => _Tarefa_CardState();
}

class _Tarefa_CardState extends State<Tarefa_Card> {
  bool assetsOuNetwork() {
    if (widget.tarefa.urlFoto.contains('http')) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Stack(children: [
        Container(
          height: 140,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(4)),
        ),
        Column(
          children: [
            Container(
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.black26,
                      width: 72,
                      height: 100,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: assetsOuNetwork()
                              ? Image.asset(
                                  (widget.tarefa.urlFoto != "")
                                      ? widget.tarefa.urlFoto
                                      : "assets/images/nophoto.png",
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container();
                                  },
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  (widget.tarefa.urlFoto != "")
                                      ? widget.tarefa.urlFoto
                                      : "assets/images/nophoto.png",
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container();
                                  },
                                  fit: BoxFit.cover,
                                )),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 200,
                            child: Text(widget.tarefa.titulo,
                                style: TextStyle(
                                    fontSize: 20,
                                    overflow: TextOverflow.ellipsis))),
                        Dificuldade(
                          dificuldadeLevel: widget.tarefa.dificuldade,
                        )
                      ],
                    ),
                    ElevatedButton(
                        onLongPress: () {
                          TarefaDao().delete(widget.tarefa.titulo);
                        },
                        onPressed: () => setState(() {
                              widget.nivel++;
                            }),
                        child: Icon(Icons.arrow_drop_up))
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 225,
                    child: LinearProgressIndicator(
                      color: Colors.white,
                      value: (widget.tarefa.dificuldade >= 1)
                          ? ((widget.nivel / widget.tarefa.dificuldade) / 10)
                          : 1,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text("Nivel: ${widget.nivel}",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            )
          ],
        ),
      ]),
    );
  }
}
