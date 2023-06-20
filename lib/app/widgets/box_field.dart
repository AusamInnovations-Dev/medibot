import 'package:flutter/material.dart';

class CustomBox extends StatelessWidget {
  final double boxWidth;
  final double boxHeight;
  final Radius? topLeft;
  final Radius? topRight;
  final Radius? bottomLeft;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? borders;
  final Radius? bottomRight;
  final Color? color;
  final double? offset;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget body;
  const CustomBox(
      {required this.boxHeight,
      required this.boxWidth,
      this.padding,
      this.margin,
      this.topLeft,
      this.boxShadow,
      this.borders,
      this.topRight,
      this.bottomLeft,
      this.bottomRight,
      this.color,
      this.offset,
      required this.body,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: boxWidth,
      height: boxHeight,
      margin: margin ?? EdgeInsets.zero,
      padding: padding ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.primaryContainer,
        border: borders ,
        boxShadow: boxShadow?? [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: Offset(0, offset ?? 4),
          )
        ],
        borderRadius: BorderRadius.only(
            topLeft: topLeft ?? Radius.zero,
            bottomRight: bottomRight ?? Radius.zero,
            bottomLeft: bottomLeft ?? Radius.zero,
            topRight: topRight ?? Radius.zero),
      ),
      child: body,
    );
  }
}
