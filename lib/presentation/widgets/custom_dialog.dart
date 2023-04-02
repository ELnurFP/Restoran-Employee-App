import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/constants/color_constant.dart';
import 'package:template/constants/font_constant.dart';
import 'package:template/language/localization.dart';

Future<dynamic> customDialogBox(
    BuildContext context, Function() onTap, String content, AppLocalizations t,
    {String? title}) {
  return showDialog(
    context: context,
    builder: (context) => Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 15.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: Container(
        width: 349.w,
        padding: EdgeInsets.only(
          top: 16.h,
          bottom: 22.h,
          left: 23.w,
          right: 18.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title ?? t.translate("cancelPage"),
              style: FontConst.font.w600().px16().copyWith(
                    color: ColorConst.dark,
                  ),
            ),
            SizedBox(height: 10.h),
            Divider(
              color: ColorConst.dviderColor,
              thickness: 1.h,
            ),
            SizedBox(height: 10.h),
            Text(
              content,
              style: FontConst.font.w400().px14().copyWith(
                    color: ColorConst.dark,
                  ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                const Spacer(),
                ElevatedButton(
                  onPressed: onTap,
                  child: Text(
                    t.translate("yes"),
                    style: FontConst.font.w500().px12().copyWith(
                          color: ColorConst.primary,
                        ),
                  ),
                ),
                SizedBox(width: 11.w),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(
                      color: ColorConst.secondary,
                      width: 1.w,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    t.translate("no"),
                    style: FontConst.font.w500().px12().copyWith(
                          color: ColorConst.secondary,
                        ),
                  ),
                ),
                SizedBox(width: 10.w),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
