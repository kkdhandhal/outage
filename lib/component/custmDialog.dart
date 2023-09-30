import 'package:flutter/material.dart';

class CustDialogs {
  static Future<void> showCustDialog(
    BuildContext context,
    String Dlg_title,
    int res_id,
    String msg,
    bool ShowCircularBar,
    bool ShowDlg,
  ) async {
    if (ShowDlg) {
      if (ShowCircularBar) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                elevation: 0,
                backgroundColor: Colors.limeAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                child: Container(
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const FlutterLogo(
                        size: 150,
                      ),
                      const Text(
                        "This is a Custom Dialog",
                        style: TextStyle(fontSize: 20),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Close"))
                    ],
                  ),
                ),
              );
            });
      } else {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
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
            });
      }
    } else {
      Navigator.of(context).pop();
    }
  }
}
