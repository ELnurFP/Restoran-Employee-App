// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:template/configs/base64_conventer.dart';
import 'package:template/constants/constants.dart';
import "dart:math" as math;

import 'package:template/language/localization.dart';

Future<dynamic> succesedPromocodeDialogBox(BuildContext context,
    {String? img, String? title, String? description}) {
  AppLocalizations? t = AppLocalizations.of(context);
  print('img $img');
  return showDialog(
    context: context,
    builder: (BuildContext context) => Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: SizedBox(
        //  height: 370.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            img == null && img == ''
                ? Image.asset(
                    ImageConst.promocode,
                    fit: BoxFit.fitWidth,
                  )
                : Image.network('$img',
                    fit: BoxFit.fitWidth,
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                      if (wasSynchronouslyLoaded) {
                        return child;
                      }
                      return AnimatedOpacity(
                        opacity: frame == null ? 0 : 1,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeOut,
                        child: child,
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          color: ColorConst.secondary,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                          ImageConst.promocode,
                          fit: BoxFit.fitWidth,
                        )),
            SizedBox(height: 5.h),
            Transform.rotate(
              angle: -math.pi / 6,
              child: SvgPicture.asset(
                IconConst.promocode,
                color: ColorConst.secondary,
                width: 50.r,
                height: 50.r,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              title != null && title != ''
                  ? title.fromBase64
                  : t!.translate('downloadedSuccessfully'),
              style: FontConst.font.w600().px18().copyWith(
                    color: ColorConst.secondary,
                  ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 5.h),
              child: Text(
                description != null && description != ''
                    ? description.fromBase64
                    : '', //TODO:  nezerden kecir
                style:
                    FontConst.font.w400().px16().copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Future<dynamic> succesedDialogBox(BuildContext context,
    {String? img, String? title, String? description}) {
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
              t!.translate("successfull"),
              style: FontConst.font.w600().px22().copyWith(
                    color: ColorConst.secondary,
                  ),
            ),
            SizedBox(height: 43.h),
            Image.asset(
              ImageConst.check,
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
                  backgroundColor: ColorConst.secondary,
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
