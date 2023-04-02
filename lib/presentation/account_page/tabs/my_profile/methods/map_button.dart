import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../constants/constants.dart';

IconButton mapButton(Function() onPressed) {
  return IconButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      icon: Container(
        width: 35.w,
        height: 30.h,
        padding: EdgeInsets.all(3.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: ColorConst.dviderColor, width: 1.w),
        ),
        child: Image.asset(
          ImageConst.map,
          height: 20.r,
        ),
      ));
}
