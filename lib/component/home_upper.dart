import 'package:flutter/material.dart';
import 'package:outage/component/dropdown_sqlite.dart';
import 'package:outage/model/feeder.dart';
import 'package:outage/model/login/user.dart';
import 'package:outage/pages/LOGIN/login.dart';

class HomeUpper extends StatefulWidget {
  final Users usr;
  final Feeder? fdr;
  final Function(Feeder fdr) OnSelect;
  //final List<Feeder> fdr_list;

  const HomeUpper({
    super.key,
    required this.usr,
    this.fdr,
    required this.OnSelect,
  });

  @override
  State<HomeUpper> createState() => _HomeUpperState();
}

class _HomeUpperState extends State<HomeUpper> {
  late TextEditingController _searchController;
  //late final TabController _tabbarController;
  String selectedFeeder = "";
  int selectedFeederCode = 0;

  Feeder _selFdr = Feeder.initFeeder();

  @override
  void initState() {
    super.initState();

    if (widget.fdr?.FeederCode != null) {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 50.0, left: 12, bottom: 12, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, left: 8, bottom: 5, right: 8),
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
                      "${widget.usr.usr_locname}, ${widget.usr.usr_loccode}",
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
                child: IconButton(
                  iconSize: 24,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (route) => false);
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 15, top: 1, bottom: 1, right: 15),
          child: DropDownSQLite(
            adm_sdn_code: widget.usr.usr_loccode,
            feeder_name: _selFdr.FeederName,
            // suggList: suggList, //suggList,
            OnSelect: ((fdr) {
              // selectedFeeder = fdrtxt;
              // selectedFeederCode = fdrcode;
              widget.OnSelect(fdr);
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
      ],
    );
  }
}
