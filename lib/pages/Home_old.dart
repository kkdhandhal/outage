//import 'dart:convert';
//import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

//import 'package:outage/model/rlmfeeder.dart';
import 'package:outage/pages/ESD/esdtabview.dart';
//import 'package:realm/realm.dart';
import 'package:outage/model/feeder.dart';
//import 'package:outage/model/rlmfeeder.g.dart';

//import '../api/api.dart';
import '../component/dropdown_rlm.dart';
import '../model/login/user.dart';
//import 'Tabview.dart';

//import 'package:searchfield/searchfield.dart';

class HomePage extends StatefulWidget {
  final Users usr;
  final Feeder? fdr;
  //final List<Feeder> fdr_list;
  HomePage({super.key, required this.usr, this.fdr});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TextEditingController _searchController;
  late final TabController _tabbarController;
  String selectedFeeder = "";
  int selectedFeederCode = 0;

  Feeder _selFdr = Feeder.initFeeder();
  int fdr_sdn_code = 382134;

  @override
  void initState() {
    super.initState();
    _tabbarController = TabController(length: 1, vsync: this);
    if (widget.fdr?.fdr_code != null) {
      _selFdr = widget.fdr!;
    }
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //importFeeder();
    _searchController.dispose();
    super.dispose();
  }

  int suggestionsCount = 12;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 50.0, left: 12, bottom: 12, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 10, left: 8, bottom: 5, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.usr.usr_name} ",
                        //"${widget.usr.usr_nameinit} ${widget.usr.usr_firstname} ${widget.usr.usr_lastname}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "JP, Surendranagar Circle ${widget.usr.usr_loccode}",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 119, 186, 241),
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue[600],
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(5),
                  child: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 15, top: 1, bottom: 1, right: 15),
            child: DropDownRLM(
              adm_sdn_code: widget.usr.usr_loccode,
              feeder_name: _selFdr.fdr_name,
              // suggList: suggList, //suggList,
              OnSelect: ((fdr) {
                // selectedFeeder = fdrtxt;
                // selectedFeederCode = fdrcode;
                setState(() {
                  _selFdr = fdr;
                });
                //print(Selected_value);
              }),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabbarController,
              children: <Widget>[
                SizedBox(
                  child: EsdTabView(usr: widget.usr, feeder: _selFdr), //Text(
                  //   "tab",
                  //   style: TextStyle(color: Colors.white),
                  // ), //EsdTabView(usr: widget.usr, feeder: _selFdr),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
