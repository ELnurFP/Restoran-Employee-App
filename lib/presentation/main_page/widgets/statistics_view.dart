// ignore_for_file: deprecated_member_use

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:template/constants/constants.dart';
import 'package:template/language/localization.dart';

import '../../core/shadows.dart';
import '../entity/statistics_entity.dart';

class StatisticsView extends StatelessWidget {
  final StatisticsEntity statisticsEntity;
  final double? titleSize;
  const StatisticsView(
      {Key? key, required this.statisticsEntity, this.titleSize = 12})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations t = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.all(
        15.h,
      ),
      decoration: BoxDecoration(
        boxShadow: Shadows.shadow1,
        color: ColorConst.primary,
        borderRadius: BorderRadius.circular(
          15.r,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 45.h,
                  width: 45.h,
                  //
                  decoration: const BoxDecoration(
                    color: Color(0xFF99DB71),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Transform.rotate(
                      angle: 345 * math.pi / 180,
                      child: SvgPicture.asset(
                        IconConst.announce2,
                        height: 22.h,
                        color: ColorConst.primary,
                        width: 22.h,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100.w,
                      child: Text(
                        t.translate("adNumber"),
                        // context.loc.adCount,
                        style: FontConst.font.w500().copyWith(
                              fontSize: titleSize!.sp,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    SizedBox(
                      width: 100.w,
                      child: Text(
                        statisticsEntity.adCount != 'null'
                            ? statisticsEntity.adCount
                            : '0',
                        style: FontConst.font.w600().px14(),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            width: 0.6.w,
            height: 28.h,
            color: ColorConst.dark,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 45.h,
                  width: 45.h,
                  //
                  decoration: const BoxDecoration(
                      color: ColorConst.orange, shape: BoxShape.circle),
                  child: Center(
                    child: SvgPicture.asset(
                      IconConst.twoMen,
                      height: 22.h,
                      width: 22.h,
                      color: ColorConst.primary,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.translate('employees'),
                      // context.loc.employees,
                      style: FontConst.font.w500().copyWith(
                            fontSize: titleSize!.sp,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      statisticsEntity.employeeCount != 'null'
                          ? statisticsEntity.employeeCount
                          : '0',
                      style: FontConst.font.w600().px14(),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
