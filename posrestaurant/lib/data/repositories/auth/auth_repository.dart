 import 'package:posrestaurant/core/database/auth/database_helper.dart';

class AuthRepositoy {
  ///inteciacion de la base de datos
  final DataBaseHelper _dbHelper = DataBaseHelper();

  Future<bool> login(String userName, String password) async {
    final user = await _dbHelper.getUsers(userName);
    if( user != null && user['password'] == password) {
      return true;
    } return false;
  }

  Future<bool> register(
      String email,
      String userName,
      String fullName,
      String password,
      int  securityPin
      ) async {
    try{
      await _dbHelper.insertUser(email, userName,fullName, password, securityPin);
      return  true;
    } catch (e){
      return false;
    }
  }


 }