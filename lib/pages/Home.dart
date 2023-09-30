//import 'dart:convert';
//import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:outage/component/home_upper.dart';

//import 'package:outage/model/rlmfeeder.dart';
import 'package:outage/pages/ESD/esdtabview.dart';
//import 'package:realm/realm.dart';
import 'package:outage/model/feeder.dart';

//import 'package:outage/model/rlmfeeder.g.dart';

//import '../api/api.dart';
//import '../component/dropdown_rlm.dart';
import '../model/login/user.dart';
//import 'Tabview.dart';

//import 'package:searchfield/searchfield.dart';

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
    if (widget.fdr?.fdr_code != null) {
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
