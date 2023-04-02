// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class ColorConst {
  static const primary = Color(0xFFFFFFFF);
  static const secondary = Color(0xFF3E8937);
  static const secondaryDark = Color(0xFF286522);
  static const titleAppbar = Color(0xFF504949);
  static const dark = Color(0xFF333232);
  static const secondaryBorderSupporter = Color(0xFFA9C6A6);
  static const BCBABA = Color(0xFFBCBABA);
  static const contBack = Color(0xFFFAFAFA);
  static const lightDark = Color(0xFF878787);
  static const almostBlack = Color(0xFF151515);
  static const whiteSupporter = Color(0xFFF5F5F5);
  static const hint = Color(0xFFB5B5B5);
  static const border = Color(0xFFE2E2E2);
  static const black = Color(0xFF000000);
  static const red = Color(0xFFFB0000);
  static const cancelColor = Color(0xFFFA0C0C);
  static const blue = Color(0xFF4478FC);
  static const orange = Color(0xFFF8935B);
  static const orangeStatus = Color(0xFFFF8B49);
  static const purpleW100 = Color(0xFFE9D7FF);
  static const purpleW500 = Color(0xFF53278A);
  static const dviderColor = Color(0xFFB0B0B0);
  static const softTextColor = Color(0xff949494);
  static const subtitleColor = Color(0xff9D9D9D);
  static const seeColors = Color(0xffE4E4E4);
  static const yesColor = Color(0xffA3F6BA);
  static const noColor = Color(0xffFD8787);
  static const idColor = Color(0xff4FAB30);
  static const disabledColor = Color(0xffACACAC);
  static const premiumColor = Color(0xffDBA932);
  static const doneColor = Color(0xff99DB71);
  static const showColor = Color(0xffFFB340);
  static const ekonomColor = Color(0xff5BBB3A);
  static const exspressColor = Color(0xffE59801);
  static const ligtGrey = Color(0xff848484);

  ///Singleton factory
  static final ColorConst _instance = ColorConst._internal();

  factory ColorConst() {
    return _instance;
  }

  ColorConst._internal();
}
