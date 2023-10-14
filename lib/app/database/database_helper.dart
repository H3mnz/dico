import 'dart:developer';
import 'dart:io';

import 'package:dico/app/models/result_model.dart';
import 'package:dico/app/utils/constants.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  static late Database _database;

  Future<Database> get database async {
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, dbName);

    if (!await databaseExists(path)) {
      // Create Database if Not Exists.
      try {
        await Directory(dirname(path)).create(recursive: true);

        ByteData data = await rootBundle.load(join("assets/db", dbName));
        List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

        await File(path).writeAsBytes(bytes, flush: true);
      } catch (e) {
        log('$e');
      }
    }
    return await openDatabase(path);
  }

  Future<List<ResultModel>> search(String keyword) async {
    Database db = await database;
    List<Map<String, dynamic>> data = await db.rawQuery(sqlQuery(keyword));
    return data.map((result) => ResultModel.fromJson(result)).toList();
  }
}
