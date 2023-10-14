import 'package:flutter/material.dart';
import 'package:outage/api/sqlitedb.dart';
import 'package:outage/component/custdialog.dart';
import 'package:outage/model/login/logreqmod.dart';
import 'package:outage/model/login/user.dart';
import 'package:outage/pages/Home.dart';
import 'package:outage/api/feeders/feederapi.dart';
import 'package:outage/model/feeder.dart';
import 'package:outage/pages/LOGIN/login.dart';
import 'package:outage/utils/constants.dart';

class InitdataSQLite extends StatefulWidget {
  final Users usr;
  const InitdataSQLite({Key? key, required this.usr}) : super(key: key);

  @override
  State<InitdataSQLite> createState() => _InitdataState1();
}

class _InitdataState1 extends State<InitdataSQLite> {
  //int fdr_sdn_code = widget.usr.usr_sdnloc;
  int curInsert = 0;
  int lstlength = 0;
  int dataLength = 0;
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
      backgroundColor: appPrimaryColorLowShade,
      body: Center(
        child: FutureBuilder(
          future: FeederAPI.getSDNFeeders(widget.usr.usr_id),
          builder: (context, snapshot) {
            //print("Data is $snapshot");
            var count = 0;
            int errCode = 0;
            String stsMsg = "";
            if (snapshot.hasData) {
              try {
                List<Feeder> _suggList = snapshot.data! as List<Feeder>;
                if (_suggList[0].FeederCode < 10) {
                  errCode = _suggList[0].FeederCode;
                  stsMsg = _suggList[0].FeederName;
                } else {
                  errCode = 0;
                  stsMsg = "";
                  dataLength = _suggList.length;

                  _suggList.forEach((e) async {
                    final fdr = Feeder(
                        // fdr_loccode: e.fdr_loccode,
                        // fdr_adm_sdn: e.fdr_adm_sdn,
                        FeederCode: e.FeederCode,
                        // fdr_type: e.fdr_type,
                        FeederName: e.FeederName,
                        FeederCategory: e.FeederCategory,
                        fdr_cons: e.fdr_cons);
                    //RealmResults<rlmfeeder> fdrall = realm.all();
                    await OutageDbHelper.insertFeeder(fdr);
                    count++;
                  });
                  Future.delayed(Duration.zero, () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(
                                usr: widget.usr,
                              )),
                      ModalRoute.withName('/'),
                    );
                  });
                }
              } catch (e) {
                List<LoginResponse> apiResponse =
                    snapshot.data! as List<LoginResponse>;
                if (mounted) {
                  // showDialog(
                  //   context: context,
                  //   builder: (context) {
                  return CustDialog(
                      isConfirmDialog: false,
                      Dlg_title: "Information",
                      msg:
                          "${apiResponse[0].Status_message} \n OR \n You don't have access to Application",
                      onClose: (val) {
                        // if (mounted) {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const LoginScreen()),
                        //   );
                        // }
                      },
                      res_code: apiResponse[0].Status);
                  // },
                  // );
                }
              }
            }
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200,
                  width: 500,
                  decoration: BoxDecoration(
                      color: appPrimaryColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (errCode == 0) ...[
                          const CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            color: Colors.red,
                          ),
                          Text(
                            "Preparing data for ${widget.usr.usr_locname}",
                            style: const TextStyle(
                              color: appPrimaryTextColor,
                            ),
                          ),
                        ] else ...[
                          Text(
                            "Error Code is : $errCode",
                            style: const TextStyle(
                              color: appPrimaryTextColor,
                            ),
                          ),
                          Text(
                            "Message is : $stsMsg",
                            style: const TextStyle(
                              color: appPrimaryTextColor,
                            ),
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
