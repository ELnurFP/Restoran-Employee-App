// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/color_constant.dart';
import '../../constants/font_constant.dart';

Widget IconAndText(String icon, String text, Color iconColor, {double? width}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.h),
    child: Row(
      children: [
        SvgPicture.asset(
          icon,
          color: iconColor,
          height: 14.w,
          width: 14.w,
        ),
        SizedBox(
          width: 9.w,
        ),
        Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: SizedBox(
            width: width,
            child: Text(
              text,
              style: FontConst.font
                  .w400()
                  .c(
                    ColorConst.dark,
                  )
                  .copyWith(fontSize: 11.sp),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
      ],
    ),
  );
}
