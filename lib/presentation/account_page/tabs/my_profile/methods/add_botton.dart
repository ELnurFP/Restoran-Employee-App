import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../constants/icon_constant.dart';

InkWell addButton(Function() onTap) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.only(left: 15.w),
      child: SvgPicture.asset(IconConst.addFull, height: 25.h),
    ),
  );
}
