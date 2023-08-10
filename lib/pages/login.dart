import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:outage/component/centerwidget.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
          CenterWidget(size: screensize),
        ],
      ),
    );
  }
}
