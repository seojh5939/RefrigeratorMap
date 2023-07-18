import 'dart:async';

import 'package:path/path.dart';
import 'package:refrigerator_map/data/model/checklist.dart';
import 'package:refrigerator_map/data/model/diet.dart';
import 'package:refrigerator_map/data/model/muckit_list.dart';
import 'package:refrigerator_map/data/model/refrigerator.dart';
import 'package:refrigerator_map/data/model/shopping.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final _helper = DBHelper._internal();

  DBHelper._internal();

  static DBHelper get instance => _helper;
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database as Database;
    _database = await initDB();
    return _database as Database;
  }

  initDB() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'dev.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${Refrigerator.tableName} (
        ${RefrigeratorField.id} INTEGER PRIMARY KEY autoincrement, 
        ${RefrigeratorField.name} TEXT not null, 
        ${RefrigeratorField.count} INTEGER not null, 
        ${RefrigeratorField.regdate} TEXT not null, 
        ${RefrigeratorField.expdate} TEXT not null, 
        ${RefrigeratorField.position} TEXT not null, 
        ${RefrigeratorField.memo} TEXT
        )
    ''');
    await db.execute('''
      CREATE TABLE ${Shopping.tableName} (
        ${ShoppingField.id} INTEGER PRIMARY KEY autoincrement, 
        ${ShoppingField.title} TEXT not null, 
        ${ShoppingField.regdate} TEXT not null, 
        ${ShoppingField.isdone} INTEGER not null
        )
    ''');
    await db.execute('''
      CREATE TABLE ${CheckList.tableName} (
        ${CheckListField.id} INTEGER PRIMARY KEY autoincrement, 
        ${CheckListField.title} TEXT not null, 
        ${CheckListField.content} TEXT not null, 
        ${CheckListField.amount} INTEGER not null, 
        ${CheckListField.ischeck} INTEGER not null
        )
    ''');
    await db.execute('''
      CREATE TABLE ${Diet.tableName} (
        ${DietField.id} INTEGER PRIMARY KEY autoincrement, 
        ${DietField.name} TEXT not null, 
        ${DietField.date} TEXT not null, 
        ${DietField.mealtime} TEXT not null, 
        ${DietField.memo} TEXT
        )
    ''');
    await db.execute('''
      CREATE TABLE ${MuckitList.tableName} (
        ${MuckitListField.id} INTEGER PRIMARY KEY autoincrement, 
        ${MuckitListField.name} TEXT not null, 
        ${MuckitListField.date} TEXT not null
        )
    ''');
  }
}
