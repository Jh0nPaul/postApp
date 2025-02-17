import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posrestaurant/core/handlers/sqlite_handler.dart';

class UserCubit extends Cubit<List<Map<String,dynamic>>> {
  final DBHelper dbHelper;

  UserCubit(this.dbHelper) : super([]);

  Future<void> fetchUsers() async {
    final db = await dbHelper.openDB();
    final List<Map<String,dynamic>> users = await db.query('users');
    emit(users);
  }
}