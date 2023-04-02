import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:template/constants/color_constant.dart';
import 'package:template/language/localization.dart';

import '../../constants/font_constant.dart';
import '../../constants/image_constant.dart';
import '../../dependency_injection.dart';
import '../main_page/main_page.dart';

class IntroPages extends StatefulWidget {
  const IntroPages({Key? key}) : super(key: key);

  @override
  State<IntroPages> createState() => _IntroPagesState();
}

class _IntroPagesState extends State<IntroPages> {
  final box = locator.get<GetStorage>();

  void donePressed(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
      return const MainPage();
    }), (context) => false);
  }

  void skipPressed(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
      return const MainPage();
    }), (context) => false);
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations? t = AppLocalizations.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: box.read('role') == 'Roles.Owner'
                  ? t!.translate("ownerIntro1Title")
                  : t!.translate("workerIntro1Desc"),
              body: box.read('role') == 'Roles.Owner'
                  ? t.translate("ownerIntro1Desc")
                  : t.translate("workerIntro2Desc"),
              image: Center(
                child: Image.asset(
                  box.read('role') == 'Roles.Owner'
                      ? ImageConst.intro1
                      : ImageConst.intro2,
                  height: 232.h,
                ),
              ),
              decoration: PageDecoration(
                imagePadding: EdgeInsets.only(top: 150.h),
                titlePadding: EdgeInsets.symmetric(
                  vertical: 20.h,
                ),
                contentMargin: EdgeInsets.symmetric(
                  vertical: 10.h,
                ),
                titleTextStyle: FontConst.font.w600().px18().c(
                      ColorConst.secondaryDark,
                    ),
                bodyTextStyle: FontConst.font.w400().px14().c(
                      ColorConst.lightDark,
                    ),
              ),
            ),
            PageViewModel(
              title: box.read('role') == 'Roles.Owner'
                  ? t.translate("ownerIntro2Title")
                  : t.translate("workerIntro2Title"),
              body: box.read('role') == 'Roles.Owner'
                  ? t.translate("ownerIntro2Desc")
                  : t.translate("workerIntro2Desc"),
              image: Center(
                child: Image.asset(
                  box.read('role') == 'Roles.Owner'
                      ? ImageConst.intro2
                      : ImageConst.intro4,
                  height: 232.h,
                ),
              ),
              decoration: PageDecoration(
                imagePadding: EdgeInsets.only(top: 150.h),
                titlePadding: EdgeInsets.symmetric(
                  vertical: 20.h,
                ),
                contentMargin: EdgeInsets.symmetric(
                  vertical: 10.h,
                ),
                titleTextStyle: FontConst.font.w600().px18().c(
                      ColorConst.secondaryDark,
                    ),
                bodyTextStyle: FontConst.font.w400().px14().c(
                      ColorConst.lightDark,
                    ),
              ),
            ),
            PageViewModel(
              title: box.read('role') == 'Roles.Owner'
                  ? t.translate("ownerIntro3Title")
                  : t.translate("workerIntro3Title"),
              body: box.read('role') == 'Roles.Owner'
                  ? t.translate("ownerIntro3Desc")
                  : t.translate("workerIntro3Desc"),
              image: Center(
                child: Image.asset(
                  box.read('role') == 'Roles.Owner'
                      ? ImageConst.intro3
                      : ImageConst.intro5,
                  height: 232.h,
                ),
              ),
              decoration: PageDecoration(
                imagePadding: EdgeInsets.only(top: 150.h),
                titlePadding: EdgeInsets.symmetric(
                  vertical: 20.h,
                ),
                contentMargin: EdgeInsets.symmetric(
                  vertical: 10.h,
                ),
                titleTextStyle: FontConst.font.w600().px18().c(
                      ColorConst.secondaryDark,
                    ),
                bodyTextStyle: FontConst.font.w400().px14().c(
                      ColorConst.lightDark,
                    ),
              ),
            )
          ],
          showSkipButton: true,
          skip: Text(
            t.translate("skip"),
            style: FontConst.font.w500().px16().c(ColorConst.lightDark),
          ),
          next: Text(
            t.translate("next"),
            style: FontConst.font.w500().px16(),
          ),
          doneStyle: ButtonStyle(
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
            ),
            backgroundColor: MaterialStateProperty.resolveWith(
              (state) {
                if (state.contains(MaterialState.pressed)) {
                  return ColorConst.secondaryDark;
                }
                return ColorConst.secondary;
              },
            ),
          ),
          done: Text(
            t.translate("done"),
            style: FontConst.font.w500().px16().c(ColorConst.primary),
          ),
          onDone: () {
            donePressed(context);
          },
          onSkip: () {
            skipPressed(context);
          },
          dotsDecorator: DotsDecorator(
            size: Size.square(10.0.r),
            activeSize: Size(20.0.w, 10.0.h),
            activeColor: ColorConst.almostBlack,
            color: ColorConst.titleAppbar,
            spacing: EdgeInsets.symmetric(horizontal: 3.0.w),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0.r)),
          ),
        ),
      ),
    );
  }
}
