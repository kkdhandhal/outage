import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:outage/api/user/userapi.dart';
import 'package:outage/component/custdialog.dart';
import 'package:outage/model/login/logreqmod.dart';
import 'package:outage/model/login/user.dart';
import 'package:outage/pages/initdata/Initdata_sqlite.dart';
import 'package:outage/utils/ui.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({
    super.key,
    required this.imei,
    required this.usr,
    required this.stsMsg,
  });
  final String imei;
  final Users usr;
  final String stsMsg;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String _msg = "";
  String _title = "";
  String username = "";
  String password = "";

  int msgCode = 0;
  bool showWaitScreen = false;
  bool showWaitCircular = false;
  String otpVal = "";
  int initStart = 180;
  late int counter;
  late Timer timer;
  bool setResendBtnEnabled = false;

  void _onCheckOTP(String tmp_otp) async {
    setState(() {
      showWaitScreen = true;
      showWaitCircular = true;
      _title = "Checking";
      _msg = "Please Wait...";
    });
    OTPReq otpReq = OTPReq(
        usrCode: widget.usr.usr_id, //_username.text,
        otp: tmp_otp,
        imei: widget.usr.IPIMEI);

    // try {
    LoginResponse otp_resp = await UserAPI.checkOTP(otpReq);
    if (kDebugMode) {
      print("Responce Username is ${otp_resp.Status}");
    }
    if (otp_resp.Status == 0) {
      // setState(() {
      //   showWaitScreen = false;
      //   showWaitCircular = false;
      //   _title = "";
      //   _msg = "";
      // });
      Users usr = Users(
        IPIMEI: widget.imei,
        usr_id: otpReq.usrCode,
        usr_name: otp_resp.User_name,
        usr_locname: otp_resp.Location_name,
        usr_loccode: otp_resp.Location_code,
      );
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InitdataSQLite(
              usr: usr,
            ),
          ),
        );
      }
    } else {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return CustDialog(
                //exitApp: false,
                isConfirmDialog: false,
                Dlg_title: "Error",
                msg: otp_resp.Status_message,
                onClose: (val) {},
                res_code: otp_resp.Status);
          },
        );
      }
    }
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (timer) {
      if (counter < 1) {
        setState(() {
          setResendBtnEnabled = true;
        });
      } else {
        if (mounted) {
          setState(() {
            counter--;
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    counter = initStart;
    setResendBtnEnabled = false;
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      backgroundColor: appPrimaryColor,
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                top: 60,
                bottom: 5,
              ),
              child: Text(
                "OTP Varification",
                style: TextStyle(
                  color: appPrimaryColorLowShade,
                  fontSize: 26,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Text(
                'Enter OTP code,  ${widget.stsMsg}',
                style: const TextStyle(
                  color: appPrimaryColorLowShade,
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Center(
                        child: OtpTextField(
                          numberOfFields: 6,
                          fieldWidth: 45,
                          borderWidth: 2,
                          textStyle: const TextStyle(
                              color: appPrimaryColor, fontSize: 36),
                          borderColor: appPrimaryColorLowShade,
                          cursorColor: appPrimaryColor,
                          enabledBorderColor: appPrimaryColor,
                          showFieldAsBox: false,
                          onSubmit: (String verificationCode) {
                            setState(() {
                              otpVal = verificationCode;
                            });
                          },
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 130),
                          child: Text(counter.toString()),
                        ),
                        if (setResendBtnEnabled) ...[
                          TextButton(
                            child: const Text(
                              "Resend OTP",
                              style: TextStyle(color: appPrimaryColor),
                            ),
                            onPressed: () {
                              setState(() {
                                startTimer();
                                counter = initStart;
                                setResendBtnEnabled = false;
                              });
                            },
                          ),
                        ] else ...[
                          TextButton(
                            child: const Text(
                              "Resend OTP",
                              style: TextStyle(color: appPrimaryColor),
                            ),
                            onPressed: () {},
                          )
                        ]
                      ],
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            backgroundColor: appPrimaryColor,
                            padding: const EdgeInsets.only(
                                left: 80, right: 80, top: 15, bottom: 15),
                          ),
                          onPressed: () {
                            if (otpVal.isEmpty) {
                              if (context.mounted) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustDialog(
                                        isConfirmDialog: false,
                                        Dlg_title: "Information",
                                        msg: "Please Enter OTP",
                                        onClose: (val) {},
                                        res_code: 101);
                                  },
                                );
                              }
                            } else {
                              _onCheckOTP(otpVal);
                            }
                          },
                          child: const Text(
                            "Submit",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
