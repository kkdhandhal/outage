import 'package:flutter/material.dart';
import 'package:outage/api/sqlitedb.dart';
import 'package:outage/model/login/user.dart';
import 'package:outage/pages/Home.dart';
import 'package:outage/api/feeders/feederapi.dart';
import 'package:outage/model/feeder.dart';

class InitdataSQLite extends StatefulWidget {
  final Users usr;
  const InitdataSQLite({Key? key, required this.usr}) : super(key: key);

  @override
  State<InitdataSQLite> createState() => _InitdataState();
}

class _InitdataState extends State<InitdataSQLite> {
  //int fdr_sdn_code = widget.usr.usr_sdnloc;
  int curInsert = 0;
  int lstlength = 0;

  @override
  void initState() {
    super.initState();
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
        child: FutureBuilder(
          future: FeederAPI.getSDNFeeders(widget.usr.usr_id),
          builder: (context, snapshot) {
            //print("Data is $snapshot");
            int errCode = 0;
            String stsMsg = "";
            if (snapshot.hasData) {
              List<Feeder> _suggList = snapshot.data!;
              if (_suggList[0].FeederCode < 10) {
                errCode = _suggList[0].FeederCode;
                stsMsg = _suggList[0].FeederName;
              } else {
                errCode = 0;
                stsMsg = "";

                var count = 0;
                _suggList.forEach((e) {
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
                    count++;
                    print("Row inserted: $count");
                  });
                });
                // Future.delayed(Duration.zero, () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => HomePage(
                //                 usr: widget.usr,
                //               )));
                // });
              }
            }
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200,
                  width: 500,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (errCode == 0) ...[
                          const CircularProgressIndicator(),
                          Text(
                            "Preparing to insert for Subdivision ${widget.usr.usr_loccode}",
                          ),
                        ] else ...[
                          Text(
                            "Error Code is : $errCode",
                          ),
                          Text(
                            "Message is : $stsMsg",
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
