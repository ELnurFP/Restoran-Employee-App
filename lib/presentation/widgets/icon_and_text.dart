// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:template/constants/constants.dart';

iconAndText(String icon, String title, Color iconColor) {
  return Padding(
    padding: EdgeInsets.only(bottom: 11.h),
    child: SizedBox(
      height: 20.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SvgPicture.asset(
            icon,
            color: iconColor,
            height: 14.w,
            width: 14.w,
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            title,
            style: FontConst.font.px12().w400().c(
                  ColorConst.dark,
                ),
          )
        ],
      ),
    ),
  );
}
