import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/language/localization.dart';

import '../../../../constants/font_constant.dart';
import '../../../widgets/get_premium.dart';

Container buyPremiumCard(
    double months, double price, Function() onTap, AppLocalizations t) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 20.h),
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.r),
      color: const Color(0xffffffff),
      boxShadow: const [
        BoxShadow(
          color: Color(0x29000000),
          offset: Offset(0, 3),
          blurRadius: 6,
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          months == 1
              ? '$months ${t.translate('month')}'
              : '$months ${t.translate('months')}',
          style: FontConst.font.px14().w600(),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$price AZN*',
              style: FontConst.font.px18().w600(),
            ),
            SizedBox(width: 10.w),
            Text(
              '/${t.translate("month")}',
              style: FontConst.font.px10().w500().copyWith(
                    color: const Color(0xff5B5B5B),
                  ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${months * price} AZN ',
              style: FontConst.font.px10().w500(),
            ),
            Text("${t.translate("every")} ",
                style: FontConst.font
                    .px10()
                    .w500()
                    .copyWith(color: const Color(0xff5B5B5B))),
            Text(
              months == 1 ? '' : '$months ',
              style: FontConst.font.px10().w500(),
            ),
            Text(
              months == 1 ? t.translate('month') : t.translate('months'),
              style: FontConst.font.px10().w500().copyWith(
                    color: const Color(0xff5B5B5B),
                  ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: premiumButton(
            () {
              onTap();
            },
            t.translate("getPremium"),
          ),
        )
      ],
    ),
  );
}
