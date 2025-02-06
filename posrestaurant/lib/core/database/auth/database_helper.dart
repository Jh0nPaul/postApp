import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DataBaseHelper {
  static Database? _database;
  // init database
  Future<Database> get database async {
    if( _database != null  ) return _database!;
    _database = await _initDB();
    return _database!;
}

Future<Database> _initDB() async {
    String path = join ( await getDatabasesPath(), 'user.db' );
    return await openDatabase(
      path,
      version: 1,
      onCreate: ( db, version ){
        return db.execute(
          'CREATE TABLE users('
              'id INTEGER PRIMARY KEY,'
              'email TEXT,'
              'username TEXT,'
              'fullname TEXT,'
              'security_pin INTEGER,'
              'password TEXT,)'
        );
      }
    );
  }

  Future<int> insertUser(
      String email, String userName,String fullName,String password,int securityPin,
      ) async {
    final db = await database;
    return await db.insert(
        'users',
        {
          'email': email,
          'username': userName,
          'fullname': fullName,
          'password': password,
          'security_pin': securityPin,
        },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getUsers(String userName) async {
    final db = await database;
    final List<Map<String, dynamic >> users = await db.query(
        'users',
        where: 'username = ?',
        whereArgs: [userName],
    );
    return users.isEmpty ?  users.first :null;
  }

}