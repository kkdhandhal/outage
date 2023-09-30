import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({
    super.key,
    required this.imei,
    required this.userCode,
    required this.stsMsg,
  });
  final String imei;
  final String userCode;
  final String stsMsg;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.stsMsg),
        ],
      ),
    ));
  }
}
