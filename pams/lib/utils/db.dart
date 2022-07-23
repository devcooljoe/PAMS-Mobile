import 'package:sqflite/sqflite.dart';

class PamsDatabase {
  static Future<Database> init() async {
    var db = await openDatabase(
      'pamsDatabase.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute("""CREATE TABLE 
        PostHttp (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, route VARCHAR NULL, params VARCHAR NULL, formdata DOUBLE NULL, formEncoded BOOLEAN NULL, token VARCHAR NULL, category VARCHAR NULL)""");
        await db.execute("""CREATE TABLE 
        ClientLocationData (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, dataId VARCHAR NULL, clientId VARCHAR NULL, name VARCHAR NULL, description VARCHAR NULL)""");
        await db.execute("""CREATE TABLE 
        DPRTestTemplateData (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, dataId VARCHAR NULL, samplePtId VARCHAR NULL, DPRFieldId VARCHAR NULL, Latitude VARCHAR NULL, Longitude VARCHAR NULL, DPRTemplates VARCHAR NULL, Picture VARCHAR NULL)""");
        await db.execute("""CREATE TABLE 
        FMENVTestTemplateData (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, dataId VARCHAR NULL, samplePtId VARCHAR NULL, FMENVFieldId VARCHAR NULL, Latitude VARCHAR NULL, FMENVTemplates VARCHAR NULL, Picture VARCHAR NULL)""");
        await db.execute("""CREATE TABLE 
        NESREATestTemplateData (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, dataId VARCHAR NULL, samplePtId VARCHAR NULL, NESREAFieldId VARCHAR NULL, Latitude VARCHAR NULL, NESREATemplates VARCHAR NULL, Picture VARCHAR NULL)""");
      },
    );
    return db;
  }

  static Future<void> insert(Future<Database> db, String route, Map<String, dynamic> body, {Map<String, dynamic>? params, bool formdata = false, bool formEncoded = false, dynamic token, required String category}) async {
    var _db = await db;
    int _id;
    _id = await _db.rawInsert('INSERT INTO PostHttp(route, params, formdata, formEncoded, token, category) VALUES("$route", "$params", "$formdata", "$formEncoded", "$token", "$category")');
    switch (category) {
      case 'ClientLocation':
        await ClientLocationData.insert(_id, body);
        break;
      case 'DPRTestTemplate':
        await DPRTestTemplateData.insert(_id, body);
        break;
      case 'FMENVTestTemplate':
        await FMENVTestTemplateData.insert(_id, body);
        break;
      case 'NESREATestTemplate':
        await NESREATestTemplateData.insert(_id, body);
        break;
      default:
        await ClientLocationData.insert(_id, body);
    }
  }

  static Future<List<Map<String, dynamic>>> fetch(Future<Database> db, String? category) async {
    var _db = await db;
    var _result;
    if (category == null)
      _result = await _db.rawQuery("SELECT * FROM PostHttp");
    else
      _result = await _db.rawQuery("SELECT * FROM PostHttp WHERE category = '$category'");
    return _result;
  }
}

class ClientLocationData extends PamsDatabase {
  static var db = PamsDatabase.init();
  static Future insert(int dataId, Map<String, dynamic> data) async {
    db.then(
      (database) async => await database.rawInsert('INSERT INTO ClientLocationData(dataId, clientId, name, description) VALUES("$dataId", "${data['clientId']}", "${data['name']}", "${data['description']}")'),
    );
  }

  static Future<List<Map<String, dynamic>>> fetch(String dataId) async {
    var _db = await db;
    var _result;
    _result = await _db.rawQuery("SELECT * FROM ClientLocationData WHERE dataId = '$dataId'");
    return _result;
  }
}

class DPRTestTemplateData extends PamsDatabase {
  static var db = PamsDatabase.init();
  static Future insert(int dataId, Map<String, dynamic> data) async {
    db.then(
      (database) async => await database.rawInsert('INSERT INTO DPRTestTemplateData(dataId, samplePtId, DPRFieldId, Latitude, Longitude, DPRTemplates, Picture) VALUES("$dataId", "${data['samplePtId']}", "${data['DPRFieldId']}", "${data['Latitude']}", "${data['Longitude']}", "${data['DPRTemplates']}", "${data['Picture']}")'),
    );
  }

  static Future<List<Map<String, dynamic>>> fetch(String dataId) async {
    var _db = await db;
    var _result;
    _result = await _db.rawQuery("SELECT * FROM DPRTestTemplateData WHERE dataId = '$dataId'");
    return _result;
  }
}

class FMENVTestTemplateData extends PamsDatabase {
  static var db = PamsDatabase.init();
  static Future insert(int dataId, Map<String, dynamic> data) async {
    db.then(
      (database) async => await database.rawInsert('INSERT INTO FMENVTestTemplateData(dataId, samplePtId, FMENVFieldId, Latitude, Longitude, FMENVTemplates, Picture) VALUES("$dataId", "${data['samplePtId']}", "${data['FMENVFieldId']}", "${data['Latitude']}", "${data['Longitude']}", "${data['FMENVTemplates']}", "${data['Picture']}")'),
    );
  }

  static Future<List<Map<String, dynamic>>> fetch(String dataId) async {
    var _db = await db;
    var _result;
    _result = await _db.rawQuery("SELECT * FROM FMENVTestTemplateData WHERE dataId = '$dataId'");
    return _result;
  }
}

class NESREATestTemplateData extends PamsDatabase {
  static var db = PamsDatabase.init();
  static Future insert(int dataId, Map<String, dynamic> data) async {
    db.then(
      (database) async => await database.rawInsert('INSERT INTO NESREATestTemplateData(dataId, samplePtId, NESREAFieldId, Latitude, Longitude, NESREATemplates, Picture) VALUES("$dataId", "${data['samplePtId']}", "${data['NESREAFieldId']}", "${data['Latitude']}", "${data['Longitude']}", "${data['NESREATemplates']}", "${data['Picture']}")'),
    );
  }

  static Future<List<Map<String, dynamic>>> fetch(String dataId) async {
    var _db = await db;
    var _result;
    _result = await _db.rawQuery("SELECT * FROM NESREATestTemplateData WHERE dataId = '$dataId'");
    return _result;
  }
}
