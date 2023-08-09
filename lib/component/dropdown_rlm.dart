import 'dart:async';
import 'package:outage/model/feeder.dart';
import 'package:outage/model/rlmfeeder.dart';
//import 'package:realm/realm.dart';
import 'package:flutter/material.dart';
import 'package:outage/api/api.dart';
import 'package:realm/realm.dart';
//import 'package:outage/model/feeder.dart';

class Deboucer {
  final int miliseconds;
  Timer? timer;

  Deboucer({required this.miliseconds});

  run(VoidCallback action) {
    timer?.cancel();
    timer = Timer(Duration(milliseconds: miliseconds), action);
  }
}

class DropDownRLM extends StatefulWidget {
  int adm_sdn_code;

  Function(Feeder fdr) OnSelect;
  DropDownRLM({
    super.key,
    // required this.suggList,
    required this.adm_sdn_code,
    required this.OnSelect,
  });

  @override
  State<DropDownRLM> createState() => _dropdownrlmState();
}

class _dropdownrlmState extends State<DropDownRLM> {
  final FocusNode _focusnode = FocusNode();
  late List<rlmfeeder> _mastsuggList;
  late RealmResults<rlmfeeder> _suggList;
  final realm = Realm(Configuration.local([rlmfeeder.schema]));
  String selectedString = "";
  int selectedValue = 0;
  late Function onChange;
  late OverlayEntry _overlayEntry;
  final LayerLink _ddLayerLink = LayerLink();
  final TextEditingController _txtcontroller = TextEditingController();
  final _debouncer = Deboucer(miliseconds: 500);

  @override
  void initState() {
    super.initState();
    _focusnode.addListener(() {
      if (_focusnode.hasFocus) {
        _overlayEntry = _createOverlayEntry();

        Overlay.of(context).insert(_overlayEntry);
        // }
      } else {
        if (_overlayEntry.mounted) {
          _overlayEntry?.remove();
          _txtcontroller.text = selectedString;
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    realm.close();
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        //height: MediaQuery.of(context).size.height * 0.70,
        left: offset.dx,
        top: offset.dy + size.height + 0.5,
        child: CompositedTransformFollower(
          link: _ddLayerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 0.5),
          child: Material(
            borderRadius: BorderRadius.circular(12),
            elevation: 5.5,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue[600],
                borderRadius: BorderRadius.circular(12),
              ),
              padding:
                  const EdgeInsets.only(left: 10, top: 1, bottom: 1, right: 10),
              child: FutureBuilder(
                future: API.rlm_fetchFeederData(
                    _txtcontroller.text, widget.adm_sdn_code, realm),
                builder: (context, sugglist) {
                  if (sugglist.hasData) {
                    _suggList = sugglist.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: _suggList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(
                            "${_suggList[index].fdr_name} - ${_suggList[index].fdr_code}",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              selectedString = _suggList[index].fdr_name;
                              selectedValue = _suggList[index].fdr_code;
                            });
                            _txtcontroller.text = selectedString;
                            // widget.OnSelect(_suggList[index].fdr_name,
                            //     _suggList[index].fdr_code);
                            widget.OnSelect(Feeder(
                                fdr_loccode: _suggList[index].fdr_code,
                                fdr_adm_sdn: _suggList[index].fdr_adm_sdn,
                                fdr_code: _suggList[index].fdr_code,
                                fdr_type: _suggList[index].fdr_type,
                                fdr_name: _suggList[index].fdr_name,
                                fdr_category: _suggList[index].fdr_category));
                            _focusnode.unfocus();
                          },
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }
                },
              ),
              // ListView.builder(
              //   shrinkWrap: true,
              //   scrollDirection: Axis.vertical,
              //   itemCount: _suggList.length,
              //   itemBuilder: (BuildContext context, int index) {
              //     return ListTile(
              //       title: Text(
              //         _suggList[index].fdr_name,
              //         style: const TextStyle(
              //           color: Colors.white,
              //         ),
              //       ),
              //       onTap: () {
              //         _txtcontroller.text = _suggList[index].fdr_name;
              //         widget.OnSelect(_suggList[index].fdr_name);
              //         _focusnode.unfocus();
              //       },
              //     );
              //   },
              // )
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _ddLayerLink,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[600],
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.only(left: 10, top: 1, bottom: 1, right: 10),
        child: TextFormField(
          controller: _txtcontroller,
          focusNode: _focusnode,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            border: InputBorder.none,
          ),
          cursorColor: Colors.white,
          onChanged: (value) {
            // setState(() {
            //   _suggList = _mastsuggList
            //       .where((element) => element.fdr_name
            //           .toLowerCase()
            //           .contains(value.toLowerCase()))
            //       .toList();
            // });

            // if (!_overlayEntry.mounted) {
            //   _overlayEntry.remove();
            // }

            // suggList = API.fetchFeederData(_txtcontroller.text.toLowerCase());
            _debouncer.run(() {});
            if (_overlayEntry.mounted) {
              _overlayEntry?.remove();
              //_overlayEntry = _createOverlayEntry();
              Overlay.of(context).insert(_overlayEntry);
            }
            // });

            // onChange(value);
          },
        ),
      ),
    );
  }
}

// (value) {
//             WsuggList = widget.suggList
//                 .where((element) => element
//                     .toLowerCase()
//                     .contains(_txtcontroller.text.toLowerCase()))
//                 .toList();

//             if (!_overlayEntry.mounted) {
//               _overlayEntry = _createOverlayEntry();
//               Overlay.of(context)?.insert(_overlayEntry);
//             }
//           }
