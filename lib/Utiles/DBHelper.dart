import 'dart:io';
import 'package:db/Screen/Home/Model/HomeModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static DBHelper dbHelper = DBHelper._();

  DBHelper._();

  Database? database;

  Future<Database> checkDB() async {
    if (database != null) {
      return database!;
    } else {
      return await initDB();
    }
  }

  Future<Database> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();

    String path = join(
      directory.path,
      "todo.db",
    );

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE `todo` (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, std INTEGER, mobile TEXT)";

        db.execute(query);
      },
    );
  }

  Future<void> insertData({
    required HomeModel h1,
  }) async {
    database = await checkDB();

    await database!.insert(
      'todo',
      {
        "name": h1.name,
        "std": h1.std,
        "mobile": h1.mobile,
      },
    );
  }

  Future<void> updateData({
    required HomeModel h1,
  }) async {

    print(h1.id);
    database = await checkDB();

    database!.update(
      "todo",
      {
        "name": h1.name,
        "std": h1.std,
        "mobile": h1.mobile,
      },
      where: "id=?",
      whereArgs: [h1.id],
    );
  }

  Future<List<Map>> readData() async {
    database = await checkDB();

    String query = "SELECT * FROM `todo`";

    Future<List<Map>> todoData = database!.rawQuery(query);

    return todoData;
  }

  Future<void> deleteData({
    required HomeModel h1,
  }) async {
    await checkDB();

    await database!.delete(
      'todo',
      whereArgs: [h1.id],
      where: "id=?",
    );
  }
}
