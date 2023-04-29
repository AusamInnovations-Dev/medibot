import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medibot/app/widgets/text_field.dart';

class CircularButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Radius? topLeft;
  final Radius? topRight;
  final Radius? bottomLeft;
  final Radius? bottomRight;
  const CircularButton(
      {this.topLeft,
      this.topRight,
      this.bottomLeft,
      this.bottomRight,
      required this.text,
      required this.height,
      required this.width,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: topLeft ?? Radius.zero,
            topRight: topRight ?? Radius.zero,
            bottomLeft: bottomLeft ?? Radius.zero,
            bottomRight: bottomRight ?? Radius.zero,
          ),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        width: width,
        height: height,
        child: CustomTextField(
          textAlign: TextAlign.center,
          color: Colors.black,
          size: 13.sp,
          fontWeight: FontWeight.w700,
          text: text,
          maxLines: 2,
        ),
      ),
    );
  }
}
