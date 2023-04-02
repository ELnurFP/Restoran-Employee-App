import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/constants/color_constant.dart';

class FontConst {
  static final font = TextStyle(
    // fontFamily: 'Poppins',
    height: 1,
    fontWeight: FontWeight.w500,
    color: ColorConst.almostBlack,
    fontSize: 16.sp,
  );

  ///Singleton factory
  static final FontConst _instance = FontConst._internal();

  factory FontConst() {
    return _instance;
  }

  FontConst._internal();
}

extension W500 on TextStyle {
  TextStyle w500() {
    return copyWith(fontWeight: FontWeight.w500);
  }

  TextStyle w400() {
    return copyWith(fontWeight: FontWeight.w500);
  }

  TextStyle w600() {
    return copyWith(fontWeight: FontWeight.w600);
  }

  TextStyle w700() {
    return copyWith(fontWeight: FontWeight.w700);
  }

  //size

  TextStyle px10() {
    return copyWith(fontSize: 10.sp);
  }

  TextStyle px12() {
    return copyWith(fontSize: 12.sp);
  }

  TextStyle px14() {
    return copyWith(fontSize: 14.sp);
  }

  TextStyle px16() {
    return copyWith(fontSize: 16.sp);
  }

  TextStyle px20() {
    return copyWith(fontSize: 20.sp);
  }

  TextStyle px18() {
    return copyWith(fontSize: 18.sp);
  }

  TextStyle px22() {
    return copyWith(fontSize: 22.sp);
  }

  TextStyle px24() {
    return copyWith(fontSize: 24.sp);
  }

  TextStyle px26() {
    return copyWith(fontSize: 26.sp);
  }

  TextStyle px36() {
    return copyWith(fontSize: 36.sp);
  }

  TextStyle c(Color color) {
    return copyWith(color: color);
  }
}
