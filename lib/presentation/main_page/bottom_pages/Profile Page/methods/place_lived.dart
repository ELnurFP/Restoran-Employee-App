import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/language/localization.dart';

import '../../../../../constants/constants.dart';

SizedBox placeLived(String? address, AppLocalizations t) {
  if (address == null || address.isEmpty) {
    address = t.translate("currentCity");
  }
  return SizedBox(
    width: 280.w,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          address,
          style: FontConst.font.w500().px14().copyWith(
                color: ColorConst.dark,
              ),
        ),
        SizedBox(height: 5.h),
        Text(
          t.translate("currentCity"),
          style: FontConst.font.w400().px12().copyWith(
                color: ColorConst.subtitleColor,
              ),
        ),
      ],
    ),
  );
}
