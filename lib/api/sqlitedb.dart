import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:outage/model/feeder.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqlite;

class OutageDbHelper {
  static Future<sqlite.Database> getDB() async {
    WidgetsFlutterBinding.ensureInitialized();

    return sqlite.openDatabase(
      join(await sqlite.getDatabasesPath(), 'outage1.db'),
      onCreate: (db, version) {
        return db.execute(
          """CREATE TABLE feeders(
                FeederCode INTEGER PRIMARY KEY,
                FeederName  TEXT,
                FeederCategory  TEXT,
                fdr_cons INTEGER) 
            """,
        );
        // return db.execute(
        //   """CREATE TABLE feeders(
        //         FeederCode INTEGER PRIMARY KEY,
        //         // fdr_loccode INTEGER,
        //         // fdr_adm_sdn INTEGER,
        //         fdr_type  TEXT,
        //         FeederName  TEXT,
        //         FeederCategory  TEXT,
        //         fdr_cons INTEGER)
        //     """,
        // );
      },
      version: 2,
    );
  }

  static Future<int> insertFeeder(Feeder feeder) async {
    final db = await OutageDbHelper.getDB();

    //final data = {'title': title, 'description': descrption};
    await db.execute("delete from feeders");
    final id = await db.insert('feeders', feeder.toJson(),
        conflictAlgorithm: sqlite.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Feeder>> getFeeders(String srch, String admSdnCode) async {
    if (kDebugMode) {
      print("getFeeders list");
    }
    final db = await OutageDbHelper.getDB();
    if (kDebugMode) {
      print("getFeeders list 123");
    }
    //var res =
    //  await db.rawQuery("select * from feeders where fdr_name like %$srch%");
    List<Map<String, Object?>> res;
    if (srch.isEmpty) {
      res = await db.query('feeders');
    } else {
      res = await db.rawQuery(
          "select * from feeders where FeederName like '%$srch%' or FeederCode like '%$srch%'");
    }
    if (kDebugMode) {
      print(res);
    }
    //res = jsonEncode(res);
    final List<Feeder> fdrList = res.map((e) => Feeder.fromJson(e)).toList();
    print(fdrList);
    return fdrList;
  }
}
