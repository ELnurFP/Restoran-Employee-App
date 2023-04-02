// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:template/constants/constants.dart';
import 'package:template/language/localization.dart';

import '../../../../../cubit/general_cubit.dart';
import '../../../../../infrastructure/remote/get_balance_history_service.dart';
import '../../../../../models/general_req_model.dart';

Padding tabCard(BuildContext context, int value, bool isSelected) {
  Color? color;
  String? title;
  Widget? icon;
  AppLocalizations? t = AppLocalizations.of(context);
  if (value == 0) {
    color = const Color(0xffF8A400);
    title = t!.translate("increaseBalance");
    icon = Icon(
      Icons.add,
      color: isSelected ? color : ColorConst.primary,
    );
  } else if (value == 1) {
    color = ColorConst.premiumColor;
    title = t!.translate("premium");
    icon = Padding(
      padding: const EdgeInsets.all(7.0),
      child: SvgPicture.asset(
        IconConst.crown,
        color: isSelected ? color : ColorConst.primary,
      ),
    );
  } else if (value == 2) {
    color = const Color(0xffBFD151);
    title = t!.translate("promocode");
    icon = SvgPicture.asset(
      IconConst.promocode,
      color: isSelected ? color : ColorConst.primary,
    );
  } else if (value == 3) {
    color = const Color(0xff474747);
    title = t!.translate("history");
    context
        .read<GeneralCubit<GetBalanceHistoryService, GeneralInfoReqModel>>()
        .generalRequest(GeneralInfoReqModel());
    icon = Icon(
      Icons.history,
      color: isSelected ? color : ColorConst.primary,
    );
  }
  return Padding(
    padding: EdgeInsets.only(top: 11.h),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17.r),
        color: isSelected ? color : ColorConst.primary,
        boxShadow: isSelected
            ? null
            : [
                BoxShadow(
                  color: const Color(0xff000000).withOpacity(0.25),
                  offset: const Offset(0, 4),
                  blurRadius: 4,
                ),
              ],
      ),
      padding: EdgeInsets.all(7.r),
      child: Row(
        children: [
          Container(
            height: 37.r,
            width: 43.r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.r),
              color: isSelected ? ColorConst.primary : color,
            ),
            // padding: value == 1 ? EdgeInsets.all(7.r) : null,
            child: icon,
          ),
          SizedBox(width: 10.w),
          Text(
            title!,
            style: FontConst.font.w500().px16().copyWith(
                  color:
                      isSelected ? ColorConst.primary : const Color(0xff000000),
                ),
          ),
        ],
      ),
    ),
  );
}
