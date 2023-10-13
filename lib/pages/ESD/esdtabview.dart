import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:outage/component/custdialog.dart';
import 'package:outage/model/feeder.dart';
import 'package:outage/model/intruption/esd_model.dart';
import 'package:outage/model/login/logreqmod.dart';
import 'package:outage/model/login/user.dart';
import 'package:outage/pages/ESD/esdscreen.dart';
//import 'package:outage/pages/esdscreen.dart';
import 'package:outage/api/intruptions/esdapi.dart';
import 'package:outage/pages/ESD/tabitem.dart';

// Future<void> _showInfoDialog(
//     BuildContext context, final String dbmsg, int dbcode) {
//   return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Information - $dbcode"),
//           content: Text(dbmsg),
//           actions: [
//             TextButton(
//               style: TextButton.styleFrom(
//                 textStyle: Theme.of(context).textTheme.labelLarge,
//               ),
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       });
// }

class EsdTabView extends StatefulWidget {
  final Users usr;
  final Feeder feeder;
  const EsdTabView({
    Key? key,
    required this.usr,
    required this.feeder,
  }) : super(key: key);

  @override
  State<EsdTabView> createState() => _EsdtabviewState();
}

class _EsdtabviewState extends State<EsdTabView> {
  //late Feeder _sel_feeder = Feeder.initFeeder();

  @override
  void initState() {
    super.initState();
  }

  Widget getData() {
    if (kDebugMode) {
      print('Selected feeder code is ${widget.feeder.FeederCode.toString()}');
    }
    return FutureBuilder<List<dynamic>>(
        // future: ESDAPI.fetchESD(widget.feeder.FeederCode),
        future: ESDAPI.fetchESD(widget.usr.usr_id),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200,
                  width: 500,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircularProgressIndicator(),
                        Text(
                          "Preparing to fetch ESD data for current month",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            if (snapshot.hasData) {
              try {
                List<ESDList> tmpEsd = snapshot.data! as List<ESDList>;
                return TabItem(feeder: widget.feeder, tmpEsd: tmpEsd);
              } catch (e) {
                List<LoginResponse> apiResponse =
                    snapshot.data! as List<LoginResponse>;
                return Center(
                  child: Text(
                      "${apiResponse[0].Status.toString()} -- ${apiResponse[0].Status_message}"),
                );
              }
            } else {
              if (kDebugMode) {
                print(snapshot.error.toString());
              }
              return Expanded(child: Text(snapshot.error.toString()));
            }
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32), topRight: Radius.circular(32))),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: getData(),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton.extended(
                onPressed: () {
                  // if (widget.feeder.FeederCode <= 0) {
                  //   showDialog(
                  //     context: context,
                  //     builder: (context) {
                  //       return CustDialog(
                  //           Dlg_title: "Information",
                  //           msg: "Please select Feeder First",
                  //           onClose: (val) {},
                  //           res_code: 101);
                  //     },
                  //   );
                  //   //_showInfoDialog(context, "Please select Feeder First", 101);
                  // } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EsdScreen(fdr: widget.feeder, usr: widget.usr)));
                  // }
                },
                label: const Text("ADD ESD Entry"),
                icon: const Icon(Icons.add),
                backgroundColor: Colors.deepPurple,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
