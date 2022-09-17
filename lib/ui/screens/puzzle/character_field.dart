import 'package:dogventurehq/constants/strings.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class CharacterField extends StatelessWidget {
  String? char;
  final Color clr;
  bool? noMargin;
  CharacterField({
    Key? key,
    this.char,
    required this.clr,
    this.noMargin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42.w,
      height: 55.h,
      margin: noMargin != null ? EdgeInsets.zero : EdgeInsets.only(right: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            char ?? '',
            style: TextStyle(
              fontSize: 40.sp,
              color: clr,
              fontWeight: FontWeight.w900,
              fontFamily: ConstantStrings.kFontSignika,
            ),
          ),
          DottedLine(
            direction: Axis.horizontal,
            dashLength: 3,
            lineThickness: 3,
            dashGapLength: 3,
            dashColor: clr,
            dashRadius: 10,
          )
        ],
      ),
    );
  }
}
