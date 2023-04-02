import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color_constant.dart';

class Shadows {
  static List<BoxShadow> shadow1 = [
    BoxShadow(
      color: ColorConst.almostBlack.withOpacity(0.1),
      blurRadius: 15.r,
      offset: Offset(
        0,
        5.h,
      ),
    )
  ];
//
}
