import 'package:sqflite/sqflite.dart';
import 'package:tarefas_app/components/tarefas.dart';
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

  Map<String, dynamic> toMap(Tarefa tarefa) {
    print('Convertendo to Map: ');
    final Map<String, dynamic> mapaDeTarefas = Map();
    mapaDeTarefas[_nome] = tarefa.texto;
    mapaDeTarefas[_dificuldade] = tarefa.dificuldadeLevel;
    mapaDeTarefas[_imagem] = tarefa.foto;
    print('Mapa de Tarefas: $mapaDeTarefas');
    return mapaDeTarefas;
  }

  List<Tarefa> toList(List<Map<String, dynamic>> mapaDeTarefas) {
    print('Convertendo to List:');
    final List<Tarefa> tarefas = [];
    for (Map<String, dynamic> linha in mapaDeTarefas) {
      final Tarefa tarefa = Tarefa(
        linha[_nome],
        linha[_imagem],
        linha[_dificuldade],
      );
      tarefas.add(tarefa);
    }
    print('Lista de Tarefas: ${tarefas.toString()}');
    return tarefas;
  }

  Future<bool> save(Tarefa tarefa) async {
    print('Iniciando o save: ');
    final Database bancoDeDados = await getDatabase();
    var itemExiste = await find(tarefa.texto);
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
        whereArgs: [tarefa.texto],
      );
      return false;
    }
  }

  Future<List<Tarefa>> findAll() async {
    print('Acessando o findAll: ');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_nomeTabela);
    print('Procurando dados no banco de dados... encontrado: $result');
    return toList(result);
  }

  Future<List<Tarefa>> find(String nomeDaTarefa) async {
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
