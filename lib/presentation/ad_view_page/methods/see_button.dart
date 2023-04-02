import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/language/localization.dart';

import '../../../constants/constants.dart';

GestureDetector seeButton(Function() seeOnTap, AppLocalizations t) {
  return GestureDetector(
    onTap: seeOnTap,
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 5.h,
      ),
      decoration: BoxDecoration(
        color: ColorConst.seeColors,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(t.translate("see"),
              textAlign: TextAlign.center,
              style: FontConst.font.px12().w400().copyWith(height: 1.3)),
          SizedBox(width: 5.w),
          Icon(
            Icons.remove_red_eye,
            size: 13.sp,
            color: Colors.black,
          ),
        ],
      ),
    ),
  );
}
