import 'package:sqflite/sqflite.dart';

class PamsDatabase {
  static Future<Database> init() async {
    var db = await openDatabase('pamsDatabase.db', version: 1, onCreate: (Database db, int version) async {
      await db.execute("""CREATE TABLE 
        post_http (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, route VARCHAR NULL, params VARCHAR NULL, formdata DOUBLE NULL, formEncoded BOOLEAN NULL, token VARCHAR NULL, category VARCHAR NULL)""");
      await db.execute("""CREATE TABLE 
        ClientLocationData (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, data_id VARCHAR NULL, client_id VARCHAR NULL, name VARCHAR NULL, description VARCHAR NULL)""");
      await db.execute("""CREATE TABLE 
        DPRTestTemplateData (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, data_id VARCHAR NULL, samplePtId VARCHAR NULL, DPRFieldId VARCHAR NULL, Latitude VARCHAR NULL, DPRTemplates VARCHAR NULL, Picture VARCHAR NULL)""");
      await db.execute("""CREATE TABLE 
        FMENVTestTemplateData (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, data_id VARCHAR NULL, samplePtId VARCHAR NULL, FMENVFieldId VARCHAR NULL, Latitude VARCHAR NULL, FMENVTemplates VARCHAR NULL, Picture VARCHAR NULL)""");
      await db.execute("""CREATE TABLE 
        NESREATestTemplateData (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, data_id VARCHAR NULL, samplePtId VARCHAR NULL, NESREAFieldId VARCHAR NULL, Latitude VARCHAR NULL, NESREATemplates VARCHAR NULL, Picture VARCHAR NULL)""");
    });
    return db;
  }

  static Future<void> insert(Future<Database> db, String route, {Map<String, dynamic>? params, bool formdata = false, bool formEncoded = false, dynamic token, required String category}) async {
    db.then(
      (database) async => await database.rawInsert('INSERT INTO post_http(route, body, params, formdata, formEncoded, token, category) VALUES("$route", "$params", "$formdata", "$formEncoded", "$token", "$category")'),
    );
  }

  static Future<List<Map<String, dynamic>>> fetch(Future<Database> db, String? category) async {
    var _db = await db;
    var _result;
    if (category == null)
      _result = await _db.rawQuery("SELECT * FROM post_http");
    else
      _result = await _db.rawQuery("SELECT * FROM post_http WHERE category = '$category'");
    return _result;
  }
}

class PamsDatabaseData extends PamsDatabase {
  static Future<void> insertClientLocationData(Future<Database> db, Map<String, dynamic> data) async {
    db.then(
      (database) async => await database.rawInsert('INSERT INTO ClientLocationData(route, body, params, formdata, formEncoded, token, category) VALUES("$route", "$params", "$formdata", "$formEncoded", "$token", "$category")'),
    );
  }
}
