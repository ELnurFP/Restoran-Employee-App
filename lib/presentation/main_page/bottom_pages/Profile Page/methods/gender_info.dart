// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:template/language/localization.dart';

import '../../../../../constants/color_constant.dart';
import '../../../../../constants/font_constant.dart';
import '../../../../../constants/icon_constant.dart';

Row genderInfo(AppLocalizations t, String? gender, bool isBirthdayShowen) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CircleAvatar(
        backgroundColor: const Color(0xff93D6F4),
        radius: 12.5.r,
        child: SvgPicture.asset(
          gender == "0" ? IconConst.man : IconConst.woman,
          color: ColorConst.primary,
          height: 12.5.r,
          width: 12.5.r,
        ),
      ),
      SizedBox(width: 10.w),
      SizedBox(
        width: 280.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              gender == '0'
                  ? t.translate('male')
                  : gender == '1'
                      ? t.translate('female')
                      : t.translate("unknown"),
              style:
                  FontConst.font.w500().px14().copyWith(color: ColorConst.dark),
            ),
            SizedBox(height: 5.h),
            Text(
              t.translate("gender"),
              style: FontConst.font.w400().px12().copyWith(
                    color: ColorConst.subtitleColor,
                  ),
            ),
            SizedBox(height: 7.h),
            if (isBirthdayShowen)
              Divider(
                color: ColorConst.dviderColor,
                height: 1.h,
              ),
          ],
        ),
      )
    ],
  );
}
