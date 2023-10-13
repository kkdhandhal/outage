import 'package:flutter/material.dart';

class CustDialog extends StatelessWidget {
  const CustDialog({
    super.key,
    required this.onClose,
    required this.res_code,
    required this.Dlg_title,
    required this.msg,
  });
  final Function(int rtnCode) onClose;
  final int res_code;
  final String msg;
  final String Dlg_title;

  @override
  Widget build(BuildContext context) {
    Color _maincolor = Color.fromARGB(251, 253, 114, 72);
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          CardDialog(Dlg_title: Dlg_title, msg: msg),
          Positioned(
            top: 0,
            right: 0,
            height: 28,
            width: 28,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(5),
                shape: const CircleBorder(),
                backgroundColor: _maincolor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.close_rounded,
                size: 16,
              ),
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
  });

  final String Dlg_title;
  final String msg;

  @override
  Widget build(BuildContext context) {
    Color _maincolor = Color.fromARGB(251, 253, 114, 72);
    Color _backcolor = const Color.fromARGB(255, 62, 43, 107);

    return Container(
      margin: const EdgeInsets.all(10),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: _maincolor,
                size: 36,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                Dlg_title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _maincolor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            msg,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(106, 192, 184, 1),
            ),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }
}
