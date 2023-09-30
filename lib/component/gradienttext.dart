import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  const GradientText(
      {Key? key, required this.text, this.style, required this.gradient});
  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bound) => gradient.createShader(
        Rect.fromLTWH(0, 0, bound.width, bound.height),
      ),
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
