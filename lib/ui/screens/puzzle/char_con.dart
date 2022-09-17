import 'package:dogventurehq/constants/strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class CharCon extends StatelessWidget {
  final String char;
  bool? noMargin;
  VoidCallback? onTapFn;
  Color? bgClr;
  CharCon({
    Key? key,
    required this.char,
    this.noMargin,
    this.onTapFn,
    this.bgClr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFn,
      child: Container(
        width: 60.w,
        height: 65.h,
        margin: noMargin == null ? const EdgeInsets.all(5) : EdgeInsets.zero,
        decoration: BoxDecoration(
          color: bgClr ?? Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Center(
          child: Text(
            char,
            style: TextStyle(
              fontSize: 40.sp,
              color: bgClr != null ? Colors.white : Colors.black,
              fontWeight: FontWeight.w900,
              fontFamily: ConstantStrings.kFontSignika,
            ),
          ),
        ),
      ),
    );
  }
}
