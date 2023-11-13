import 'package:sqflite/sqflite.dart' as sql;
import 'package:tarea2_2/personas.dart';

class DB {
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""CREATE TABLE personas(
     id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
     nombres TEXT,
     desc TEXT,
     foto TEXT ) """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase("personas.db", version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTable(database);
      }
    );
  }


}