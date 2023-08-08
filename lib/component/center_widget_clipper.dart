import 'package:flutter/material.dart';

class CenterWidgetClipper extends CustomClipper<Path> {
  final Path path;
  const CenterWidgetClipper({Key? key, required this.path}) : super(key: key);

  @override
  Path getClip(Size size) {}

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
  }
}
