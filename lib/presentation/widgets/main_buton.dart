// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/constants.dart';

Widget mainButton(
  BuildContext context,
  Function() onTap,
  String text, {
  bool isWhite = false,
  bool isRed = false,
}) {
  return SizedBox(
    width: double.infinity,
    height: 45.h,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13.r),
        ),
        backgroundColor: isWhite ? Colors.white : ColorConst.secondary,
        side: isWhite
            ? BorderSide(
                color: ColorConst.secondary,
                width: 1.w,
              )
            : null,
      ),
      onPressed: () => onTap(),
      child: Center(
        child: Text(text,
            style: FontConst.font.px16().w500().copyWith(
                color: isWhite
                    ? isRed
                        ? Colors.red
                        : ColorConst.secondary
                    : Colors.white)),
      ),
    ),
  );
}

Widget registerButton(BuildContext context, Function() onTap, String text) {
  return SizedBox(
    width: double.infinity,
    height: 45.h,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13.r),
        ),
        backgroundColor: ColorConst.secondary,
        side: BorderSide(
          color: ColorConst.secondary,
          width: 1.w,
        ),
      ),
      onPressed: () => onTap(),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,
                style:
                    FontConst.font.px16().w500().copyWith(color: Colors.white)),
            SizedBox(width: 10.w),
            SvgPicture.asset(
              IconConst.register,
              color: Colors.white,
              width: 20.w,
              height: 20.h,
            ),
          ],
        ),
      ),
    ),
  );
}
