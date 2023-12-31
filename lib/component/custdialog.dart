import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:outage/model/feeder.dart';
import 'package:outage/model/intruption/esd_model.dart';
import 'package:outage/model/login/user.dart';
import 'package:outage/pages/Home.dart';
import 'package:outage/pages/LOGIN/login.dart';
import 'package:outage/utils/constants.dart';
import 'package:outage/utils/ui.dart';

class CustDialog extends StatelessWidget {
  const CustDialog({
    super.key,
    required this.onClose,
    required this.res_code,
    required this.Dlg_title,
    required this.msg,
    required this.isConfirmDialog,
    this.usr,
    this.fdr,
    this.esd,
    this.exitApp,
  });
  final bool? exitApp;
  final bool isConfirmDialog;
  final Users? usr;
  final Feeder? fdr;
  final ESD? esd;
  final Function(int rtnCode) onClose;
  final int res_code;
  final String msg;
  final String Dlg_title;

  @override
  Widget build(BuildContext context) {
    // Color _mainColor = const Color.fromARGB(251, 253, 114, 72);
    // Color _secColor = const Color.fromARGB(250, 154, 226, 140);

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          CardDialog(
            Dlg_title: Dlg_title,
            msg: msg,
            usr: usr,
            fdr: fdr,
            esd: esd,
            exitApp: exitApp ?? false,
            isConfirmDialog: isConfirmDialog,
            onClose: (rtnCode) {
              onClose(rtnCode);
            },
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
                backgroundColor: res_code != 0 ? appAlertColor : appSucessColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                res_code != 0
                    ? Icons.warning_amber_rounded
                    : Icons.done_all_outlined,
                size: 42,
                color: appPrimaryBlackText,
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
    required this.isConfirmDialog,
    required this.onClose,
    this.usr,
    this.fdr,
    this.esd,
    required this.exitApp,
  });
  final bool? exitApp;
  final ESD? esd;
  final Function(int rtnCode) onClose;
  final bool isConfirmDialog;
  final Users? usr;
  final Feeder? fdr;
  final int res_code;
  final String Dlg_title;
  final String msg;

  @override
  Widget build(BuildContext context) {
    // Color _maincolor = const Color.fromARGB(251, 253, 114, 72);
    // Color _backcolor = const Color.fromARGB(255, 62, 43, 107);
    // Color _secColor = Color.fromARGB(255, 156, 245, 56);

    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.symmetric(
        horizontal: 28,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        //color: _backcolor,
        gradient: const LinearGradient(
          colors: [
            appPrimaryColor,
            appPrimaryColor,
            appPrimaryColor,
            appPrimaryColor,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            Dlg_title,
            textAlign: TextAlign.center,
            style: dlgTitle(appAlertColor),
          ),
          const SizedBox(
            height: 30,
            width: double.maxFinite,
          ),
          if (isConfirmDialog) ...[
            // Text(
            //   msg,
            //   textAlign: TextAlign.center,
            //   style: const TextStyle(
            //     fontSize: 18,
            //     color: Colors.white,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            SizedBox(
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Feeder Name :",
                        textAlign: TextAlign.left,
                        style: dlgText(),
                      ),
                      Text(
                        "From :",
                        textAlign: TextAlign.left,
                        style: dlgText(),
                      ),
                      Text(
                        "To :",
                        textAlign: TextAlign.left,
                        style: dlgText(),
                      ),
                      Text(
                        "Duration :",
                        textAlign: TextAlign.left,
                        style: dlgText(),
                      ),
                      Text(
                        "LC Taken By :",
                        textAlign: TextAlign.left,
                        style: dlgText(),
                      ),
                      Text(
                        "Reason :",
                        textAlign: TextAlign.left,
                        style: dlgText(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        esd!.FEEDERNM,
                        textAlign: TextAlign.left,
                        style: dlgText(),
                      ),
                      Text(
                        "${DateFormat("dd-MM-yyyy").format(esd!.ESDDATE)} ${esd!.ESDFROMHH}:${esd!.ESDFROMMM}",
                        textAlign: TextAlign.left,
                        style: dlgText(),
                      ),
                      Text(
                        "${DateFormat("dd-MM-yyyy").format(esd!.ESDENDDATE)} ${esd!.ESDTOHH}:${esd!.ESDTOMM}",
                        textAlign: TextAlign.left,
                        style: dlgText(),
                      ),
                      Text(
                        "${esd!.ESDDURATIONHH.toString().padLeft(2, "0")}:${esd!.ESDDURATIONMM.toString().padLeft(2, "0")}",
                        textAlign: TextAlign.left,
                        style: dlgText(),
                      ),
                      Text(
                        esd!.ESDLCTAKENBY,
                        textAlign: TextAlign.left,
                        style: dlgText(),
                      ),
                      Text(
                        esd!.ESDREASON,
                        textAlign: TextAlign.left,
                        style: dlgText(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Are you sure want to Save?",
              textAlign: TextAlign.center,
              style: dlgTitle(appAlertColor),
            ),
          ] else ...[
            Text(
              msg,
              textAlign: TextAlign.center,
              style: dlgText(),
            ),
          ],
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (isConfirmDialog) {
                    onClose(1);
                    if (exitApp!) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                          (route) => false);
                    } else {
                      Navigator.of(context).pop();
                    }
                  } else {
                    onClose(0);
                    if (res_code != 0) {
                      if (exitApp!) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                            (route) => false);
                      } else {
                        Navigator.of(context).pop();
                      }
                    } else {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomePage(fdr: fdr, usr: usr!)),
                          (route) => false);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: appSecondaryColor,
                ),
                child: Text(
                  "OK",
                  style: dlgBtnText(),
                ),
              ),
              if (isConfirmDialog) ...[
                ElevatedButton(
                  onPressed: () {
                    onClose(0);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appAlertColor,
                  ),
                  child: Text(
                    "Cancel",
                    style: dlgBtnText(),
                  ),
                )
              ]
            ],
          ),
        ],
      ),
    );
  }
}
