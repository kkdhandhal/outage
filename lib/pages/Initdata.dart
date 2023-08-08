import 'package:flutter/material.dart';
import 'package:outage/pages/Home.dart';
import 'package:realm/realm.dart';
import '../api/api.dart';
import '../model/feeder.dart';
import '../model/rlmfeeder.dart';

class Initdata extends StatefulWidget {
  const Initdata({Key? key}) : super(key: key);

  @override
  State<Initdata> createState() => _InitdataState();
}

class _InitdataState extends State<Initdata> {
  final int fdr_sdn_code = 382134;
  int curInsert = 0;
  int lstlength = 0;

  void insertFeeder() async {
    // realm.beginTransaction();
    Future<List<Feeder>> _suggList = API.getSDNFeeders(fdr_sdn_code);
    List<Feeder> suggList;

    //suggList = (await _suggList);
    // final realm = Realm(Configuration.local([rlmfeeder.schema]));
    _suggList.then(
      (value) {
        final realm = Realm(Configuration.local([rlmfeeder.schema]));
        var trx = realm.beginWrite();
        realm.deleteAll<rlmfeeder>();
        trx.commit();

        suggList = value;
        setState(() {
          lstlength = suggList.length;
        });
        if (suggList.length > 0) {
          suggList.forEach((e) {
            //print("Function start....");
            final fdr = rlmfeeder(e.fdr_code, e.fdr_adm_sdn, e.fdr_loccode,
                e.fdr_type, e.fdr_name, e.fdr_category);
            print('Two second has passed.'); // Prints after 1 second.
            realm.write(() => realm.add(fdr));
            setState(() {
              curInsert = curInsert + 1;
            });
            print("row inserted: $curInsert");
          });
          realm.close();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomePage()));
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Future.delayed(Duration(seconds: 3), () => insertFeeder());
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: Center(
        child: FutureBuilder(
          future: API.getSDNFeeders(fdr_sdn_code),
          builder: (context, snapshot) {
            //print("Data is $snapshot");
            if (snapshot.hasData) {
              var count = 0;

              List<Feeder> _suggList = snapshot.data!;
              var totfdr = _suggList.length;
              final realm = Realm(Configuration.local([rlmfeeder.schema]));
              var trx = realm.beginWrite();
              realm.deleteAll<rlmfeeder>();
              trx.commit();
              _suggList.forEach((e) {
                final fdr = rlmfeeder(e.fdr_code, e.fdr_adm_sdn, e.fdr_loccode,
                    e.fdr_type, e.fdr_name, e.fdr_category);
                //RealmResults<rlmfeeder> fdrall = realm.all();

                realm.write(() => realm.add(fdr));
                count++;
              });
              // _suggList.forEach((e) {
              // var fdr = rlmfeeder(e.fdr_code, e.fdr_adm_sdn, e.fdr_loccode,
              //     e.fdr_type, e.fdr_name, e.fdr_category);
              // realm.write(() {
              //   realm.add(fdr);
              // })

              realm.close();
              Future.delayed(Duration.zero, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
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
                      children: const [
                        CircularProgressIndicator(),
                        Text("Preparing to insert"),
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
