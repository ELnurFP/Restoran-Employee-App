// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:template/constants/constants.dart';
import 'package:template/cubit/general_state.dart';
import 'package:template/infrastructure/remote/get_balance_service.dart';
import 'package:template/infrastructure/remote/premium_service.dart';
import 'package:template/language/localization.dart';
import 'package:template/models/general_req_model.dart';
import 'package:template/models/get_balance_history_res_model.dart';
import 'package:template/models/payment_res_model.dart';
import 'package:template/presentation/account_page/tabs/balance/methods/tab_card.dart';
import 'package:template/presentation/widgets/custom_appbar.dart';

import '../../../../cubit/general_cubit.dart';
import '../../../../dependency_injection.dart';
import '../../../../infrastructure/remote/buy_premium_service.dart';
import '../../../../infrastructure/remote/get_balance_history_service.dart';
import '../../../../infrastructure/remote/increase_payment_service.dart';
import '../../../../models/buy_premium_req_model.dart';
import '../../../../models/increase_payment_req_model.dart';
import '../../../../models/premium_res_model.dart';
import '../../../widgets/payment_webview.dart';
import '../premium_page/buy_premium_card.dart';
import 'methods/failed_promocode_dialog_box.dart';
import 'methods/increase_balance.dart';
import 'methods/money_transaction_card.dart';
import 'methods/promocode_tab.dart';

import 'methods/my_balance_card.dart';
import 'methods/succesed_promocode_dialog_box.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({super.key});

  static ValueNotifier<int> isSelected = ValueNotifier(3);
  static final role = locator.get<GetStorage>().read('role');

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  Widget premiumTab(BuildContext context, AppLocalizations t) {
    return BlocBuilder<GeneralCubit<PremiumService, GeneralInfoReqModel>,
        GeneralState>(builder: (context, state) {
      if (state is GeneralSuccess) {
        return Container(
          padding: EdgeInsets.all(26.h),
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
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations? t = AppLocalizations.of(context);
    context
        .read<GeneralCubit<GetBalanceService, GeneralInfoReqModel>>()
        .generalRequest(GeneralInfoReqModel());
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<GeneralCubit<PromoCodeService, PromoCodeReqModel>,
              GeneralState>(listener: (context, state) async {
            if (state is GeneralSuccess) {
              PromoCodeModel promo = (state.data as PromoCodeModel);
              if (promo.status == 1) {
                await context
                    .read<
                        GeneralCubit<GetBalanceService, GeneralInfoReqModel>>()
                    .generalRequest(GeneralInfoReqModel());
                succesedPromocodeDialogBox(context,
                    img: promo.img,
                    title: promo.title,
                    description: promo.description);
              } else {
                failedPromocodeDialogBox(context);
              }
            }
          }),
          BlocListener<
              GeneralCubit<IncreasePaymentService, IncreasePaymentReqModel>,
              GeneralState>(
            listener: (context, state) {
              if (state is GeneralSuccess) {
                if ((state.data! as PaymentResModel).status == 1) {
                  if ((state.data! as PaymentResModel).url != null) {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (c) => PaymentWebView(
                            onSuccess: () async {
                              setState(() {});
                              // context
                              //     .read<
                              //         GeneralCubit<GetBalanceService,
                              //             GeneralInfoReqModel>>()
                              //     .generalRequest(GeneralInfoReqModel());
                            },
                            onFail: () => Navigator.of(context).pop(context),
                            paymentUrl: (state.data! as PaymentResModel).url!));
                  }
                }
              } else if (state is GeneralFail) {
                //TODO: Snackbar qoy
              }
            },
          )
        ],
        child: SingleChildScrollView(
          child: Column(
            children: [
              customAppBar(
                context,
                t!.translate("wallet"),
              ),
              SizedBox(height: 21.h),
              Padding(
                padding: EdgeInsets.only(left: 39.w, right: 33.w),
                child: ValueListenableBuilder(
                    valueListenable: BalancePage.isSelected,
                    builder: (context, value, child) {
                      return Column(
                        children: [
                          myBalanceCard(context),
                          ...List.generate(
                            4,
                            (index) => GestureDetector(
                              onTap: () {
                                BalancePage.isSelected.value = index;
                              },
                              child: index == 1
                                  ? BalancePage.role == 'Roles.Worker'
                                      ? tabCard(context, index,
                                          BalancePage.isSelected.value == index)
                                      : const SizedBox()
                                  : tabCard(context, index,
                                      BalancePage.isSelected.value == index),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              SizedBox(height: 25.h),
              Divider(
                color: ColorConst.dviderColor,
                thickness: 1.h,
                height: 0,
              ),
              ValueListenableBuilder(
                valueListenable: BalancePage.isSelected,
                builder: (context, value, child) {
                  if (value == 0) {
                    return BlocListener<
                            GeneralCubit<IncreasePaymentService,
                                IncreasePaymentReqModel>,
                            GeneralState>(
                        listener: (context, state) {
                          if (state is GeneralSuccess) {
                            if ((state.data! as PaymentResModel).status == 1) {
                              if ((state.data! as PaymentResModel).url !=
                                  null) {
                                // showCupertinoModalPopup(
                                //     context: context,
                                //     builder: (context) => PaymentWebView(
                                //         onSuccess: () => context
                                //             .read<
                                //                 GeneralCubit<GetBalanceService,
                                //                     GeneralInfoReqModel>>()
                                //             .generalRequest(
                                //                 GeneralInfoReqModel()),
                                //         onFail: () =>
                                //             Navigator.of(context).pop(context),
                                //         paymentUrl:
                                //             (state.data! as PaymentResModel)
                                //                 .url!));
                              } else {}
                            }
                          }
                        },
                        child: increaseBalance(context));
                  } else if (value == 1) {
                    return premiumTab(context, t);
                  } else if (value == 2) {
                    return promocodeTab(context);
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(left: 39.w, right: 21.w),
                      child: BlocBuilder<
                          GeneralCubit<GetBalanceHistoryService,
                              GeneralInfoReqModel>,
                          GeneralState>(builder: (context, state) {
                        if (state is GeneralSuccess) {
                          return (state.data as GetBalanceHistoryResModel)
                                  .history
                                  .isEmpty
                              ? Center(child: Image.asset(ImageConst.noRewiew))
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      SizedBox(height: 16.h),
                                      Text(
                                        t.translate("activity"),
                                        style: FontConst.font
                                            .w600()
                                            .px16()
                                            .copyWith(
                                              color: ColorConst.dark,
                                            ),
                                      ),
                                      SizedBox(
                                        height: 16.h,
                                      ),
                                      ...(state.data
                                              as GetBalanceHistoryResModel)
                                          .history
                                          .map((e) => MoneyTransactionCard(
                                              t: t,
                                              id: int.parse(e.id),
                                              amount: double.parse(e.amount),
                                              isIncrease: e.type == '0',
                                              isSucces: e.paymentStatus == '1',
                                              place: e.place))
                                          .toList(),
                                    ]);
                        } else {
                          return Padding(
                            padding: EdgeInsets.only(top: 50.h),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      }),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
