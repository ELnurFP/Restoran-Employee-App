// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/color_constant.dart';
import '../constants/font_constant.dart';

class AppTheme {
  static final ThemeData currentTheme = ThemeData(
    scaffoldBackgroundColor: ColorConst.primary,
    primaryColor: ColorConst.secondary,
    fontFamily: "Poppins",
    elevatedButtonTheme: _buttonTheme,
    splashColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.black.withOpacity(0.005),
    appBarTheme: _appBarTheme,
    textTheme: _textTheme,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ColorConst.primary,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    inputDecorationTheme: _inputDecorationThem,
  );

  static final _appBarTheme = AppBarTheme(
    color: Colors.white,
    shadowColor: Colors.transparent,

    elevation: 0,
    iconTheme: const IconThemeData(color: ColorConst.almostBlack),
    actionsIconTheme: const IconThemeData(color: ColorConst.almostBlack),
    centerTitle: true,
    titleTextStyle: FontConst.font.px22().w600().c(ColorConst.titleAppbar),
    systemOverlayStyle: SystemUiOverlayStyle.dark,

    // toolbarTextStyle: TextTheme(headline6: FontConst.BOLD_DEFAULT_20).bodyText2,
    // titleTextStyle: TextTheme(headline6: FontConst.BOLD_DEFAULT_20).headline6,
  );

  static const _textTheme = TextTheme(
    bodyText1: TextStyle(color: ColorConst.almostBlack),
    bodyText2: TextStyle(color: ColorConst.almostBlack),
  );

  static final _inputDecorationThem = InputDecorationTheme(
    filled: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 12.h),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(13.r)),
      borderSide: BorderSide(
        color: ColorConst.secondaryBorderSupporter,
        style: BorderStyle.solid,
        // strokeAlign: StrokeAlign.inside,
        width: 1.r,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(13.r)),
      borderSide: BorderSide(
        color: ColorConst.BCBABA,
        style: BorderStyle.solid,
        //  strokeAlign: StrokeAlign.inside,
        width: 1.r,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(13.r)),
      borderSide: BorderSide(
        color: ColorConst.secondaryBorderSupporter,
        style: BorderStyle.solid,
        //   strokeAlign: StrokeAlign.inside,
        width: 1.r,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(13.r)),
      borderSide: BorderSide(
        color: ColorConst.red,
        style: BorderStyle.solid,
        //  strokeAlign: StrokeAlign.inside,
        width: 1.r,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(13.r)),
      borderSide: BorderSide(
        color: ColorConst.secondary,
        style: BorderStyle.solid,
        //  strokeAlign: StrokeAlign.inside,
        width: 1.r,
      ),
    ),
    errorStyle: FontConst.font.px14().w400().c(
          ColorConst.red,
        ),
    hintStyle: FontConst.font.px14().w400().c(
          ColorConst.BCBABA,
        ),
  );
  static final _buttonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateColor.resolveWith(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return ColorConst.BCBABA;
          }
          return ColorConst.secondary;
        },
      ),
      elevation: MaterialStateProperty.all(1),
      textStyle: MaterialStateProperty.all(
        FontConst.font.px16().w500().c(ColorConst.primary),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(13.r),
          ),
        ),
      ),
      padding: MaterialStateProperty.all(
        EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w
            // horizontal: double.infinity,
            ),
      ),
    ),
  );

  /// Singleton factory
  static final AppTheme _instance = AppTheme._internal();

  factory AppTheme() {
    return _instance;
  }

  AppTheme._internal();
}
