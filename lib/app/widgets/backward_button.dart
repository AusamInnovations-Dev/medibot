import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medibot/app/widgets/text_field.dart';

class BackwardButton extends StatelessWidget {
  final String text;
  final double width;
  final double iconSize;
  final double? adjustableWidth;
  final EdgeInsetsGeometry padding;
  final Function() onPressed;
  const BackwardButton(
      {required this.text,
      required this.width,
      this.adjustableWidth = 0,
      required this.iconSize,
      required this.padding,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: 60.h,
      child: InkWell(
        onTap: onPressed,
        child: Stack(
          children: [
            Positioned(
              right: 0,
              child: Container(
                width: adjustableWidth != 0 ? adjustableWidth : width * 0.9,
                padding: padding,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(19.r),
                    bottomRight: Radius.circular(19.r),
                  ),
                ),
                child: CustomTextField(
                  fontWeight: FontWeight.w700,
                  size: 13.sp,
                  text: text,
                  color: Colors.black,
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: padding.vertical / 2.3,
              child: SvgPicture.asset(
                'assets/images/arrow_backward.svg',
                height: iconSize,
              ),
            )
          ],
        ),
      ),
    );
  }
}
