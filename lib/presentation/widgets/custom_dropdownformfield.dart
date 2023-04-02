import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/constants/constants.dart';
import 'package:template/language/localization.dart';

Widget customDropDownFormField(
  List items, {
  String? hint,
  Function(String?)? onChanged,
  String? initialValue,
  Color? fillColor,
  AppLocalizations? t,
}) {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(7.r),
    borderSide: const BorderSide(
      color: ColorConst.disabledColor,
    ),
  );
  return Expanded(
    child: DropdownButtonFormField<String?>(
      decoration: InputDecoration(
        fillColor: fillColor,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
      ),
      style: FontConst.font.w400().px14().copyWith(
            color: ColorConst.softTextColor,
          ),
      hint: hint != null
          ? Text(
              hint,
              style: FontConst.font.w400().px14().copyWith(
                    color: ColorConst.softTextColor,
                  ),
            )
          : null,
      value: initialValue,
      items: items
          .map(
            (e) => DropdownMenuItem<String?>(
              value: e,
              child: Text(
                e,
                style: FontConst.font.w400().px14().copyWith(
                      color: const Color(0xff3E3C3C),
                    ),
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    ),
  );
}
