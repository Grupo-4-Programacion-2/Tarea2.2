import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'personas.db'),
    onCreate: (db, version){
      return db.execute(
        "CREATE TABLE personas (id, INTEGER PRIMARY KEY, nombre TEXT, descripcion TEXT, firma TEXT)"
      );
    }
    );
  }
}