import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:outage/api/user/userapi.dart';
import 'package:outage/model/login/user.dart';
import 'package:outage/pages/Initdata_sqlite.dart';
import 'package:outage/model/login/logreqmod.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:outage/pages/LOGIN/logintext.dart';
import 'package:outage/pages/LOGIN/showdialog.dart';
import 'package:outage/pages/LOGIN/waitScreen.dart';
import 'package:outage/pages/OTP/otppage.dart';

class CenterWidget extends StatefulWidget {
  final Size size;
  const CenterWidget({Key? key, required this.size}) : super(key: key);

  @override
  State<CenterWidget> createState() => _CenterWidgetState();
}

class _CenterWidgetState extends State<CenterWidget> {
  String _msg = "";
  String _title = "";
  String username = "";
  String password = "";

  int msgCode = 0;
  bool showWaitScreen = false;
  bool showWaitCircular = false;
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if (kDebugMode) {
      print("initPlatformState Function Called");
    }
    var deviceData = <String, dynamic>{};
    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidDevice(await _deviceInfoPlugin.androidInfo);
      }
    } catch (e) {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
    setState(() {
      _deviceData = deviceData;
    });
  }

  Map<String, dynamic> _readAndroidDevice(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'id': build.id,
    };
  }

  void _onCheckLogin() async {
    setState(() {
      showWaitScreen = true;
      showWaitCircular = true;
      _title = "Checking";
      _msg = "Please Wait...";
    });

    LoginReq lgnReq = LoginReq(
        usrCode: username, //_username.text,
        usrPass: password,
        imei: _deviceData['id']); // _password.text,

    try {
      LoginResponse log_resp = await UserAPI.checkLogin(lgnReq);
      if (kDebugMode) {
        print("Responce Username is ${log_resp.Status}");
      }
      if (log_resp.Status == 0 || log_resp.Status == 4) {
        setState(() {
          showWaitScreen = false;
          showWaitCircular = false;
          _title = "";
          _msg = "";
        });
        Users usr = Users(
          usr_id: lgnReq.usrCode,
          usr_name: log_resp.User_name,
          usr_locname: log_resp.Location_name,
          usr_loccode: log_resp.Location_code,
        );
        if (context.mounted) {
          if (log_resp.Status == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InitdataSQLite(
                  usr: usr,
                ),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OTPScreen(
                  imei: _deviceData['id'],
                  usr: usr,
                  stsMsg: log_resp.Status_message,
                ),
              ),
            );
          }
        }
      } else {
        setState(() {
          _msg = log_resp.Status_message;
          showWaitCircular = false;
          _title = "API Response";
          msgCode = log_resp.Status;
          //showWaitScreen = false;
        });
      }
    } catch (e) {
      setState(() {
        _msg = e.toString();
        showWaitCircular = false;
        _title = "API Error";
        msgCode = -2;
        //showWaitScreen = false;
      });
    }
    //_showDialog(context, "Error", "Username and Password are Wrong", -1);
  }

  @override
  Widget build(BuildContext context) {
    if (showWaitCircular) {
      return const WaitCircularWidget();
    } else {
      if (msgCode == 0) {
        return (LoginWidget(
          OnSubmit: (_username, _password) {
            setState(() {
              username = _username;
              password = _password;
            });
            _onCheckLogin();
          },
        ));
      } else {
        return (ShowLgnDialog(
            Dlg_title: _title,
            msg: _msg,
            res_code: msgCode,
            onClose: (rspcode) {
              setState(() {
                msgCode = rspcode;
              });
            }));
      }
    }
  }
}
