// ignore_for_file: deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:template/language/localization.dart';

import '../../../constants/constants.dart';

GestureDetector employeeCardButton(Function() onTap, AppLocalizations t,
    {bool isYes = true, bool isCalcel = false}) {
  return GestureDetector(
    onTap: () {
      onTap();
      if (kDebugMode) {
        print(isYes);
        print(isCalcel);
      }
    },
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 6.h,
      ),
      decoration: BoxDecoration(
        color: isYes ? ColorConst.yesColor : ColorConst.noColor,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isCalcel
              ? const SizedBox()
              : SvgPicture.asset(
                  isYes ? IconConst.yes : IconConst.no,
                  color:
                      isYes ? const Color(0xff19B744) : const Color(0xffCB0000),
                  height: 9.r,
                ),
          SizedBox(width: 5.w),
          Text(
            isYes
                ? t.translate('yes')
                : isCalcel
                    ? t.translate('cancel')
                    : t.translate('no'),
            style: FontConst.font.px12().w400().copyWith(
                  color:
                      isYes ? const Color(0xff19B744) : const Color(0xffCB0000),
                ),
          ),
        ],
      ),
    ),
  );
}
