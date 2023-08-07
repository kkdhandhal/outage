import 'dart:async';

import 'package:flutter/material.dart';
import 'package:outage/api/api.dart';
import 'package:outage/model/feeder.dart';

class Deboucer {
  final int miliseconds;
  Timer? timer;

  Deboucer({required this.miliseconds});

  run(VoidCallback action) {
    timer?.cancel();
    timer = Timer(Duration(milliseconds: miliseconds), action);
  }
}

class DropDown extends StatefulWidget {
  // final List<String> suggList;
  Function(String text, int value) OnSelect;
  DropDown({
    super.key,
    // required this.suggList,
    required this.OnSelect,
  });

  @override
  State<DropDown> createState() => _dropdownState();
}

class _dropdownState extends State<DropDown> {
  final FocusNode _focusnode = FocusNode();
  late List<Feeder> _mastsuggList;
  late List<Feeder> _suggList;
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

    //WsuggList = widget.suggList;
    // API.fetchFeederData("").then((value) => setState(() {
    //       _mastsuggList = value;
    //       _suggList = value;
    //     }));
    // _mastsuggList = ['FULZAR','DIIDOD','aaaaaa','bbbb','eeed','rtre']];
    // _suggList = value;

    //onChange = widget.onChange;
    _focusnode.addListener(() {
      if (_focusnode.hasFocus) {
        // API.fetchFeederData("").then((value) => setState(() {
        //       _mastsuggList = value;
        //       // _suggList = value;
        //       _suggList = _mastsuggList
        //           .where((element) => element.fdr_name
        //               .toLowerCase()
        //               .contains(_txtcontroller.text.toLowerCase()))
        //           .toList();
        //     }));

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

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    //print(widget.suggList);
    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        height: MediaQuery.of(context).size.height * 0.70,
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
              // height: MediaQuery.of(context).size.height * 0.70,
              // constraints: const BoxConstraints(
              //     minWidth: MediaQuery.of(context).size.height * 0.70,
              //     maxWidth: size.width),
              decoration: BoxDecoration(
                color: Colors.blue[600],
                borderRadius: BorderRadius.circular(12),
              ),
              padding:
                  const EdgeInsets.only(left: 10, top: 1, bottom: 1, right: 10),
              child: FutureBuilder(
                future: API.fetchFeederData(_txtcontroller.text),
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
                            widget.OnSelect(_suggList[index].fdr_name,
                                _suggList[index].fdr_code);

                            _focusnode.unfocus();
                          },
                        );
                      },
                    );
                  } else {
                    return const CircularProgressIndicator(
                      color: Colors.white,
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
