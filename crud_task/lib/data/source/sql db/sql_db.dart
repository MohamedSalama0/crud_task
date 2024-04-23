import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?>? get db async {
    if (_db == null) {
      _db = await initDb();
      return _db;
    } else {
      return _db;
    }
  }

  Future<Database> initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'branches.db');
    Database branchesDb = await openDatabase(path, onCreate: _onCreate,version: 1);
    return branchesDb;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE "branches" (
      "id" INTEGER PRIMARY KEY NOT NULL,
      "custom_no" INTEGER,
      "arabic_name" TEXT,
      "arabic_description" TEXT,
      "english_name" TEXT,
      "english_description" TEXT,
      "note" TEXT,
      "address" TEXT
    )
    ''');
    print('===== DATABASE IS CREATED =====');
  }

  Future<int> insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }
 Future<List<Map>> readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }


  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }
}
