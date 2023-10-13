import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:outage/model/login/user.dart';
import 'package:outage/utils/constants.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextField(
            controller: _username,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(left: 2, top: 2, bottom: 2, right: 20),
              prefixIcon: Icon(
                Icons.person_2,
                color: Colors.blue.shade800,
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
          padding: const EdgeInsets.all(15.0),
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
              minimumSize: const Size(double.infinity, 40),
            ),
            onPressed: () {
              widget.OnSubmit(_username.text, _password.text);
            },
            child: const Text("Login"),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Version No . $appVersionNo",
                style: TextStyle(
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
