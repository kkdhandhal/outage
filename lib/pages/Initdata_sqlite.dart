import 'package:flutter/material.dart';
import 'package:outage/api/sqlitedb.dart';
import 'package:outage/model/login/user.dart';
import 'package:outage/pages/Home.dart';
import '../api/api.dart';
import '../model/feeder.dart';

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
          future: API.getSDNFeeders(widget.usr.usr_loccode),
          builder: (context, snapshot) {
            //print("Data is $snapshot");
            if (snapshot.hasData) {
              List<Feeder> _suggList = snapshot.data!;
              var count = 0;
              _suggList.forEach((e) {
                // final fdr = rlmfeeder(e.fdr_code, e.fdr_adm_sdn, e.fdr_loccode,
                //     e.fdr_type, e.fdr_name, e.fdr_category, e.fdr_cons);

                final fdr = Feeder(
                    fdr_loccode: e.fdr_loccode,
                    fdr_adm_sdn: e.fdr_adm_sdn,
                    fdr_code: e.fdr_code,
                    fdr_type: e.fdr_type,
                    fdr_name: e.fdr_name,
                    fdr_category: e.fdr_category,
                    fdr_cons: e.fdr_cons);
                //RealmResults<rlmfeeder> fdrall = realm.all();
                OutageDbHelper.insertFeeder(fdr);
                count++;
                print("Row inserted: $count");
              });
              // _suggList.forEach((e) {
              // var fdr = rlmfeeder(e.fdr_code, e.fdr_adm_sdn, e.fdr_loccode,
              //     e.fdr_type, e.fdr_name, e.fdr_category);
              // realm.write(() {
              //   realm.add(fdr);
              // })

              Future.delayed(Duration.zero, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(
                              usr: widget.usr,
                            )));
              });

              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (context) => HomePage()));
              //return Text("Total Feeder $count inserted ");
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
                        CircularProgressIndicator(),
                        Text(
                          "Preparing to insert for Subdivision ${widget.usr.usr_loccode}",
                        ),
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
