import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/configs/base64_conventer.dart';
import 'package:template/constants/color_constant.dart';
import 'package:template/constants/font_constant.dart';
import 'package:template/cubit/general_state.dart';
import 'package:template/language/localization.dart';
import 'package:template/models/status_model.dart';
import 'package:template/presentation/widgets/custom_appbar.dart';
import 'package:template/presentation/widgets/custom_dialog.dart';
import 'package:template/presentation/widgets/main_buton.dart';

import '../../../../constants/image_constant.dart';
import '../../../../cubit/general_cubit.dart';
import '../../../../infrastructure/remote/apply_order_service.dart';
import '../../../../infrastructure/remote/get_reasons_service.dart';
import '../../../../models/apply_order_req_model.dart';
import '../../../../models/general_with_order_req_model.dart';
import '../../widgets/successful_page.dart';

class ChooseAReasonPage extends StatelessWidget {
  const ChooseAReasonPage({super.key, this.orderId = ''});

  final String? orderId;

  static final ValueNotifier<String?> _reason = ValueNotifier<String?>('');

  @override
  Widget build(BuildContext context) {
    AppLocalizations? t = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) =>
            GeneralCubit<GetReasonsService, GeneralWithOrderReqModel>()
              ..generalRequest(GeneralWithOrderReqModel()),
        child: SingleChildScrollView(
          child: BlocBuilder<
              GeneralCubit<GetReasonsService, GeneralWithOrderReqModel>,
              GeneralState>(builder: (context, state) {
            if (state is GeneralSuccess) {
              List data = (state.data as AllReasons).all!;
              return Column(
                children: [
                  customAppBar(context, t!.translate("chooseAReason")),
                  SizedBox(height: 14.h),
                  ...data.map((e) {
                    return ValueListenableBuilder(
                      valueListenable: _reason,
                      builder: (context, value, child) {
                        return Padding(
                          padding: EdgeInsets.only(left: 41.w, right: 21.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                e.name!.toString().fromBase64,
                                style: FontConst.font.w400().px12().copyWith(
                                      color: ColorConst.dark,
                                    ),
                              ),
                              Radio(
                                value: e.id!,
                                groupValue: _reason.value,
                                onChanged: (value) => _reason.value = e.id!,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                  SizedBox(height: 27.h),
                  Padding(
                    padding: EdgeInsets.only(left: 38.w, right: 34.w),
                    child: BlocProvider(
                        create: (context) => GeneralCubit<ApplyOrderService,
                            ApplyOrderReqModel>(),
                        child: BlocBuilder<
                            GeneralCubit<ApplyOrderService, ApplyOrderReqModel>,
                            GeneralState>(builder: (context, state) {
                          return BlocListener<
                              GeneralCubit<ApplyOrderService,
                                  ApplyOrderReqModel>,
                              GeneralState>(
                            listener: (context, state) {
                              if (state is GeneralSuccess) {
                                if ((state.data as StatusModel).status == 1) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const SuccessfullPage()));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text(t.translate("errorEccured")),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                }
                              } else if (state is GeneralFail) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(t.translate("errorEccured")),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                            },
                            child: mainButton(context, () {
                              customDialogBox(
                                context,
                                () async {
                                  await context
                                      .read<
                                          GeneralCubit<ApplyOrderService,
                                              ApplyOrderReqModel>>()
                                      .generalRequest(
                                        ApplyOrderReqModel(
                                          id: orderId,
                                          reason: _reason.value,
                                          type: '1',
                                        ),
                                      );
                                },
                                t.translate("wannaCancel"),
                                t,
                              );
                            }, t.translate("cancelTheOrder").toUpperCase()),
                          );
                        })),
                  ),
                  SizedBox(height: 13.h),
                  Padding(
                    padding: EdgeInsets.only(left: 38.w, right: 34.w),
                    child: mainButton(context, () async {
                      Navigator.pop(context);
                    }, t.translate("dismiss").toUpperCase(), isWhite: true),
                  ),
                ],
              );
            } else if (state is GeneralLoading) {
              return SizedBox(
                height: 812.h,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is GeneralFail) {
              return SizedBox(
                height: 750.h,
                width: 375.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(ImageConst.noRewiew),
                    SizedBox(height: 10.h),
                    Text(t!.translate("unexpected")),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text(t!.translate("wentWrong")),
              );
            }
          }),
        ),
      ),
    );
  }
}
