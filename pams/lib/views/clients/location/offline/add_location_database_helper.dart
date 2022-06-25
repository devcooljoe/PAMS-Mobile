import 'dart:io';

import 'package:pams/models/offline_location_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocationDataBaseHelper {
  LocationDataBaseHelper._privateConstructor();
  static final LocationDataBaseHelper instance =
      LocationDataBaseHelper._privateConstructor();
  Database? _database;

  Future<Database> get database async => _database ??= await initDataBase();

  Future<Database> initDataBase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'augustus.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //create database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE augustus(
      id INTEGER PRIMARY KEY,
      name TEXT,
      description TEXT,
      clientId TEXT,
    )
    ''');
  }

  //get microbial data list
  Future<List<AddOfflineLocation>> getOfflineLocation() async {
    Database db = await instance.database;
    var microbial = await db.query(
      'augustus',
    );
    List<AddOfflineLocation> dataList = microbial.isNotEmpty
        ? microbial.map((e) => AddOfflineLocation.fromMap(e)).toList()
        : [];
    return dataList;
  }

  //add item to microbial list
  Future<int> add(AddOfflineLocation microBial) async {
    Database db = await instance.database;
    return await db.insert('augustus', microBial.toMap());
  }

  //remove item from microbial list
  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('augustus', where: 'id = ?', whereArgs: [id]);
  }

  //update item on the microbial list
  Future<int> updateItem(AddOfflineLocation microbial) async {
    Database db = await instance.database;
    return await db.update('augustus', microbial.toMap(),
        where: 'id = ?', whereArgs: [microbial.id]);
  }
}
