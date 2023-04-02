// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/color_constant.dart';
import '../../constants/font_constant.dart';
import '../../constants/icon_constant.dart';

SizedBox premiumButton(Function() onTap, String text) {
  return SizedBox(
    width: double.infinity,
    height: 47.h,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13.r),
        ),
        backgroundColor: ColorConst.premiumColor,
      ),
      onPressed: () => onTap.call(),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              IconConst.crown,
              width: 25.w,
              color: Colors.black,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              text,
              style: FontConst.font.px16().w500().copyWith(color: Colors.black),
            ),
          ],
        ),
      ),
    ),
  );
}
