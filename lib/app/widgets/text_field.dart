import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final String fontFamily;
  final int maxLines;
  final TextAlign? textAlign;
  final FontWeight fontWeight;
  final TextOverflow overflow;

  const CustomTextField({Key? key,
  this.fontFamily = 'Sansation',
  this.textAlign = TextAlign.start,
  this.color=const Color(0xff00c2cb),
  this.maxLines = 10,
  required this.fontWeight,
  required this.text,
  this.overflow=TextOverflow.ellipsis,
  this.size=0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: fontFamily,
        color: color,
        fontSize: size==0? 16:size,
        fontWeight: fontWeight,
    ),
    );
  }
}