import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:outage/model/rlmfeeder.dart';
import 'package:realm/realm.dart';
import 'package:outage/model/feeder.dart';
//import 'package:outage/model/rlmfeeder.g.dart';

import '../api/api.dart';
import '../component/dropdown_rlm.dart';
import 'Tabview.dart';

//import 'package:searchfield/searchfield.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _searchController;
  String selectedFeeder = "";
  int selectedFeederCode = 0;
  int fdr_sdn_code = 382134;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();
  }

  // void importFeeder() async {
  //   final realm = Realm(Configuration.local([rlmfeeder.schema]));
  //   API.getSDNFeeders(fdr_sdn_code).then((value) => {
  //         value.forEach((e) {
  //           var fdr = rlmfeeder(e.fdr_code, e.fdr_adm_sdn, e.fdr_loccode,
  //               e.fdr_type, e.fdr_name, e.fdr_category);
  //           realm.write(() {
  //             realm.add(fdr);
  //           });
  //         })
  //       });
  //   realm.close();
  // }

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
      // appBar: AppBar(
      //   title: const Text("IT Application"),
      //   backgroundColor: Colors.deepPurple,
      //   elevation: 0,
      // ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
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
                          "Mr Krushna Dhandhal",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "JP, Surendranagar Circle $fdr_sdn_code",
                          style: TextStyle(
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
                adm_sdn_code: fdr_sdn_code,

                // suggList: suggList, //suggList,
                OnSelect: ((fdrtxt, fdrcode) {
                  selectedFeeder = fdrtxt;
                  selectedFeederCode = fdrcode;
                  setState(() {});
                  //print(Selected_value);
                }),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text('Selected Feeder  is : $selectedFeeder - $selectedFeederCode'),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32))),
                child: Tabview(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
