import 'package:flutter/material.dart';
import 'package:tarefas_app/data/tarefa_dao.dart';
import 'dificuldade.dart';

class Tarefa extends StatefulWidget {
  final String texto;
  final String foto;
  final int dificuldadeLevel;

  Tarefa(this.texto, this.foto, this.dificuldadeLevel, {super.key});

  int nivel = 0;

  @override
  State<Tarefa> createState() => _TarefaState();
}

class _TarefaState extends State<Tarefa> {
 
  bool assetsOuNetwork() {
    if (widget.foto.contains('http')) {
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
                                  (widget.foto != "")
                                      ? widget.foto
                                      : "assets/images/nophoto.png",
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container();
                                  },
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  (widget.foto != "")
                                      ? widget.foto
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
                            child: Text(widget.texto,
                                style: TextStyle(
                                    fontSize: 20,
                                    overflow: TextOverflow.ellipsis))),
                        Dificuldade(
                          dificuldadeLevel: widget.dificuldadeLevel,
                        )
                      ],
                    ),
                    ElevatedButton(
                        onLongPress: () {
                          TarefaDao().delete(widget.texto);
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
                      value: (widget.dificuldadeLevel >= 1)
                          ? ((widget.nivel / widget.dificuldadeLevel) / 10)
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
