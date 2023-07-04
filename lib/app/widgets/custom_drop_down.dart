import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDown extends StatelessWidget {
  final double boxHeight;
  final double boxWidth;
  final EdgeInsetsGeometry margin;
  final List<DropdownMenuItem> items;
  final Color dropDownColor;
  final String value;
  final Color focusColor;
  final Function(String) onChange;

  const CustomDropDown(
      {required this.boxHeight,
      required this.boxWidth,
      required this.items,
      required this.margin,
      required this.value,
      required this.dropDownColor,
      required this.focusColor,
      required this.onChange,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: boxHeight,
      width: boxWidth,
      margin: margin,
      child: DropdownButtonFormField(
        focusColor: focusColor,
        value: value,
        dropdownColor: dropDownColor,
        decoration: InputDecoration(
          fillColor: dropDownColor,
          focusColor: dropDownColor,
          filled: true,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black26,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black26,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black26,
            ),
          ),
          hintText: '',
          hintStyle: TextStyle(
            fontFamily: 'Sansation',
            fontSize: 13.sp,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        items: items,
        onChanged: (value) {
          onChange(value);
        },
      ),
    );
  }
}
