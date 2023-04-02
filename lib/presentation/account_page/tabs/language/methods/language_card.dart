import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/constants/constants.dart';

Container languageCard(String language, String image) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 40.w),
    child: Column(
      children: [
        Row(
          children: [
            Image.asset(image, width: 45.w),
            SizedBox(width: 22.w),
            Text(
              language,
              style: FontConst.font.w400().px16().copyWith(
                    color: const Color(0xff000000),
                  ),
            ),
          ],
        ),
        SizedBox(height: 11.h),
        Divider(
          color: const Color(0xffCECECE),
          thickness: 1.h,
          height: 0,
        ),
        SizedBox(height: 13.h),
      ],
    ),
  );
}
