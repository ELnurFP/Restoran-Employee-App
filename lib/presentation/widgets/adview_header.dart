import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/configs/base64_conventer.dart';
import 'package:template/constants/constants.dart';
import 'package:template/language/localization.dart';

Widget header(
    BuildContext context, String job, String company, AppLocalizations t) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 27.w),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10.h),
              width: 50.r,
              height: 50.r,
              decoration: const BoxDecoration(
                color: ColorConst.purpleW100,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  job[0],
                  style: FontConst.font.w600().px22().c(
                        ColorConst.purpleW500,
                      ),
                ),
              ),
            ),
            // Positioned(
            //   top: -1.h,
            //   right: 0,
            //   left: 0,
            //   child: SvgPicture.asset(
            //     IconConst.crown,
            //     width: 25.w,
            //     color: const Color(0xFFDBA932),
            //   ),
            // )
          ],
        ),
        SizedBox(
          width: 12.w,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),
            Text(
              job,
              style: FontConst.font.w500().px16().c(
                    ColorConst.dark,
                  ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              company.fromBase64,
              style: FontConst.font.w400().px14().c(
                    ColorConst.lightDark,
                  ),
            ),
          ],
        ),
        const Spacer(),
        // Column(
        //   children: [
        //     SizedBox(
        //       height: 10.h,
        //     ),
        //     Text(
        //       "ID#4389843",
        //       style: FontConst.font.w400().px14().c(
        //             ColorConst.lightDark,
        //           ),
        //     ),
        //     SizedBox(
        //       height: 8.h,
        //     ),
        //     Container(
        //       decoration: BoxDecoration(
        //         color: const Color(0xffEBBE08),
        //         borderRadius: BorderRadius.circular(8.r),
        //       ),
        //       padding: EdgeInsets.symmetric(
        //         horizontal: 12.w,
        //         vertical: 5.h,
        //       ),
        //       child: Text(
        //         t.translate("requestSent"),
        //         style: FontConst.font.w500().px10().c(
        //               ColorConst.primary,
        //             ),
        //       ),
        //     )
        //   ],
        // )
      ],
    ),
  );
}
