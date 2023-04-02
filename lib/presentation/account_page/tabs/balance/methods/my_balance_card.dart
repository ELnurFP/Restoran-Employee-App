import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/constants/constants.dart';
import 'package:template/language/localization.dart';

import '../../../../../cubit/general_cubit.dart';
import '../../../../../cubit/general_state.dart';
import '../../../../../infrastructure/remote/get_balance_service.dart';
import '../../../../../models/general_req_model.dart';
import '../../../../../models/get_balance_model.dart';

Container myBalanceCard(BuildContext context) {
  AppLocalizations? t = AppLocalizations.of(context);
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(17.r),
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xff034955),
          Color(0xff03787A),
        ],
      ),
    ),
    padding: EdgeInsets.only(
      left: 20.w,
      right: 35.w,
      top: 20.h,
      bottom: 20.h,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          t!.translate("myBalance"),
          style:
              FontConst.font.w600().px16().copyWith(color: ColorConst.primary),
        ),
        BlocBuilder<GeneralCubit<GetBalanceService, GeneralInfoReqModel>,
            GeneralState>(builder: (context, state) {
          if (state is GeneralSuccess) {
            return Text(
              "${(state.data as BalanceModel).balance} AZN", //fix  ₼ symbol
              style: FontConst.font
                  .w600()
                  .px16()
                  .copyWith(color: ColorConst.primary),
            );
          } else {
            return Text(
              "0 AZN", //fix  ₼ symbol
              style: FontConst.font
                  .w600()
                  .px16()
                  .copyWith(color: ColorConst.primary),
            );
          }
        })
      ],
    ),
  );
}
