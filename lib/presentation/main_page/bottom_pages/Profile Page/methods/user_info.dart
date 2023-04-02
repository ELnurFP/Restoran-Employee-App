import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:template/configs/base64_conventer.dart';
import 'package:template/constants/color_constant.dart';
import 'package:template/dependency_injection.dart';
import 'package:template/language/localization.dart';

import '../../../../../constants/font_constant.dart';
import '../../../../../models/profile_info_res_model.dart';
import 'build_star_raiting.dart';

SizedBox userInfo(String? name, String? position, List<UserStatue> userStatus,
    double? rate, String? notGo, AppLocalizations t,
    {bool isView = false}) {
  print('rate $rate');
  rate = rate == null || rate == 0.0 ? 5 : rate;
  return SizedBox(
    height: notGo != 'null' ? 110.h : 100.h,
    child: Column(
      children: [
        Text(
          name!,
          style: FontConst.font.w500().px16().copyWith(color: ColorConst.dark),
        ),
        SizedBox(height: 7.h),
        Text(
          userStatus.where((element) => element.id == position).isNotEmpty
              ? userStatus
                  .where((element) => element.id == position)
                  .first
                  .name!
                  .fromBase64
              : ' ',
          style: FontConst.font
              .w500()
              .px14()
              .copyWith(color: const Color(0xFF9C9C9C)),
        ),
        SizedBox(height: 10.h),
        locator.get<GetStorage>().read('role') == 'Roles.Worker' || isView
            ? buildStarRating(rate, size: 30.h)
            : const SizedBox(),
        (notGo ?? '0') != '0' ? SizedBox(height: 10.h) : const SizedBox(),
        notGo != '0' &&
                notGo != 'null' &&
                notGo != null &&
                locator.get<GetStorage>().read('role') == 'Roles.Worker'
            ? SizedBox(
                height: 20.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      t.translate("notGo"),
                      style: FontConst.font
                          .px12()
                          .w600()
                          .c(const Color(0xffEF3910)),
                    ),
                    SizedBox(width: 5.w),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: const Color(0xffEF3910),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //   SizedBox(height: 2.h),
                          Text(
                            (notGo),
                            textAlign: TextAlign.center,
                            style: FontConst.font
                                .px12()
                                .w600()
                                .c(Colors.white)
                                .copyWith(
                                  height: 1.2,
                                ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            : const SizedBox(),
      ],
    ),
  );
}
