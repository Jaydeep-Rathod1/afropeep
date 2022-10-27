import 'dart:io';

import 'package:afropeep/models/user_models/log.dart';
import 'package:afropeep/provider/log_interface.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteMethods implements LogInterface {
  Database _db;

  String databaseName = "";

  String tableName = "Call_Logs";

  // columns
  String id = 'log_id';
  String callerid = 'callerid';
  String callerName = 'caller_name';
  String callerPic = 'caller_pic';
  String receiverId = 'receiverId';
  String receiverName = 'receiver_name';
  String receiverPic = 'receiver_pic';
  String callStatus = 'call_status';
  String timestamp = 'timestamp';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    print("db was null, now awaiting it");
    _db = await init();
    return _db;
  }

  @override
  openDb(dbName) => (databaseName = dbName);

  @override
  init() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, databaseName);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    print("called");
    String createTableQuery =
        "CREATE TABLE $tableName ($id INTEGER PRIMARY KEY, $callerid TEXT, $callerName TEXT, $callerPic TEXT, $receiverId TEXT, $receiverName TEXT, $receiverPic TEXT, $callStatus TEXT, $timestamp TEXT)";

    await db.execute(createTableQuery);
    print("table created");
  }

  @override
  addLogs(Log log) async {
    var dbClient = await db;
    print("the log has been added in sqlite db");
    await dbClient.insert(tableName, log.toMap(log));
  }

  updateLogs(Log log) async {
    var dbClient = await db;

    await dbClient.update(
      tableName,
      log.toMap(log),
      where: '$id = ?',
      whereArgs: [log.logId],
    );
  }

  @override
  Future<List<Log>> getLogs() async {
    try {
      var dbClient = await db;

     //List<Map> maps = await dbClient.rawQuery("SELECT distinct on $id * FROM $tableName");
      List<Map> maps = await dbClient.query(
        tableName,
        groupBy: receiverId,
        columns: [
          id,
          callerName,
          callerPic,
          receiverId,
          receiverName,
          receiverPic,
          callStatus,
          timestamp,
        ],
      );

      List<Log> logList = [];

      if (maps.isNotEmpty) {
        for (Map map in maps) {
          logList.add(Log.fromMap(map));
        }
      }

      return logList;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  deleteLogs(int logId) async {
    var client = await db;
    return await client
        .delete(tableName, where: '$id = ?', whereArgs: [logId + 1]);
  }

  @override
  close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
