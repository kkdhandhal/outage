import 'package:flutter/material.dart';
import 'package:outage/model/feeder.dart';
import 'package:outage/model/login/user.dart';
import 'package:outage/pages/Home.dart';

class CustDialog extends StatelessWidget {
  const CustDialog({
    super.key,
    required this.onClose,
    required this.res_code,
    required this.Dlg_title,
    required this.msg,
    this.usr,
    this.fdr,
  });
  final Users? usr;
  final Feeder? fdr;
  final Function(int rtnCode) onClose;
  final int res_code;
  final String msg;
  final String Dlg_title;

  @override
  Widget build(BuildContext context) {
    Color _mainColor = const Color.fromARGB(251, 253, 114, 72);
    Color _secColor = const Color.fromARGB(250, 154, 226, 140);

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          CardDialog(
            Dlg_title: Dlg_title,
            msg: msg,
            usr: usr,
            fdr: fdr,
            res_code: res_code,
          ),
          Positioned(
            top: 0,
            left: 0,
            height: 56,
            width: 56,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                backgroundColor: res_code != 0 ? _mainColor : _secColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                res_code != 0
                    ? Icons.warning_amber_rounded
                    : Icons.done_all_outlined,
                size: 42,
                color: Colors.black,
              ),
              // child: _icon,
            ),
          )
        ],
      ),
    );
  }
}

class CardDialog extends StatelessWidget {
  const CardDialog({
    super.key,
    required this.Dlg_title,
    required this.msg,
    required this.res_code,
    this.usr,
    this.fdr,
  });
  final Users? usr;
  final Feeder? fdr;
  final int res_code;
  final String Dlg_title;
  final String msg;

  @override
  Widget build(BuildContext context) {
    Color _maincolor = Color.fromARGB(251, 253, 114, 72);
    Color _backcolor = const Color.fromARGB(255, 62, 43, 107);
    Color _secColor = Color.fromARGB(255, 156, 245, 56);
    Widget _icon = Icon(
      // Icons.warning_amber_rounded,
      Icons.done_all_outlined,
      color: _maincolor,
      size: 36,
    );
    if (res_code == 0) {
      _maincolor = _secColor;
    }

    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: _backcolor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            Dlg_title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _maincolor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
            width: double.maxFinite,
          ),
          Text(
            msg,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
            onPressed: () {
              if (res_code != 0) {
                Navigator.of(context).pop();
              } else {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(fdr: fdr, usr: usr!)),
                    (route) => false);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(106, 192, 184, 1),
            ),
            child: const Text(
              "OK",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          )
        ],
      ),
    );
  }
}
