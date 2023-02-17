import 'package:sqflite/sqflite.dart';
import 'package:tarefas_app/components/tarefa_card.dart';
import 'package:tarefas_app/models/tarefa.dart';
import 'database.dart';

class TarefaDao {
  static const String tableSql = 'CREATE TABLE $_nomeTabela('
      '$_nome TEXT,'
      '$_dificuldade INTEGER,'
      '$_imagem TEXT)';

  static const String _nomeTabela = 'tarefaTable';
  static const String _nome = 'nome';
  static const String _dificuldade = 'dificuldade';
  static const String _imagem = 'imagem';

  Map<String, dynamic> toMap(Tarefa_Card tarefa) {
    print('Convertendo to Map: ');
    final Map<String, dynamic> mapaDeTarefas = Map();
    mapaDeTarefas[_nome] = tarefa.tarefa.titulo;
    mapaDeTarefas[_dificuldade] = tarefa.tarefa.dificuldade;
    mapaDeTarefas[_imagem] = tarefa.tarefa.urlFoto;
    print('Mapa de Tarefas: $mapaDeTarefas');
    return mapaDeTarefas;
  }

  List<Tarefa_Card> toList(List<Map<String, dynamic>> mapaDeTarefas) {
    print('Convertendo to List:');
    final List<Tarefa_Card> tarefas = [];
    for (Map<String, dynamic> linha in mapaDeTarefas) {
      final Tarefa_Card tarefa = Tarefa_Card(
        Tarefa(
            titulo: linha[_nome],
            dificuldade: linha[_dificuldade],
            urlFoto: linha[_imagem]),
      );
    tarefas.add(tarefa);
    }
    print('Lista de Tarefas: ${tarefas.toString()}');
    return tarefas;
  }

  Future<bool> save(Tarefa_Card tarefa) async {
    print('Iniciando o save: ');
    final Database bancoDeDados = await getDatabase();
    var itemExiste = await find(tarefa.tarefa.titulo);
    Map<String, dynamic> taskMap = toMap(tarefa);
    if (itemExiste.isEmpty) {
      print('a Tarefa não Existia.');
      await bancoDeDados.insert(_nomeTabela, taskMap);
      return true;
    } else {
      print('a Tarefa existia!');
      await bancoDeDados.update(
        _nomeTabela,
        taskMap,
        where: '$_nome = ?',
        whereArgs: [tarefa.tarefa.titulo],
      );
      return false;
    }
  }

  Future<List<Tarefa_Card>> findAll() async {
    print('Acessando o findAll: ');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_nomeTabela);
    print('Procurando dados no banco de dados... encontrado: $result');
    return toList(result);
  }

  Future<List<Tarefa_Card>> find(String nomeDaTarefa) async {
    print('Acessando find: ');
    final Database bancoDeDados = await getDatabase();
    print('Procurando tarefa com o nome: ${nomeDaTarefa}');
    final List<Map<String, dynamic>> result = await bancoDeDados
        .query(_nomeTabela, where: '$_nome = ?', whereArgs: [nomeDaTarefa]);
    print('Tarefa encontrada: ${toList(result)}');

    return toList(result);
  }

  delete(String nomeDaTarefa) async {
    print('Deletando tarefa: $nomeDaTarefa');
    final Database bancoDeDados = await getDatabase();
    return await bancoDeDados.delete(
      _nomeTabela,
      where: '$_nome = ?',
      whereArgs: [nomeDaTarefa],
    );
  }
}
