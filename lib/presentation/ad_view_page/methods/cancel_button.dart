import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/language/localization.dart';

import '../../../constants/color_constant.dart';
import '../../../constants/font_constant.dart';

Row cancelButton(Function() onTap, AppLocalizations t) {
  return Row(
    children: [
      Expanded(
          child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConst.cancelColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        onPressed: onTap,
        child: Text(
          t.translate("cancel"),
          style: FontConst.font.px16().w500().c(
                ColorConst.primary,
              ),
        ),
      ))
    ],
  );
}
