import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:outage/api/sqlitedb.dart';
import 'package:outage/model/login/user.dart';
import 'package:outage/pages/Home.dart';
import 'package:outage/api/feeders/feederapi.dart';
import 'package:outage/model/feeder.dart';
import 'package:outage/pages/initdata/initdata_feederadd.dart';

class InitdataSQLite extends StatefulWidget {
  final Users usr;
  const InitdataSQLite({Key? key, required this.usr}) : super(key: key);

  @override
  State<InitdataSQLite> createState() => _InitdataState();
}

class _InitdataState extends State<InitdataSQLite> {
  //int fdr_sdn_code = widget.usr.usr_sdnloc;

  List<Feeder> fdrList = [];
  int fdrLen = -1;
  int count = 0;
  Future fetchFeeders() async {
    FeederAPI.getSDNFeeders(widget.usr.usr_id).then((value) {
      if (mounted) {
        setState(() {
          fdrList = value;
          fdrLen = value.length;
        });
      }
    });
  }

  Future inserFdr() async {
    for (var e in fdrList) {
      final fdr = Feeder(
          FeederCode: e.FeederCode,
          FeederName: e.FeederName,
          FeederCategory: e.FeederCategory,
          fdr_cons: e.fdr_cons);

      await OutageDbHelper.insertFeeder(fdr);
      count++;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchFeeders().then((value) {
        if (kDebugMode) {
          print("Fetch Feeder Complete...");
          inserFdr().then((value) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(
                          usr: widget.usr,
                        )));
          });
        }
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //importFeeder();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[800],
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              width: 500,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("$count feeder inserted"),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
