import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medibot/app/widgets/text_field.dart';

class CustomTextView extends StatelessWidget {
  final double boxWidth;
  final double boxHeight;
  final String Text;
  final String? fontTheme;
  final Radius? topl;
  final Radius? topr;
  final TextAlign? textAlign;
  final Radius? bottoml;
  final Radius? bottomr;
  final double? size;
  final Color? boxcolor;
  

  final TextEditingController? textController;
  const CustomTextView(
      {required this.boxHeight,
      required this.boxWidth,
      required this.Text,
      this.boxcolor,
      this.size,
      
      this.textAlign,
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
          color: boxcolor ?? Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.only(
            topLeft: topl ?? Radius.circular(5.r),
            topRight: topr ?? Radius.circular(5.r),
            bottomLeft: bottoml ?? Radius.circular(5.r),
            bottomRight: bottomr ?? Radius.circular(5.r),
          ),
        ),
        width: boxWidth,
        height: boxHeight,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 9.h),
        child: CustomTextField(
          fontWeight: FontWeight.w400,
          text: Text,
          color: Colors.black,
          size: size ?? 16.sp,
          textAlign: textAlign ?? TextAlign.start,
        ));
  }
}
