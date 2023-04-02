import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:template/constants/font_constant.dart';
import 'package:template/models/profile_info_res_model.dart';
import 'package:template/presentation/main_page/bottom_pages/Profile%20Page/methods/linear_raiting_bar.dart';

Padding ratingBar(UserRates userRates) {
  String star1 = userRates.star1 != 'null'
      ? userRates.star1 != null
          ? userRates.star1 != ''
              ? userRates.star1!
              : '0'
          : '0'
      : '0';
  String star2 = userRates.star2 != 'null'
      ? userRates.star2 != null
          ? userRates.star2 != ''
              ? userRates.star2!
              : '0'
          : '0'
      : '0';
  String star3 = userRates.star3 != 'null'
      ? userRates.star3 != null
          ? userRates.star3 != ''
              ? userRates.star3!
              : '0'
          : '0'
      : '0';
  String star4 = userRates.star4 != 'null'
      ? userRates.star4 != null
          ? userRates.star4 != ''
              ? userRates.star4!
              : '0'
          : '0'
      : '0';
  String star5 = userRates.star5 != 'null'
      ? userRates.star5 != null
          ? userRates.star5 != ''
              ? userRates.star5!
              : '0'
          : '0'
      : '0';
  String rate = userRates.rate != 'null'
      ? userRates.rate != null
          ? userRates.rate != ''
              ? userRates.rate!
              : '0'
          : '0'
      : '0';

  double sum = (double.tryParse(star1)! +
      double.tryParse(star2)! +
      double.tryParse(star3)! +
      double.tryParse(star4)! +
      double.tryParse(star5)!);

  double oneStartPercent;
  double twoStartPercent;
  double threeStartPercent;
  double fourStartPercent;
  double fiveStartPercent;
  if (sum != 0) {
    oneStartPercent = (double.tryParse(star1)! / sum) * 100;
    twoStartPercent = (double.tryParse(star2)! / sum) * 100;
    threeStartPercent = (double.tryParse(star3)! / sum) * 100;
    fourStartPercent = (double.tryParse(star4)! / sum) * 100;
    fiveStartPercent = (double.tryParse(star5)! / sum) * 100;
  } else {
    oneStartPercent = 0;
    twoStartPercent = 0;
    threeStartPercent = 0;
    fourStartPercent = 0;
    fiveStartPercent = 0;
  }

  double percent = (double.tryParse(rate)! / 5) * 100;
  if (kDebugMode) {
    print('percent $percent');
  }
  return Padding(
    padding: EdgeInsets.only(left: 33.w, right: 20.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircularPercentIndicator(
          circularStrokeCap: CircularStrokeCap.round,
          backgroundColor: Colors.white,
          radius: 100.r / 2,
          progressColor: percent == 100
              ? const Color(0xff3E8937)
              : percent >= 99 && percent >= 80
                  ? const Color(0xff3E8937)
                  : percent >= 79 && percent >= 60
                      ? const Color(0xffA5D631)
                      : percent >= 59 && percent >= 40
                          ? const Color(0xffFBBC05)
                          : percent >= 39 && percent >= 20
                              ? const Color(0xffF6E631)
                              : const Color(0xffEF3910),
          // linearGradient: LinearGradient(
          //   colors: [
          //     percent == 100
          //         ? ColorConst.secondary
          //         : percent >= 100 && percent >= 60
          //             ? const Color.fromARGB(255, 57, 216, 43)
          //             : percent >= 60 && percent >= 40
          //                 ? const Color.fromARGB(255, 255, 255, 0)
          //                 : Colors.red,
          //     percent >= 40 ? ColorConst.secondary : Colors.red,
          //   ],
          // ),
          percent: percent / 100,
          // progressColor: ColorConst.secondary,
          lineWidth: 5.r,
          center: Padding(
            padding: EdgeInsets.only(top: 8.r),
            child: Text(
              double.tryParse(rate)!.toStringAsFixed(2),
              style: FontConst.font.w500().copyWith(
                    color: Colors.black,
                    fontSize: 30.sp,
                  ),
            ),
          ),
        ),
        // SizedBox(width: 28.w),
        Column(
          children: [
            LinearRatingBar(index: 5, progress: fiveStartPercent.toInt()),
            LinearRatingBar(index: 4, progress: fourStartPercent.toInt()),
            LinearRatingBar(index: 3, progress: threeStartPercent.toInt()),
            LinearRatingBar(index: 2, progress: twoStartPercent.toInt()),
            LinearRatingBar(index: 1, progress: oneStartPercent.toInt()),
          ],
        )
      ],
    ),
  );
}
