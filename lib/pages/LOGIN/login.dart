import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:outage/component/gradienttext.dart';
import 'package:outage/model/login/user.dart';
import 'package:outage/pages/LOGIN/centerwidget.dart';
import 'package:outage/pages/LOGIN/logintext.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  //final TextEditingController _username = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    //importFeeder();

    super.dispose();
  }

  Widget topWidget(double screenwidth) {
    return Transform.rotate(
      angle: -35 * math.pi / 180,
      child: Container(
        width: 1.2 * screenwidth,
        height: 1.2 * screenwidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150),
          gradient: const LinearGradient(
            begin: Alignment(-0.2, -0.8),
            end: Alignment.bottomCenter,
            colors: [
              // Color.fromARGB(179, 141, 195, 201),
              // Color.fromARGB(179, 31, 197, 219),
              // Color(0x007CBFCF),
              // Color(0xB316BFC4),
              Color.fromARGB(255, 79, 5, 190),
              Color.fromARGB(179, 161, 217, 219),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomWidget(double screenwidth) {
    return Container(
      width: 1.5 * screenwidth,
      height: 1.5 * screenwidth,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment(0.9, -1.1),
          end: Alignment(-0.7, 0.8),
          colors: [
            // Color.fromARGB(179, 141, 195, 201),
            // Color.fromARGB(179, 31, 197, 219),
            Color.fromARGB(255, 137, 99, 226),
            Color(0xDB4BE8CC),

            // Color(0x005CDBCF),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -160,
            left: -35,
            child: topWidget(screensize.width),
          ),
          Positioned(
            top: 480,
            left: -40,
            child: bottomWidget(screensize.width),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              width: screensize.width * 0.90,
              height: screensize.height * 0.52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: const Color.fromARGB(255, 74, 52, 153),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          GradientText(
                            text: "OMS",
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 164, 138, 226),
                                Color.fromARGB(255, 126, 81, 233),
                                Color.fromARGB(255, 164, 138, 226),
                                Color.fromARGB(255, 136, 89, 247),
                              ],
                            ),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                            ),
                          ),
                          GradientText(
                            text: "( Outage Management System )",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 164, 138, 226),
                                Color.fromARGB(255, 207, 189, 250),
                                Color.fromARGB(255, 126, 81, 233),
                                Color.fromARGB(255, 164, 138, 226),
                                Color.fromARGB(255, 207, 189, 250),
                                Color.fromARGB(255, 136, 89, 247),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CenterWidget(size: screensize),
                ],
              ),
            ),
          ), //CenterWidget(size: screensize),
        ],
      ),
    );
  }
}
