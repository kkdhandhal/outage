

import 'package:flutter/material.dart';
import 'package:outage/api/userapi.dart';
import 'package:outage/pages/Home.dart';
import 'package:realm/realm.dart';

import '../model/user.dart';

class CenterWidget extends StatelessWidget {
  final Size size;
  const CenterWidget({Key? key, required this.size}) : super(key: key);

  void checkLogin() async {
      Login lgn =Login(usr_name: "kkdhandhal", usr_pass: "12345678")
      Users user = await UserAPI.checkLogin(lgn);

      if(user.usr_id==0){
          
      }
      else{
         
      }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        width: size.width * 0.90,
        height: size.height * 0.50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Color.fromARGB(255, 74, 52, 153),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
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
                onPressed: () {},
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
