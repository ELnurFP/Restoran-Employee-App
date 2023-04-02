import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../../constants/constants.dart';

class LinearRatingBar extends StatelessWidget {
  const LinearRatingBar(
      {super.key, required this.index, required this.progress});

  final int index;
  final int progress;

  @override
  Widget build(BuildContext context) {
    const colors = [
      Color(0xffEF3910),
      Color(0xffF6E631),
      Color(0xffFBBC05),
      Color(0xffC7DC48),
      Color(0xff5FB557),
    ];
    return Row(
      children: [
        Icon(
          Icons.star,
          color: Colors.yellow,
          size: 16.h,
        ),
        SizedBox(width: 4.w),
        SizedBox(
          width: 10.w,
          child: Text(
            "$index",
            style: FontConst.font.w500().px12().copyWith(
                  color: const Color(0xff434343),
                ),
          ),
        ),
        SizedBox(width: 6.w),
        LinearPercentIndicator(
          width: 135.w,
          padding: EdgeInsets.zero,
          barRadius: const Radius.circular(16),
          lineHeight: 10.h,
          percent: progress / 100,
          progressColor: colors[index - 1],
          backgroundColor: ColorConst.border,
        ),
        SizedBox(width: 8.w),
        SizedBox(
          width: 30.w,
          child: Text(
            "$progress%",
            style: FontConst.font.w500().px12().copyWith(
                  color: const Color(0xff434343),
                ),
          ),
        ),
      ],
    );
  }
}

// Row linearRatingBar(
//   int index,
//   int progress,
// ) {
//   const colors = [
//     Color(0xffEF3910),
//     Color(0xffFBBC05),
//     Color(0xffF6E631),
//     Color(0xffC7DC48),
//     Color(0xff5FB557),
//   ];
//   return Row(
//     children: [
//       Icon(
//         Icons.star,
//         color: Colors.yellow,
//         size: 16.h,
//       ),
//       SizedBox(width: 4.w),
//       SizedBox(
//         width: 10.w,
//         child: Text(
//           "$index",
//           style: FontConst.font.w500().px12().copyWith(
//                 color: const Color(0xff434343),
//               ),
//         ),
//       ),
//       SizedBox(width: 6.w),
//       LinearPercentIndicator(
//         width: 135.w,
//         padding: EdgeInsets.zero,
//         barRadius: const Radius.circular(16),
//         lineHeight: 10.h,
//         percent: progress / 100,
//         progressColor: colors[index - 1],
//         backgroundColor: ColorConst.border,
//       ),
//       SizedBox(width: 8.w),
//       SizedBox(
//         width: 30.w,
//         child: Text(
//           "$progress%",
//           style: FontConst.font.w500().px12().copyWith(
//                 color: const Color(0xff434343),
//               ),
//         ),
//       ),
//     ],
//   );
// }
