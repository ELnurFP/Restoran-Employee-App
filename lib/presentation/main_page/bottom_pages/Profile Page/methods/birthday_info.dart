// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:template/language/localization.dart';

import '../../../../../constants/constants.dart';

class BirthdayInfo extends StatelessWidget {
  const BirthdayInfo({Key? key, this.birthday, required this.t})
      : super(key: key);

  final DateTime? birthday;
  final AppLocalizations t;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: ColorConst.secondary,
            radius: 12.5.r,
            child: SvgPicture.asset(
              IconConst.bag, //TODO: find right icon
              color: ColorConst.primary,
              height: 12.5.r,
              width: 12.5.r,
            ),
          ),
          SizedBox(width: 10.w),
          SizedBox(
            width: 280.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      birthday != null
                          ? "${birthday!.day}.${birthday!.month}.${birthday!.year}"
                          : t.translate("birthday"),
                      style: FontConst.font.w500().px14().copyWith(
                            color: ColorConst.dark,
                          ),
                    ),
                    Text(
                      birthday != null
                          ? "${birthday!.age} years"
                          : t.translate("birthday"),
                      style: FontConst.font.w500().px14().copyWith(
                            color: ColorConst.dark,
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Text(
                  t.translate("birthday"),
                  style: FontConst.font.w400().px12().copyWith(
                        color: ColorConst.subtitleColor,
                      ),
                ),
                SizedBox(height: 8.h),
              ],
            ),
          )
        ],
      ),
    );
  }
}

extension AgeCalculator on DateTime {
  int get age {
    DateTime today = DateTime.now(); // Get today's date

    int age =
        today.year - year; // Calculate the age based on the difference in years

    if (today.month < month || (today.month == month && today.day < day)) {
      age--; // Adjust the age if the birthday hasn't occurred yet this year
    }

    return age;
  }
}
