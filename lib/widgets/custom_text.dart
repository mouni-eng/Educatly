import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    this.color,
    required this.fontSize,
    required this.text,
    this.maxlines,
    this.textDecoration,
    this.height,
    this.fontWeight,
    this.align,
    this.textOverflow = TextOverflow.ellipsis,
  });

  final String text;
  final double fontSize;
  final Color? color;
  final TextAlign? align;
  final TextDecoration? textDecoration;
  final FontWeight? fontWeight;
  final double? height;
  final int? maxlines;
  final TextOverflow? textOverflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxlines,
      style: TextStyle(
        fontSize: fontSize,
        color: color ?? Theme.of(context).primaryColorDark,
        height: height,
        decoration: textDecoration,
        fontWeight: fontWeight,
        overflow: textOverflow,
      ),
    );
  }
}
