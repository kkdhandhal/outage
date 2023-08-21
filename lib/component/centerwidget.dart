import 'package:flutter/material.dart';
import 'package:outage/api/userapi.dart';
import 'package:outage/pages/Home.dart';
import 'package:outage/pages/Initdata_realm.dart';
import 'package:outage/pages/Initdata_sqlite.dart';
import 'package:realm/realm.dart';

import '../model/user.dart';

class CenterWidget extends StatefulWidget {
  final Size size;
  CenterWidget({Key? key, required this.size}) : super(key: key);

  @override
  State<CenterWidget> createState() => _CenterWidgetState();
}

class _CenterWidgetState extends State<CenterWidget> {
  String msg = "";
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  void _onCheckLogin() async {
    Login lgn = Login(usr_name: _username.text, usr_pass: _password.text);
    Users user = await UserAPI.checkLogin(lgn);
    print("Responce uSername is" + user.usr_firstname);
    if (user.usr_id != 0) {
      setState(() {
        msg = "Login successful";
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => InitdataSQLite(
                usr: user,
              )));
    } else {
      setState(() {
        msg = "Username and Password are Wrong";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        width: widget.size.width * 0.90,
        height: widget.size.height * 0.50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Color.fromARGB(255, 74, 52, 153),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                msg,
                style: TextStyle(color: Colors.red),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: _username,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 2, top: 2, bottom: 2, right: 20),
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
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 2, top: 2, bottom: 2, right: 20),
                  prefixIcon: Icon(
                    Icons.password_rounded,
                    color: Colors.blue.shade800,
                  ),
                  suffixIcon: Icon(
                    Icons.visibility,
                    color: Colors.blue.shade800,
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
                ),
                onPressed: () {
                  _onCheckLogin();
                },
                child: Text("Login"),
              ),
            ),
          ],
        ),
      ),

      // child: ClipRect(
      //   child: BackdropFilter(
      //     filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
      //     child: Container(
      //       width: size.width * 0.90,
      //       height: size.height * 0.50,
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(30.0),
      //         color: Color.fromARGB(255, 219, 202, 236).withOpacity(0.3),
      //       ),
      //       child: const Center(
      //         child: Text(
      //           "Censored",
      //           style: TextStyle(fontSize: 30),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
