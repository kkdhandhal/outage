import 'package:flutter/material.dart';
import 'package:outage/api/sqlitedb.dart';
import 'package:outage/model/feeder.dart';

class SQLiteAddFeeder extends StatefulWidget {
  const SQLiteAddFeeder(
      {super.key, required this.fdrList, required this.onSubmit});
  final List<Feeder> fdrList;
  final Function(int responce) onSubmit;

  @override
  State<SQLiteAddFeeder> createState() => _SQLiteAddFeederState();
}

class _SQLiteAddFeederState extends State<SQLiteAddFeeder> {
  @override
  Widget build(BuildContext context) {
    int count = 0;
    for (var e in widget.fdrList) {
      // final fdr = rlmfeeder(e.fdr_code, e.fdr_adm_sdn, e.fdr_loccode,
      //     e.fdr_type, e.fdr_name, e.fdr_category, e.fdr_cons);

      final fdr = Feeder(
          // fdr_loccode: e.fdr_loccode,
          // fdr_adm_sdn: e.fdr_adm_sdn,
          FeederCode: e.FeederCode,
          // fdr_type: e.fdr_type,
          FeederName: e.FeederName,
          FeederCategory: e.FeederCategory,
          fdr_cons: e.fdr_cons);
      //RealmResults<rlmfeeder> fdrall = realm.all();
      OutageDbHelper.insertFeeder(fdr).then((value) {
        setState(() {
          count++;
        });
      });
    }
    widget.onSubmit(1);
    return Text("$count Feeder inserted.. ");
  }
}
