import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medibot/app/widgets/text_field.dart';

class ForwardButton extends StatelessWidget {
  final String text;
  final double width;
  final double iconSize;
  final double? adjustableWidth;
  final EdgeInsetsGeometry padding;
  final Function() onPressed;

  const ForwardButton(
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
    return SizedBox(
      width: width,
      child: InkWell(
        onTap: onPressed,
        splashColor: Colors.black,
        child: Stack(
          children: [
            Container(
              width: adjustableWidth != 0 ? adjustableWidth : width * 0.9,
              padding: padding,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(17.r),
                  bottomLeft: Radius.circular(17.r),
                ),
              ),
              child: CustomTextField(
                fontWeight: FontWeight.w700,
                size: 18.sp,
                text: text,
                color: Colors.black,
              ),
            ),
            Positioned(
              right: 0,
              top: padding.vertical / 2.2,
              child: SvgPicture.asset(
                'assets/images/arrow_forward.svg',
                height: iconSize,
              ),
            )
          ],
        ),
      ),
    );
  }
}
