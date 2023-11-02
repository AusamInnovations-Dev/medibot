import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomInputField extends StatefulWidget {
  final double boxWidth;
  final double boxHeight;
  final String hintText;
  final String? fontTheme;
  final Radius? topl;
  final Radius? topr;
  final Radius? bottoml;
  final Radius? bottomr;
  final TextInputType? type;
  bool? obsecure;
  final bool showSuffix;

  final TextEditingController? textController;
  CustomInputField(
      {required this.boxHeight,
      required this.boxWidth,
      required this.hintText,
      required this.showSuffix,
      this.obsecure,
      this.topl,
      this.type = TextInputType.text,
      this.topr,
      this.bottoml,
      this.bottomr,
      this.textController,
      this.fontTheme = 'Sansation',
      Key? key})
      : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.only(
          topLeft: widget.topl ?? Radius.circular(7.r),
          topRight: widget.topr ?? Radius.circular(7.r),
          bottomLeft: widget.bottoml ?? Radius.circular(7.r),
          bottomRight: widget.bottomr ?? Radius.circular(7.r),
        ),
      ),
      width: widget.boxWidth,
      height: widget.boxHeight,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: widget.textController,
        cursorColor: Colors.black,
        obscureText: widget.obsecure ?? false,
        keyboardType: widget.type,
        style: TextStyle(fontFamily: widget.fontTheme, fontSize: 17),
        decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: 17, fontFamily: widget.fontTheme),
          hintText: widget.hintText,
          border: InputBorder.none,
          suffixIcon: widget.showSuffix
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      widget.obsecure = !(widget.obsecure ?? true);
                    });
                  },
                  icon: Icon(
                    (widget.obsecure ?? true)
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.black,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
