import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WaitCircularWidget extends StatelessWidget {
  const WaitCircularWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 55),
        CircularProgressIndicator(
          backgroundColor: Colors.white,
          color: Colors.red,
        ),
        SizedBox(height: 25),
        Text(
          "Please Wait .....",
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
