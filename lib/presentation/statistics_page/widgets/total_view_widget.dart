import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:template/constants/constants.dart';
import 'package:template/language/localization.dart';
import 'package:template/presentation/core/shadows.dart';

class TotalViewWidget extends StatelessWidget {
  const TotalViewWidget({super.key, required this.totalView});
  final int totalView;
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
          Container(
            height: 45.h,
            width: 45.h,
            decoration: const BoxDecoration(
              color: Color(0xFF93D6F4),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.remove_red_eye, color: ColorConst.primary),
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.translate("totalView"),
                style: FontConst.font.w500().px14(),
              ),
              SizedBox(
                height: 6.h,
              ),
              Text(
                "$totalView",
                style: FontConst.font.w600().px14(),
              )
            ],
          )
        ],
      ),
    );
  }
}
