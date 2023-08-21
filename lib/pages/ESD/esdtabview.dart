import 'package:flutter/material.dart';
import 'package:outage/model/feeder.dart';
import 'package:outage/model/intruption/esd_model.dart';
import 'package:outage/model/user.dart';
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
  Widget getData() {
    return FutureBuilder<List<ESD>>(
        future: ESDAPI.fetchESD(widget.feeder.fdr_code),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            List<ESD> _tmpEsd = snapshot.data!;
            return ListView.builder(
                itemCount: _tmpEsd.length,
                itemBuilder: (BuildContext context, index) {
                  return ListTile(
                    title: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "${_tmpEsd[index].esd_st_date.day}/${_tmpEsd[index].esd_st_date.month}/${_tmpEsd[index].esd_st_date.year}  -  ${_tmpEsd[index].esd_st_time}"),
                            Text(
                                "${_tmpEsd[index].esd_end_date.day}/${_tmpEsd[index].esd_end_date.month}/${_tmpEsd[index].esd_end_date.year} -  ${_tmpEsd[index].esd_end_time}"),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            const Text("Duration"),
                            Text(_tmpEsd[index].esd_duration.toString())
                          ],
                        )
                      ],
                    ),
                  );
                });
          } else {
            // return Text(
            //     "No ESD found for ${widget.feeder.fdr_name} during this month.");
            print(snapshot.error.toString());
            return Text(snapshot.error.toString());
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: widget.feeder.fdr_code > 0
                ? getData()
                : const Text("No Data Found"),
          ),
          FloatingActionButton.extended(
            onPressed: () {
              if (widget.feeder.fdr_code <= 0)
                _showInfoDialog(context, "Please select Feeder First", 101);
              else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EsdScreen(fdr: widget.feeder, usr: widget.usr)));
              }
            },
            label: Text("ADD Entry"),
            icon: Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
