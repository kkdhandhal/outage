import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class DropDownSearch extends StatefulWidget {
  final List autoCompleteList;
  final Color PrimaryColor;
  final Color SecondaryColor;
  final Color FontColor;
  String selected_value;
  DropDownSearch(
      {Key? key,
      required this.autoCompleteList,
      this.selected_value = "",
      required this.PrimaryColor,
      required this.SecondaryColor,
      required this.FontColor})
      : super(key: key);
  @override
  State<DropDownSearch> createState() => _DropDownSearchState();
}

class _DropDownSearchState extends State<DropDownSearch> {
  // final primary_color = Colors.purple[600];
  // final secondary_color = Colors.purple[600];
  // final font_color = Colors.white;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textcontroller = TextEditingController();
  late OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context).insert(_overlayEntry);
      } else {
        _overlayEntry.remove();
      }
    });
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox _renderbox = context.findRenderObject() as RenderBox;
    var size = _renderbox.size;
    var offset = _renderbox.localToGlobal(Offset.zero);

    return OverlayEntry(
        builder: (context) => Positioned(
            left: offset.dx + 5,
            top: offset.dy + size.height + 2.0,
            width: size.width - 10,
            child: Focus(
              parentNode: _focusNode,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, size.height + 5.0),
                child: Material(
                  color: widget.PrimaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                  elevation: 5.0,
                  child: Container(
                    width: size.width - 10,
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: ListView.builder(
                      itemCount: widget.autoCompleteList.length,
                      itemBuilder: (context, index) => InkWell(
                        focusColor: widget.FontColor,
                        child: ListTile(
                          title: Text(
                            widget.autoCompleteList[index],
                            style: TextStyle(
                              color: widget.FontColor,
                            ),
                          ),
                          onTap: () {
                            _textcontroller.text =
                                widget.autoCompleteList[index];
                          },
                        ),
                      ),
                    ),
                  ),
                  // child: ListView(
                  //   padding: EdgeInsets.zero,
                  //   shrinkWrap: true,
                  //   children: <Widget>[
                  //     InkWell(
                  //       focusColor: Colors.blue,
                  //       onTap: () {
                  //         _focusNode.requestFocus();
                  //         print('clicked item 1');
                  //       },
                  //       child: ListTile(
                  //         title: Text(
                  //           "Feeder1",
                  //           style: TextStyle(
                  //             color: widget.FontColor,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     InkWell(
                  //       focusColor: Colors.blue,
                  //       onTap: () {
                  //         _focusNode.requestFocus();
                  //         print('clicked item 2');
                  //       },
                  //       child: ListTile(
                  //         title: Text(
                  //           "Feeder2",
                  //           style: TextStyle(
                  //             color: widget.FontColor,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     InkWell(
                  //       focusColor: Colors.blue,
                  //       onTap: () {
                  //         _focusNode.requestFocus();
                  //         print('clicked item 3');
                  //       },
                  //       child: ListTile(
                  //         title: Text(
                  //           "Feeder3",
                  //           style: TextStyle(
                  //             color: widget.FontColor,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        decoration: BoxDecoration(
            color: widget.PrimaryColor,
            borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: widget.FontColor,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: TextFormField(
                controller: _textcontroller,
                focusNode: _focusNode,
                //initialValue: null,
                decoration: InputDecoration.collapsed(
                  hintText: "Select Feeder",
                  hintStyle: TextStyle(color: widget.FontColor),
                  filled: true,
                  fillColor: widget.PrimaryColor,
                  hoverColor: widget.PrimaryColor,
                ),
                style: TextStyle(
                  height: 1.2,
                  color: widget.FontColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                cursorColor: widget.FontColor,
              ),
            ),
            Text("# ${_textcontroller.text}",
                style: TextStyle(
                  height: 1.2,
                  color: widget.FontColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }
}
