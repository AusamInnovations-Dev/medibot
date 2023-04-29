import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomInputField extends StatelessWidget {
  final double boxWidth;
  final double boxHeight;
  final String hintText;
  final String fontTheme;

  final TextEditingController? textController;
  const CustomInputField(
      {required this.boxHeight,
      required this.boxWidth,
      required this.hintText,
      this.textController,
      required this.fontTheme,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(5.r),
      ),
      width: boxWidth,
      height: boxHeight,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: textController,
        style: TextStyle(fontFamily: fontTheme, fontSize: 17),
        decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: 17, fontFamily: fontTheme),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
