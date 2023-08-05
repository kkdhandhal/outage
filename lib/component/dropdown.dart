import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  final List<String> suggList;
  Function(String value) OnSelect;
  DropDown({
    super.key,
    required this.suggList,
    required this.OnSelect,
  });

  @override
  State<DropDown> createState() => _dropdownState();
}

class _dropdownState extends State<DropDown> {
  final FocusNode _focusnode = FocusNode();
  late List WsuggList;
  late Function onChange;
  late OverlayEntry _overlayEntry;
  final LayerLink _ddLayerLink = LayerLink();
  final TextEditingController _txtcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WsuggList = widget.suggList;
    //onChange = widget.onChange;
    _focusnode.addListener(() {
      if (_focusnode.hasFocus) {
        WsuggList = widget.suggList
            .where((element) => element
                .toLowerCase()
                .contains(_txtcontroller.text.toLowerCase()))
            .toList();
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context)?.insert(_overlayEntry);
      } else {
        if (_overlayEntry.mounted) {
          _overlayEntry.remove();
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
              constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
              decoration: BoxDecoration(
                color: Colors.blue[600],
                borderRadius: BorderRadius.circular(12),
              ),
              padding:
                  const EdgeInsets.only(left: 10, top: 1, bottom: 1, right: 10),
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: WsuggList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                        WsuggList[index],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        _txtcontroller.text = WsuggList[index];
                        widget.OnSelect(WsuggList[index]);
                        _focusnode.unfocus();
                      },
                    );
                  }),
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
            WsuggList = widget.suggList
                .where((element) => element
                    .toLowerCase()
                    .contains(_txtcontroller.text.toLowerCase()))
                .toList();
            if (!_overlayEntry.mounted) {
              _overlayEntry = _createOverlayEntry();
              Overlay.of(context)?.insert(_overlayEntry);
            }
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
