import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/constants/constants.dart';

// Container customCheckboxField(String title, bool value, Function() onTap) {
//   return Container(
//     width: double.infinity,
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(7.r),
//       border: Border.all(
//         color: const Color(0xffFF0000),
//       ),
//     ),
//     padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 12.h),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: FontConst.font.w400().px14().copyWith(
//                 color: const Color(0xff0C0C0C),
//               ),
//         ),
//         GestureDetector(
//           onTap: onTap,
//           child: Container(
//             width: 21.w,
//             height: 21.h,
//             decoration: BoxDecoration(
//               color: value ? ColorConst.secondary : Colors.white,
//               borderRadius: BorderRadius.circular(4.r),
//               border: Border.all(
//                 color: ColorConst.secondary,
//               ),
//             ),
//             child: value
//                 ? Icon(
//                     Icons.check,
//                     color: Colors.white,
//                     size: 15.h,
//                   )
//                 : const SizedBox(),
//           ),
//         ),
//       ],
//     ),
//   );
// }

class CustomCheckboxField extends StatelessWidget {
  const CustomCheckboxField(
      {super.key,
      required this.title,
      required this.red,
      required this.value,
      required this.onTap});

  final Function() onTap;
  final String title;
  final bool red;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7.r),
        border: Border.all(
          color: red ? const Color(0xffFF0000) : ColorConst.disabledColor,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: FontConst.font.w400().px14().copyWith(
                  color: const Color(0xff0C0C0C),
                ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 21.w,
              height: 21.h,
              decoration: BoxDecoration(
                color: value ? ColorConst.secondary : Colors.white,
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(
                  color: ColorConst.secondary,
                ),
              ),
              child: value
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 15.h,
                    )
                  : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
