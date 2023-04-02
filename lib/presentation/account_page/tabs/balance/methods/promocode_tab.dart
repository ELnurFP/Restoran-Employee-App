import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/constants/constants.dart';
import 'package:template/cubit/general_cubit.dart';
import 'package:template/language/localization.dart';
import 'package:template/presentation/widgets/main_buton.dart';

import '../../../../../infrastructure/remote/buy_premium_service.dart';
import '../../../../../models/buy_premium_req_model.dart';

Widget promocodeTab(BuildContext c) {
  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(13.r),
    borderSide: BorderSide(
      color: ColorConst.dviderColor,
      width: 1.h,
    ),
  );

  TextEditingController controller = TextEditingController();
  AppLocalizations? t = AppLocalizations.of(c);

  return Padding(
    padding: EdgeInsets.only(left: 39.w, right: 33.w),
    child: Column(
      children: [
        SizedBox(height: 20.h),
        TextFormField(
          controller: controller,
          autofocus: true,
          textCapitalization: TextCapitalization.characters,
          decoration: InputDecoration(
            fillColor: Colors.white,
            hintText: t!.translate("enterPromoCode"),
            hintStyle: FontConst.font.w400().px16().copyWith(
                  color: ColorConst.subtitleColor,
                ),
            border: outlineInputBorder,
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
          ),
        ),
        SizedBox(height: 18.h),
        mainButton(
          c,
          () async {
            await c
                .read<GeneralCubit<PromoCodeService, PromoCodeReqModel>>()
                .generalRequest(PromoCodeReqModel(promocode: controller.text));
          },
          t.translate("next"),
        ),
      ],
    ),
  );
}
