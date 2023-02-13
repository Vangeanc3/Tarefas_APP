import "package:sqflite/sqflite.dart";
import "package:path/path.dart";
import 'tarefa_dao.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), "tarefa.db");
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(TarefaDao.tableSql);
    },
    version: 1,
  );
}
