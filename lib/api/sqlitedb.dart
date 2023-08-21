import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:outage/model/feeder.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqlite;

class OutageDbHelper {
  static Future<sqlite.Database> getDB() async {
    WidgetsFlutterBinding.ensureInitialized();

    return sqlite.openDatabase(
      join(await sqlite.getDatabasesPath(), 'outage.db'),
      onCreate: (db, version) {
        return db.execute(
          """CREATE TABLE feeders(
                fdr_code INTEGER PRIMARY KEY,
                fdr_loccode INTEGER,
                fdr_adm_sdn INTEGER,
                fdr_type  TEXT,
                fdr_name  TEXT,
                fdr_category  TEXT,
                fdr_cons INTEGER) 
            """,
        );
      },
      version: 1,
    );
  }

  static Future<int> insertFeeder(Feeder feeder) async {
    final db = await OutageDbHelper.getDB();

    //final data = {'title': title, 'description': descrption};
    final id = await db.insert('feeders', feeder.toJson(),
        conflictAlgorithm: sqlite.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Feeder>> getFeeders(String srch, int admSdnCode) async {
    print("getFeeders list");
    final db = await OutageDbHelper.getDB();
    print("getFeeders list 123");
    //var res =
    //  await db.rawQuery("select * from feeders where fdr_name like %$srch%");
    List<Map<String, Object?>> res;
    if (srch.isEmpty) {
      res = await db.query('feeders');
    } else {
      res = await db.rawQuery(
          "select * from feeders where fdr_name like '%$srch%' or fdr_code like '%$srch%'");
    }
    print(res);
    //res = jsonEncode(res);
    final List<Feeder> fdrList = res.map((e) => Feeder.fromJson(e)).toList();
    print(fdrList);
    return fdrList;
  }
}
