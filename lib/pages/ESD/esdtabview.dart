import 'package:flutter/material.dart';
import 'package:outage/model/feeder.dart';
import 'package:outage/model/user.dart';
import 'package:outage/pages/ESD/esdscreen.dart';
import 'package:outage/pages/esdscreen.dart';

class EsdTabView extends StatefulWidget {
  Users usr;
  Feeder feeder;
  EsdTabView({
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
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                ListTile(
                  title: Text("entry1"),
                ),
                ListTile(
                  title: Text("entry1"),
                ),
                ListTile(
                  title: Text("entry1"),
                ),
                ListTile(
                  title: Text("entry1"),
                ),
              ],
            ),
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
