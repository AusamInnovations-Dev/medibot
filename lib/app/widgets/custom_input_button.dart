import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medibot/app/widgets/text_field.dart';

class InputButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final double textsize;
  final FontWeight fontWeight;
  final Function() onPressed;
  const InputButton(
      {required this.height,
      required this.width,
      required this.text,
      required this.fontWeight,
      required this.textsize,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        //minimumSize: Size(MediaQuery.of(context).size.width / 5, 0),
        shadowColor: Colors.white,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(6.r),
          ),
        ),
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: CustomTextField(
            textAlign: TextAlign.center,
            color: Colors.black,
            size: textsize,
            fontWeight: fontWeight,
            text: text,
            maxLines: 2,
          ),
        ),
      ),
    );
  }
}
