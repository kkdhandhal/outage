import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class waitDialog extends StatelessWidget {
  waitDialog({
    super.key,
    required this.res_id,
    required this.Dlg_title,
    required this.msg,
    required this.ShowCircularBar,
  });

  final int res_id;
  final String msg;
  final String Dlg_title;
  final bool ShowCircularBar;

  @override
  Widget build(BuildContext context) {
    if (ShowCircularBar) {
      return AlertDialog(
        title: Text(Dlg_title),
        content: Column(
          children: [
            const CircularProgressIndicator(),
            Text(msg),
          ],
        ),
      );
    } else {
      return AlertDialog(
        title: Text(Dlg_title),
        content: Column(
          children: [
            //const CircularProgressIndicator(),
            Text(msg),
          ],
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  }
}
