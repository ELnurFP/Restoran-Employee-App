// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:template/constants/constants.dart';

Widget accountCard(String iconName, String title, Function() onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 15.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.h),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.black),
            child: Center(
              child: SvgPicture.asset(
                iconName,
                color: Colors.white,
                height: 18.r,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Text(title,
              style: FontConst.font
                  .w400()
                  .px16()
                  .copyWith(color: const Color(0xFF4E504D))),
        ],
      ),
    ),
  );
}
