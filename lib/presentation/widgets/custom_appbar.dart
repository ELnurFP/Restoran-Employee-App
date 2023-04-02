import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/constants/constants.dart';

Widget customAppBar(BuildContext context, String title, {bool isback = true}) {
  return Column(
    children: [
      SizedBox(height: 35.h),
      Padding(
        padding: EdgeInsets.only(left: 25.w),
        child: Row(
          children: [
            isback
                ? IconButton(
                    icon: Icon(Icons.arrow_back_ios, size: 20.h),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
                : const SizedBox(
                    height: 48,
                  ),
            Text(
              title,
              style: FontConst.font.w600().px18().copyWith(
                    color: ColorConst.dark,
                  ),
            ),
          ],
        ),
      ),
    ],
  );
}
