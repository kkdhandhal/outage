import 'package:flutter/material.dart';
import 'package:outage/component/home_upper.dart';
import 'package:outage/pages/ESD/esdtabview.dart';
import 'package:outage/model/feeder.dart';
import '../model/login/user.dart';

class HomePage extends StatefulWidget {
  final Users usr;
  final Feeder? fdr;
  //final List<Feeder> fdr_list;
  const HomePage({super.key, required this.usr, this.fdr});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TextEditingController _searchController;
  String selectedFeeder = "";
  int selectedFeederCode = 0;

  Feeder _selFdr = Feeder.initFeeder();

  @override
  void initState() {
    super.initState();

    // _tabbarController = TabController(length: 1, vsync: this);
    if (widget.fdr?.FeederCode != null) {
      _selFdr = widget.fdr!;
    }
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  int suggestionsCount = 12;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HomeUpper(
            usr: widget.usr,
            fdr: _selFdr,
            OnSelect: ((fdr) {
              setState(() {
                _selFdr = fdr;
              });
              //print(Selected_value);
            }),
          ),
          Expanded(child: EsdTabView(usr: widget.usr, feeder: _selFdr)),
        ],
      ),
    );
  }
}
