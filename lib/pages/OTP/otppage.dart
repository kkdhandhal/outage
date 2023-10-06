import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:outage/model/login/user.dart';
import 'package:outage/pages/Initdata_sqlite.dart';

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
  String otpVal = "";
  int initStart = 180;
  late int counter;
  late Timer timer;
  bool setResendBtnEnabled = false;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (timer) {
      if (counter < 1) {
        setState(() {
          setResendBtnEnabled = true;
        });
      } else {
        setState(() {
          counter--;
        });
      }
    });
  }

  void initState() {
    super.initState();
    counter = initStart;
    setResendBtnEnabled = false;
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      backgroundColor: Colors.blue[800],
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
                style: TextStyle(color: Colors.white, fontSize: 26),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Text(
                'Enter OTP code,  ${widget.stsMsg}',
                style: const TextStyle(color: Colors.white, fontSize: 16),
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
                          numberOfFields: 4,
                          fieldWidth: 55,
                          borderWidth: 2,
                          textStyle:
                              const TextStyle(color: Colors.blue, fontSize: 36),
                          borderColor: Colors.blue,
                          enabledBorderColor: Colors.blue,
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
                            child: const Text("Resend OTP"),
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
                              style: TextStyle(color: Colors.grey),
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
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.only(
                                left: 80, right: 80, top: 15, bottom: 15),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InitdataSQLite(
                                  usr: widget.usr,
                                ),
                              ),
                            );
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
