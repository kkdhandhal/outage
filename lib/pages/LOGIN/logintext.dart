import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:outage/model/login/user.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({
    super.key,
    required this.OnSubmit,
  });
  final Function(String username, String password) OnSubmit;

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isPassVisible = false;

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
          padding: const EdgeInsets.all(15.0),
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
      ],
    );
  }
}
