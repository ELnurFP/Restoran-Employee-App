// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:template/configs/base64_conventer.dart';
import 'package:template/constants/color_constant.dart';
import 'package:template/constants/font_constant.dart';
import 'package:template/constants/icon_constant.dart';
import 'package:template/language/localization.dart';

import 'build_star_raiting.dart';

Padding reviewCard(String? name, String? comment, double? start,
    String? workType, AppLocalizations t,
    {String complaint = ""}) {
  return Padding(
    padding: EdgeInsets.only(left: 42.w),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: ColorConst.secondary,
          radius: 12.r,
          child: SvgPicture.asset(
            IconConst.person,
            color: ColorConst.primary,
            height: 12.r,
            width: 12.r,
          ),
        ),
        SizedBox(width: 10.w),
        SizedBox(
          width: 266.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5.h),
              Text(
                name != "null" ? name?.fromBase64 ?? "" : '',
                style: FontConst.font.w600().px14().copyWith(
                      color: ColorConst.dark,
                    ),
              ),
              SizedBox(height: 5.h),
              Text(
                // t.translate("owner") + " · " + '',
                "${t.translate("owner")} · ",
                style: FontConst.font.w400().px12().copyWith(
                      color: ColorConst.subtitleColor,
                    ),
              ),
              SizedBox(height: 5.h),
              complaint == '1'
                  ? Column(
                      children: [
                        Text(
                          t.translate("notGo"),
                          style: FontConst.font
                              .w500()
                              .px12()
                              .copyWith(color: const Color(0xffFF0000)),
                        ),
                        SizedBox(height: 5.h),
                      ],
                    )
                  : const SizedBox(),
              SizedBox(
                width: 250.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildStarRating(start!, size: 15.h),
                    Text(
                      "${t.translate("job")} · ${workType != "null" ? workType?.fromBase64 ?? "" : ''}",
                      style: FontConst.font.w500().px12().copyWith(
                            color: ColorConst.dark,
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 9.h),
              SizedBox(
                width: 258.w,
                child: Text(
                  comment?.fromBase64 ?? "",
                  style: FontConst.font.w400().px12().copyWith(
                        color: ColorConst.dark,
                      ),
                ),
              ),
              SizedBox(height: 7.h),
              Divider(
                color: ColorConst.dviderColor,
                height: 1.h,
              ),
              SizedBox(height: 11.h),
            ],
          ),
        )
      ],
    ),
  );
}
