import 'package:flutter/material.dart';
import 'package:outage/model/feeder.dart';
import 'package:outage/model/user.dart';
import 'package:outage/pages/ESD/esdtabview.dart';

class Tabview extends StatefulWidget {
  final Feeder feeder;
  final Users usr;
  Tabview({Key? key, required this.feeder, required this.usr})
      : super(key: key);

  @override
  _TabviewState createState() => _TabviewState();
}

class _TabviewState extends State<Tabview> with TickerProviderStateMixin {
  late final TabController _tabbarController;
  @override
  void initState() {
    _tabbarController = TabController(length: 1, vsync: this);
    super.initState();
  }

  void dispose() {
    // TODO: implement dispose

    _tabbarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 60,
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    // SizedBox(
                    //   width: 200,
                    //   child: Text('Name: ${widget.feeder.fdr_name}'),
                    // ),
                    Expanded(
                      child: Text('Code :  ${widget.feeder.fdr_code}'),
                    ),
                    Expanded(
                      child: Text('Category :  ${widget.feeder.fdr_category}'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text('Consumers :  ${widget.feeder.fdr_code}'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          TabBar(
            controller: _tabbarController,
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: Colors.black,
            labelColor: Colors.red,
            tabs: const <Widget>[
              Tab(
                text: "ESD",
              ),
              // Tab(
              //   text: "TT",
              // ),
              // Tab(
              //   text: "SF",
              // ),
              // Tab(
              //   text: "PSD",
              // ),
              // Tab(
              //   text: "LSD",
              // ),
            ],
          ),
          Flexible(
            child: TabBarView(
              children: <Widget>[
                EsdTabView(usr: widget.usr, feeder: widget.feeder)
                //Esdscreen(),
                // Text("TT2"),
                // Text("TT3"),
                // Text("TT4"),
                // Text("TT5"),
              ],
              controller: _tabbarController,
            ),
          ),
        ],
      ),
    );
  }
}
