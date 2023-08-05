import 'package:flutter/material.dart';

class Tabview extends StatefulWidget {
  const Tabview({Key? key}) : super(key: key);

  @override
  _TabviewState createState() => _TabviewState();
}

class _TabviewState extends State<Tabview> with TickerProviderStateMixin {
  late final TabController _tabbarController;
  @override
  void initState() {
    _tabbarController = TabController(length: 5, vsync: this);
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TabBar(
            controller: _tabbarController,
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: Colors.black,
            labelColor: Colors.red,
            tabs: const <Widget>[
              Tab(
                text: "TT",
              ),
              Tab(
                text: "SF",
              ),
              Tab(
                text: "ESD",
              ),
              Tab(
                text: "PSD",
              ),
              Tab(
                text: "LSD",
              ),
            ],
          ),
          Flexible(
            child: TabBarView(
              children: <Widget>[
                Text("TT"),
                Text("TT2"),
                Text("TT3"),
                Text("TT4"),
                Text("TT5"),
              ],
              controller: _tabbarController,
            ),
          ),
        ],
      ),
    );
  }
}
