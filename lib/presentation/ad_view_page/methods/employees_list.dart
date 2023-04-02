// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:template/language/localization.dart';

import '../../../constants/constants.dart';

Widget employeesList(
    ValueNotifier show, String title, bool isEmpty, AppLocalizations t) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      InkWell(
        onTap: () {
          show.value = !show.value;
        },
        child: Row(
          children: [
            title == ''
                ? const SizedBox()
                : Text(
                    title,
                    style: FontConst.font.px16().w500().c(
                          ColorConst.dark,
                        ),
                  ),
            SizedBox(
              width: 10.w,
            ),
            if (!isEmpty)
              ValueListenableBuilder(
                valueListenable: show,
                builder: (context, value, child) {
                  return Padding(
                    padding: EdgeInsets.all(20.0.w),
                    child: SvgPicture.asset(
                        value ? IconConst.upArrow : IconConst.downArrow,
                        width: 15.w,
                        color: ColorConst.dark),
                  );
                },
              ),
            if (isEmpty)
              Text(
                "(${t.translate("empty")})",
                style: FontConst.font.px16().w500().c(
                      ColorConst.dark,
                    ),
              )
          ],
        ),
      ),
      const Spacer(),
    ],
  );
}
