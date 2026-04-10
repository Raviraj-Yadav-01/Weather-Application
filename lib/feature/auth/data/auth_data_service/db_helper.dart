import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather_app/core/constants/app_constants.dart';
import 'package:weather_app/feature/auth/data/model/user_moder.dart';

class DBHelper{

  DBHelper._();

  static DBHelper getInstance(){
    return DBHelper._();
  }

  Database? myDatabase;

  Future<Database> initDB()async{
    myDatabase ?? await openDB();
    return myDatabase!;
  }


  Future<Database> openDB()async{

    Directory appDocDir = await getApplicationDocumentsDirectory();

    String dbPath = join(appDocDir.path,AppConstants.dbName);

    return await openDatabase(dbPath, version:1, onCreate: (db, version){

      db.execute("create table ${AppConstants.userTable}("
          "${AppConstants.userId}integer primary key autoincrement ,"
          "${AppConstants.userName}text,"
          "${AppConstants.userEmail}text,"
          "${AppConstants.userMobileNumber}text,"
          "${AppConstants.userPassword}text,"
      );
    });
  }

  ///Register user Queries
  /// 1 some error occur
  /// 2 user already exist
  /// 3 user created
  Future<int> createUser({required UserModel newUser}) async {
    var db = await initDB();

    if (!await checkIfUserAlreadyExists(email: newUser.email)) {
      int rowEffected = await db.insert(
          AppConstants.userTable, newUser.toMap());
      return rowEffected > 0 ? 3 : 1;
    } else {
      return 2;
    }
  }

  Future<bool> checkIfUserAlreadyExists({required String email}) async {
    var db = await initDB();
    List<Map<String, dynamic>> users = await db.query(AppConstants.userTable,
      where: "${AppConstants.userEmail} = ?",
      whereArgs: [email],
    );
    return users.isNotEmpty;
  }


  //User Authentication Queries
  // 1 login success
  // 2 invalid email
  // 3 invalid password
  Future<int> authenticateUser({required String email, required String pass}) async {
    var db = await initDB();

    if (await checkIfUserAlreadyExists(email: email)) {
      List<Map<String, dynamic>> users = await db.query(AppConstants.userTable,
        where: "${AppConstants.userEmail} = ? AND ${AppConstants.userPassword} = ?",
        whereArgs: [email, pass],
      );

      if (users.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt(
            AppConstants.prefs_user_id, users[0][AppConstants.userId]);
        return 1;
      } else {
        return 3;
      }
    } else {
      //invalid email
      return 2;
    }
  }

}