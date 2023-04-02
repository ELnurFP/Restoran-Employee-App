// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../constants/constants.dart';

Row profileContentTitle(String title, String icon) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        padding: EdgeInsets.all(10.r),
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: ColorConst.secondary),
        child: SvgPicture.asset(
          icon,
          color: ColorConst.primary,
          height: 18.r,
        ),
      ),
      SizedBox(width: 10.w),
      Text(
        title,
        style:
            FontConst.font.px16().w600().copyWith(color: ColorConst.secondary),
      )
    ],
  );
}
