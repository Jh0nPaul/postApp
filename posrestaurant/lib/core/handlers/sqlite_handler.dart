import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';// Importar para Windows, Mac y Linux
import 'package:path/path.dart';
import 'dart:io'; // Para detectar plataforma
// Para detectar plataforma

class DBHelper {
  Future<Database> openDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'rest_dbsqlite.db');

    DatabaseFactory dbFactory = databaseFactory; // Por defecto, usa sqflite

    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      // Si es Windows, Linux o Mac, usa sqflite_common_ffi
      sqfliteFfiInit();
      dbFactory = databaseFactoryFfi;
    }

    return await dbFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: _onCreate,
      ),
    );
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE users (
          id INTEGER PRIMARY KEY,
          email TEXT,
          name TEXT,
          username TEXT,
          password TEXT,
          role TEXT,
          status TEXT,
          pin INTEGER,
          phone TEXT
      )''',
    );
  }
}
