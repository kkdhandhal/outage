import 'package:flutter/material.dart';
import 'package:outage/model/feeder.dart';

import 'esdscreen.dart';

class Tabview extends StatefulWidget {
  Feeder feeder;
  Tabview({Key? key, required this.feeder}) : super(key: key);

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
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 60,
            padding: EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text('Feeder  Name: ${widget.feeder.fdr_name}'),
                ),
                Text('Feeder Code :  ${widget.feeder.fdr_code}'),
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
                Esdscreen(),
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
