import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:outage/model/feeder.dart';
import 'package:outage/model/intruption/esd_model.dart';
import 'package:outage/model/login/user.dart';
import 'package:outage/pages/ESD/esdscreen.dart';
//import 'package:outage/pages/esdscreen.dart';
import 'package:outage/api/intruptions/esdapi.dart';

class EsdTabView extends StatefulWidget {
  final Users usr;
  final Feeder feeder;
  const EsdTabView({
    Key? key,
    required this.usr,
    required this.feeder,
  }) : super(key: key);

  @override
  _EsdtabviewState createState() => _EsdtabviewState();
}

Future<void> _showInfoDialog(
    BuildContext context, final String dbmsg, int dbcode) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Information - $dbcode"),
          content: Text(dbmsg),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

class _EsdtabviewState extends State<EsdTabView> {
  //late Feeder _sel_feeder = Feeder.initFeeder();

  @override
  void initState() {
    super.initState();
  }

  Widget getData() {
    if (kDebugMode) {
      print('Selected feeder code is ${widget.feeder.fdr_code.toString()}');
    }
    return FutureBuilder<List<ESD>>(
        future: ESDAPI.fetchESD(widget.feeder.fdr_code),
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
              List<ESD> tmpEsd = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: widget.feeder.fdr_code > 0
                        ? Text(
                            "Total ${tmpEsd.length} ESD entry in current month")
                        : const Text(""),
                  ),
                  Expanded(
                    child: ListView.separated(
                        itemCount: tmpEsd.length,
                        separatorBuilder: ((context, index) {
                          return const Divider(
                            height: 3.0,
                          );
                        }),
                        itemBuilder: (BuildContext context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.shade400,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                              leading: const Icon(Icons.receipt_long,
                                  color: Colors.white),
                              title: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${tmpEsd[index].esd_st_date.day}/${tmpEsd[index].esd_st_date.month}/${tmpEsd[index].esd_st_date.year}  -  ${tmpEsd[index].esd_st_time}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "${tmpEsd[index].esd_end_date.day}/${tmpEsd[index].esd_end_date.month}/${tmpEsd[index].esd_end_date.year} -  ${tmpEsd[index].esd_end_time}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        "Duration",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        tmpEsd[index].esd_duration.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              );
            } else {
              // return Text(
              //     "No ESD found for ${widget.feeder.fdr_name} during this month.");

              print(snapshot.error.toString());
              return Text(snapshot.error.toString());
            }
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32), topRight: Radius.circular(32))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: widget.feeder.fdr_code > 0
                ? getData()
                : const Center(child: Text("Please select Feeder First")),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton.extended(
              onPressed: () {
                if (widget.feeder.fdr_code <= 0) {
                  _showInfoDialog(context, "Please select Feeder First", 101);
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EsdScreen(fdr: widget.feeder, usr: widget.usr)));
                }
              },
              label: Text("ADD Entry"),
              icon: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
