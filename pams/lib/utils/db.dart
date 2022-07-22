import 'package:sqflite/sqflite.dart';

class PamsDatabase {
  static Future<Database> init() async {
    var db = await openDatabase('pamsDatabase.db', version: 1, onCreate: (Database db, int version) async {
      await db.execute("""CREATE TABLE 
        post_http (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, route VARCHAR NULL, body VARCHAR NULL, params VARCHAR NULL, formdata DOUBLE NULL, formEncoded BOOLEAN NULL, token VARCHAR NULL, category VARCHAR NULL)""");
    });
    return db;
  }

  static Future<void> insert(Future<Database> db, String route, dynamic body, {Map<String, dynamic>? params, bool formdata = false, bool formEncoded = false, dynamic token, required String category}) async {
    db.then(
      (database) async => await database.rawInsert('INSERT INTO post_http(route, body, params, formdata, formEncoded, token, category) VALUES("$route", "$body", "$params", "$formdata", "$formEncoded", "$token", "$category")'),
    );
  }

  static Future fetch(Future<Database> db, String? category) async {
    var _db = await db;
    var _result;
    if (category == null)
      _result = await _db.rawQuery("SELECT * FROM post_http");
    else
      _result = await _db.rawQuery("SELECT * FROM post_http WHERE category = '$category'");
    return _result;
  }
}
