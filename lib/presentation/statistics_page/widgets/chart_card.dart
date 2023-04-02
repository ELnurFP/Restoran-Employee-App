// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:template/models/statistics_res_model.dart';
import '../../../constants/color_constant.dart';
import '../../../constants/font_constant.dart';
import '../../../language/localization.dart';
import '../../core/shadows.dart';

class ChartCard extends StatelessWidget {
  ChartCard({Key? key, required this.t, this.datas, required this.isViews})
      : super(key: key);

  final AppLocalizations t;
  List<Statistic>? datas;
  bool isViews;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        boxShadow: Shadows.shadow1,
        color: ColorConst.primary,
        borderRadius: BorderRadius.circular(
          15.r,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            !isViews ? t.translate("viewsList") : t.translate("employersList"),
            style: FontConst.font.w500().px16(),
          ),
          //SizedBox(height: 20.h),
          // Row(
          //   // mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           t.translate("currentMonth"),
          //           style: FontConst.font.w500().px12().copyWith(
          //                 color: ColorConst.dviderColor,
          //               ),
          //         ),
          //         SizedBox(height: 10.h),
          //         Text(
          //           "\$ 1,000",
          //           style: FontConst.font.w500().px18().copyWith(
          //                 color: ColorConst.red,
          //               ),
          //         ),
          //       ],
          //     ),
          //     SizedBox(width: 80.w),
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           t.translate("previousMonth"),
          //           style: FontConst.font.w500().px12().copyWith(
          //                 color: ColorConst.dviderColor,
          //               ),
          //         ),
          //         SizedBox(height: 10.h),
          //         Text(
          //           "\$ 1,000",
          //           style: FontConst.font.w500().px18().copyWith(
          //                 color: ColorConst.blue,
          //               ),
          //         ),
          //       ],
          //     )
          //   ],
          // ),

          SizedBox(height: 20.h),
          SizedBox(
            height: 120.h,
            child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                // Chart title
                //title: ChartTitle(text: 'Half yearly sales analysis'),
                // Enable legend
                legend: Legend(isVisible: false),

                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),
                series: isViews
                    ? <ChartSeries<Statistic, String>>[
                        SplineSeries<Statistic, String>(
                            color: ColorConst.blue,
                            dataSource: datas!,
                            xValueMapper: (Statistic sales, _) =>
                                bottomTitleWidgets(sales.month!),
                            yValueMapper: (Statistic sales, _) =>
                                int.parse(sales.views!),
                            // name: 'Viewers',
                            // Enable data label
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true))
                      ]
                    : <ChartSeries<Statistic, String>>[
                        SplineSeries<Statistic, String>(
                            dataSource: datas!,
                            color: ColorConst.red,
                            xValueMapper: (Statistic sales, _) =>
                                bottomTitleWidgets(sales.month!),
                            yValueMapper: (Statistic sales, _) =>
                                int.parse(sales.empCount!),
                            //name: 'Employers',
                            // Enable data label
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true)),
                      ]),
          )
        ],
      ),
    );
  }

  String bottomTitleWidgets(String value) {
    switch (int.parse(value)) {
      case 0:
        return 'JAN';

      case 1:
        return 'FEB';
      case 2:
        return 'MARCH';

      case 3:
        return 'APR';

      case 4:
        return 'MAY';

      case 5:
        return 'JUN';

      case 6:
        return 'JUL';

      case 7:
        return 'AUG';

      case 8:
        return 'SEP';

      case 9:
        return 'OCT';

      case 10:
        return 'NOV';

      case 11:
        return 'DEC';

      default:
        return '';
    }
  }
}
