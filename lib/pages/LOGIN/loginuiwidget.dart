import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:outage/model/login/user.dart';
import 'package:outage/utils/constants.dart';
import 'package:outage/utils/ui.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({
    super.key,
    required this.OnSubmit,
    required this.imei,
  });
  final Function(String username, String password) OnSubmit;
  final String imei;

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isPassVisible = true;
  String appName = "";
  String packageName = "";
  String version = "";
  String buildNumber = "";

  @override
  void initState() {
    super.initState();

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        appName = packageInfo.appName;
        packageName = packageInfo.packageName;
        version = packageInfo.version;
        buildNumber = packageInfo.buildNumber;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: TextField(
            controller: _username,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(left: 2, top: 2, bottom: 2, right: 20),
              prefixIcon: const Icon(
                Icons.person_2,
                color: appSecondaryColor,
              ),
              hintText: "Enter UserName",
              filled: true,
              fillColor: Colors.grey.shade300,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: TextField(
            controller: _password,
            obscureText: isPassVisible,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(left: 2, top: 2, bottom: 2, right: 20),
              prefixIcon: Icon(
                Icons.password_rounded,
                color: Colors.blue.shade800,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  isPassVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.blue.shade800,
                ),
                onPressed: () {
                  setState(() {
                    isPassVisible = !isPassVisible;
                  });
                },
              ),
              hintText: "Enter Password",
              filled: true,
              fillColor: Colors.grey.shade300,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(13.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              backgroundColor: appSecondaryBtnColor,
              minimumSize: const Size(double.infinity, 40),
            ),
            onPressed: () {
              widget.OnSubmit(_username.text, _password.text);
            },
            child: const Text(
              "Login",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Version No . ${version.toString()}(Build No. ${buildNumber.toString()})",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
              const Text(
                "Developed by I.T. Department , Corporate Office, PGVCL",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
              Text(
                "Your device unique ID is :${widget.imei}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
