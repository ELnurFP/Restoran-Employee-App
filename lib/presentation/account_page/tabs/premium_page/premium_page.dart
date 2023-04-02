import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/constants/font_constant.dart';
import 'package:template/language/localization.dart';
import 'package:template/models/premium_res_model.dart';
import 'package:template/presentation/account_page/tabs/balance/methods/failed_promocode_dialog_box.dart';
import 'package:template/presentation/account_page/tabs/balance/methods/succesed_promocode_dialog_box.dart';
import 'package:template/presentation/widgets/custom_appbar.dart';

import '../../../../cubit/general_cubit.dart';
import '../../../../cubit/general_state.dart';
import '../../../../infrastructure/remote/buy_premium_service.dart';
import '../../../../infrastructure/remote/premium_service.dart';
import '../../../../models/buy_premium_req_model.dart';
import '../../../../models/general_req_model.dart';
import '../../../../models/payment_res_model.dart';
import '../../../widgets/payment_webview.dart';
import 'buy_premium_card.dart';

class PremiumPage extends StatelessWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations? t = AppLocalizations.of(context);
    return Scaffold(body: BlocBuilder<
        GeneralCubit<PremiumService, GeneralInfoReqModel>,
        GeneralState>(builder: (context, state) {
      if (state is GeneralSuccess) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customAppBar(context, t!.translate('premium')),
            Padding(
              padding: EdgeInsets.only(left: 40.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 160.w,
                        child: Text(
                          (state.data as PremiumResModel).title!,
                          //textAlign: TextAlign.center,
                          style: FontConst.font
                              .px16()
                              .w500()
                              .copyWith(color: const Color(0xff333232)),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        width: 160.w,
                        child: Text(
                          (state.data as PremiumResModel).description!,
                          style: FontConst.font.px12().w400(),
                        ),
                      ),
                    ],
                  ),
                  Image.network(
                    (state.data as PremiumResModel).img!,
                    height: 130.h,
                    width: 170.w,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.w),
              child: BlocListener<
                  GeneralCubit<BuyPremiumService, BuyPremiumReqModel>,
                  GeneralState>(
                listener: (context, state) {
                  if (state is GeneralSuccess) {
                    if ((state.data! as PaymentResModel).status == 1) {
                      if ((state.data! as PaymentResModel).url != null) {
                        showCupertinoModalPopup(
                            context: context,
                            builder: (context) => PaymentWebView(
                                onSuccess: () async =>
                                    succesedDialogBox(context),
                                onFail: () => failedPromocodeDialogBox(context),
                                paymentUrl:
                                    (state.data! as PaymentResModel).url!));
                      }
                    }
                  } else if (state is GeneralFail) {
                    //TODO: Snackbar qoy
                  }
                },
                child: Column(children: [
                  ...(state.data as PremiumResModel).packages!.map(
                        (e) => buyPremiumCard(
                          double.parse(e.price!),
                          double.parse(e.per_month!),
                          () async {
                            await context
                                .read<
                                    GeneralCubit<BuyPremiumService,
                                        BuyPremiumReqModel>>()
                                .generalRequest(
                                    BuyPremiumReqModel(id: e.id.toString()));
                          },
                          t,
                        ),
                      )
                ]),
              ),
            )
          ],
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    }));
  }
}
