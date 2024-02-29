import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    super.key,
    required this.gradient,
    this.style,
    this.align,
    this.maxLines,
    this.overFlow,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overFlow;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: style,
        textAlign: align ?? TextAlign.center,
        maxLines: maxLines,
        overflow: overFlow ?? TextOverflow.ellipsis,
      ),
    );
  }
}
