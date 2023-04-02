import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/constants/constants.dart';
import 'package:template/language/localization.dart';

Future<dynamic> failedPromocodeDialogBox(BuildContext context) {
  AppLocalizations? t = AppLocalizations.of(context);
  return showDialog(
    context: context,
    builder: (BuildContext context) => Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: SizedBox(
        height: 370.h,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 34.w,
            ),
            Text(
              t!.translate("failed"),
              style: FontConst.font.w600().px22().copyWith(
                    color: ColorConst.secondary,
                  ),
            ),
            SizedBox(height: 43.h),
            Image.asset(
              ImageConst.xButton,
              width: 131.r,
              height: 131.r,
            ),
            SizedBox(height: 56.h),
            SizedBox(
              width: 114.w,
              height: 30,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: const Color(0xffE21B1B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  t.translate("back"),
                  style: FontConst.font.w500().px16().copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
