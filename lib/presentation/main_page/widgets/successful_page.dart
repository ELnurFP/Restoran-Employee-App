import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/constants/color_constant.dart';
import 'package:template/constants/font_constant.dart';
import 'package:template/constants/image_constant.dart';
import 'package:template/language/localization.dart';

import 'package:template/presentation/widgets/main_buton.dart';

import '../main_page.dart';

class SuccessfullPage extends StatelessWidget {
  const SuccessfullPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations t = AppLocalizations.of(context)!;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 140.h),
            Text(t.translate('successfull'),
                style: FontConst.font.px22().w600().copyWith(
                      color: ColorConst.secondary,
                    )),
            SizedBox(height: 21.h),
            Image.asset(
              ImageConst.check,
              height: 170.w,
            ),
            SizedBox(height: 34.h),
            SizedBox(
              width: 230.w,
              child: Text(
                t.translate("successPageNote"),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 50.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 100.w),
              child: mainButton(context, () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const MainPage()),
                    (route) => false);
              }, t.translate('continue')),
            ),
          ],
        ),
      ),
    );
  }
}
