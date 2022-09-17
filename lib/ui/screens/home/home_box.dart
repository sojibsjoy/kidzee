import 'package:dogventurehq/constants/strings.dart';
import 'package:dogventurehq/ui/widgets/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBox extends StatelessWidget {
  final Color bgClr;
  final VoidCallback onTapFn;
  final String img;
  final String title;
  final Color titleClr;
  final String subTitle;
  const HomeBox({
    Key? key,
    required this.bgClr,
    required this.onTapFn,
    required this.img,
    required this.title,
    required this.titleClr,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFn,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        height: 220.h,
        width: 150.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: bgClr,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              img,
              height: 60,
            ),
            addH(10.h),
            Text(
              title,
              style: TextStyle(
                fontFamily: ConstantStrings.kFontPermanentMarker,
                fontSize: 23.sp,
                color: titleClr,
              ),
            ),
            addH(5.h),
            Text(
              subTitle,
              style: TextStyle(
                fontFamily: ConstantStrings.kFontHandlee,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
