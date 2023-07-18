import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomInputField extends StatelessWidget {
  final double boxWidth;
  final double boxHeight;
  final String hintText;
  final String? fontTheme;
  final Radius? topl;
  final Radius? topr;
  final Radius? bottoml;
  final Radius? bottomr;
  

  final TextEditingController? textController;
  CustomInputField(
      {required this.boxHeight,
      required this.boxWidth,
      required this.hintText,
      
      this.topl,
      this.topr,
      this.bottoml,
      this.bottomr,
      this.textController,
      this.fontTheme = 'Sansation',
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:  Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.only(
          topLeft: topl ?? Radius.circular(7.r),
          topRight: topr ?? Radius.circular(7.r),
          bottomLeft: bottoml ?? Radius.circular(7.r),
          bottomRight: bottomr ?? Radius.circular(7.r),
        ),
      ),
      width: boxWidth,
      height: boxHeight,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: textController,
        cursorColor: Colors.black,
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
