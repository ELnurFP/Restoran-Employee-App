// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:template/constants/constants.dart';
import 'package:template/cubit/general_cubit.dart';
import 'package:template/cubit/general_state.dart';
import 'package:template/dependency_injection.dart';
import 'package:template/infrastructure/remote/create_order_service.dart';
import 'package:template/language/localization.dart';
import 'package:template/presentation/core/shadows.dart';
import 'package:template/presentation/main_page/widgets/successful_page.dart';
import 'package:template/presentation/widgets/custom_appbar.dart';
import 'package:template/presentation/widgets/main_buton.dart';
import 'package:template/presentation/widgets/payment_webview.dart';
import '../../../models/create_order_req_model.dart';
import '../../../models/create_order_res_model.dart';
import '../../core/time_conventer.dart';
import '../../widgets/adview_header.dart';
import '../../widgets/icon_and_text.dart';

class PreviewAdvertisementPage extends StatelessWidget {
  const PreviewAdvertisementPage(
      {super.key, required this.model, required this.category});

  static ValueNotifier<bool?> isEkonomSelected = ValueNotifier(null);

  final String? category;
  final CreateOrderReqModel? model;

  Widget ekonomORekspress(BuildContext context, bool isEkonom, bool isSelected,
      String? price, String? hour, AppLocalizations t) {
    TimeConverter time = TimeConverter(
        hour,
        t.translate("day"),
        t.translate("hour"),
        t.translate("days"),
        t.translate("hours"),
        t.translate("now"),
        t.translate("unknown"));

    return InkWell(
      onTap: () {
        isEkonomSelected.value = isEkonom;
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
              color:
                  isEkonom ? ColorConst.ekonomColor : ColorConst.exspressColor,
              width: 0.5),
        ),
        padding: EdgeInsets.all(12.r),
        child: Row(
          children: [
            Container(
              width: 11.r,
              height: 11.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: ColorConst.black,
                  width: 0.5,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 5.r,
                        height: 5.r,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorConst.black,
                        ),
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 6.w),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: isEkonom
                    ? const Color(0xffBCF5A1)
                    : const Color(0xffFDE790),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 5.h,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    isEkonom ? IconConst.fund : IconConst.starFull,
                    width: 12.w,
                    color:
                        isEkonom ? ColorConst.idColor : const Color(0xffE59801),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    isEkonom ? t.translate("economic") : t.translate("express"),
                    style: FontConst.font.w500().px10().c(
                          isEkonom
                              ? ColorConst.ekonomColor
                              : ColorConst.exspressColor,
                        ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 40.w,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext ctx) {
                            Future.delayed(const Duration(seconds: 3), () {
                              Navigator.of(ctx).pop();
                            });
                            return AlertDialog(
                              content: Text(
                                time.isNow
                                    ? t.translate("timeInfoNow")
                                    : t.translate("timeInfo").replaceFirst(
                                        "%t", time.convertedString),
                              ),
                            );
                          });
                    },
                    child: CircleAvatar(
                      radius: 7.r,
                      backgroundColor: const Color(0xff999999),
                      child: SvgPicture.asset(
                        IconConst.info,
                        height: 9.r,
                        color: const Color(0xffFFFFFF),
                      ),
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    time.convertedString,
                    style: FontConst.font.w500().px12().c(
                          isEkonom
                              ? ColorConst.ekonomColor
                              : ColorConst.exspressColor,
                        ),
                  ),
                  const Spacer(),
                  Text(
                    price != null && price.isNotEmpty && price != 'null'
                        ? "$price AZN"
                        : t.translate("unknown"),
                    style: FontConst.font.w500().px12().c(
                          isEkonom
                              ? ColorConst.ekonomColor
                              : ColorConst.exspressColor,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> data = model!.work_date!.split('.').first.split(':');
    data.removeLast();
    String date = data.join(':').split(' ').first.split('-').reversed.join('.');
    String hour = data.join(':').split(' ').last;
    AppLocalizations? t = AppLocalizations.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            customAppBar(context, t!.translate("previewAd")),
            header(
                context,
                category ?? '',
                locator.get<GetStorage>().read(
                            'user_status_${locator.get<GetStorage>().read('lang') ?? 'az'}') !=
                        null
                    ? locator
                        .get<GetStorage>()
                        .read(
                            'user_status_${locator.get<GetStorage>().read('lang') ?? 'az'}')!
                        .toString()
                    : '',
                t),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 37.h),
              child: Column(
                children: [
                  iconAndText(
                    IconConst.done,
                    t
                        .translate("canApply")
                        .replaceFirst("\$p", "0")
                        .replaceFirst("\$t", model!.count!),
                    ColorConst.doneColor,
                  ),
                  iconAndText(
                    IconConst.time, //TODO: change icon
                    '${t.translate("deadline")} $date $hour',
                    const Color(0xff4D4D4D),
                  ),
                  // iconAndText(
                  //   IconConst.time,
                  //   t
                  //       .translate("workHours")
                  //       .replaceFirst("\$d", "09:00-18:00"),
                  //   ColorConst.blue,
                  // ),
                  iconAndText(
                    IconConst.location,
                    model!.address!,
                    ColorConst.orange,
                  ),
                  iconAndText(
                    IconConst.gender,
                    [
                      t.translate("male"),
                      t.translate("female"),
                      t.translate("allGender")
                    ][int.parse(model!.gender!)],
                    const Color(0xff93D6F4),
                  ),
                  //if (isEkonomSelected.value != null)
                  ValueListenableBuilder(
                    valueListenable: isEkonomSelected,
                    builder: (context, value, child) =>
                        isEkonomSelected.value != null
                            ? iconAndText(
                                !isEkonomSelected.value!
                                    ? IconConst.starFull
                                    : IconConst.fund,
                                (isEkonomSelected.value!
                                    ? t.translate('economic')
                                    : t.translate('express')),
                                !isEkonomSelected.value!
                                    ? ColorConst.exspressColor
                                    : ColorConst.idColor,
                              )
                            : const SizedBox(),
                  )
                  // iconAndText(
                  //   IconConst.calendar,
                  //   "13.03.2022",
                  //   const Color(0xff529BF1),
                  // )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              height: 120.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: GoogleMap(
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                  initialCameraPosition: CameraPosition(
                    // bearing: 192.8334901395799,
                    target: LatLng(
                        double.parse(model!.lat!), double.parse(model!.lon!)),
                    // tilt: 59.440717697143555,
                    zoom: 10,
                  ),
                  circles: {
                    Circle(
                      strokeColor: Colors.blue,
                      fillColor: Colors.blue.withOpacity(0.3),
                      circleId: CircleId(model!.address ?? ''),
                      strokeWidth: 1,
                      center: LatLng(
                          double.parse(model!.lat!), double.parse(model!.lon!)),
                      radius: 5000,
                    )
                  },
                  // markers: {
                  //   Marker(
                  //     markerId: const MarkerId(
                  //       "position",
                  //     ),
                  // position: LatLng(double.parse(model!.lat!),
                  //     double.parse(model!.lon!)),
                  //   )
                  // },
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              width: 375.w,
              child: Text(
                model!.description!,
                textAlign: TextAlign.left,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: Shadows.shadow1,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
        ),
        padding: EdgeInsets.all(28.r),
        child: ValueListenableBuilder(
            valueListenable: isEkonomSelected,
            builder: (context, value, child) {
              return BlocConsumer<
                  GeneralCubit<CreateOrderService, CreateOrderReqModel>,
                  GeneralState>(listener: (context, state) {
                if (state is GeneralSuccess) {
                  if ((state.data! as CreateOrderResModel).status == '1') {
                    if ((state.data! as CreateOrderResModel).url != null) {
                      showCupertinoModalPopup(
                          context: context,
                          builder: (context) => PaymentWebView(
                              onSuccess: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SuccessfullPage())),
                              onFail: () => Navigator.of(context).pop(context),
                              paymentUrl:
                                  (state.data! as CreateOrderResModel).url!));
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SuccessfullPage()));
                    }
                  }
                }
              }, builder: (context, state) {
                if (state is GeneralSuccess) {}
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (state is GeneralSuccess)
                      (state.data as CreateOrderResModel).price_list != null &&
                              (state.data as CreateOrderResModel)
                                      .price_list!
                                      .eco !=
                                  null
                          ? ekonomORekspress(
                              context,
                              true,
                              value ?? false,
                              (state.data as CreateOrderResModel)
                                  .price_list!
                                  .eco!
                                  .price!,
                              (state.data as CreateOrderResModel)
                                  .price_list!
                                  .eco!
                                  .hours!,
                              t,
                            )
                          : const SizedBox.shrink(),
                    SizedBox(height: 20.h),
                    if (state is GeneralSuccess)
                      (state.data as CreateOrderResModel).price_list != null &&
                              (state.data as CreateOrderResModel)
                                      .price_list!
                                      .express !=
                                  null
                          ? ekonomORekspress(
                              context,
                              false,
                              !(value ?? false),
                              (state.data as CreateOrderResModel)
                                  .price_list!
                                  .express!
                                  .price!,
                              (state.data as CreateOrderResModel)
                                  .price_list!
                                  .express!
                                  .hours!,
                              t,
                            )
                          : const SizedBox.shrink(),
                    SizedBox(height: 20.h),
                    if (state is GeneralSuccess)
                      (state.data as CreateOrderResModel).price_list == null
                          // &&

                          //         (state.data as CreateOrderResModel)
                          //                 .price_list!
                          //                 .express ==
                          //             null &&
                          //         (state.data as CreateOrderResModel)
                          //                 .price_list!
                          //                 .eco ==
                          //             null
                          ? mainButton(context, isRed: true, () {
                              Navigator.pop(context);
                            }, 'Failed, please try again')
                          : mainButton(context, () async {
                              model!.price_type =
                                  (isEkonomSelected.value ?? true)
                                      ? 'eco'
                                      : 'express';

                              await context
                                  .read<
                                      GeneralCubit<CreateOrderService,
                                          CreateOrderReqModel>>()
                                  .generalRequest(model!);
                            }, t.translate("confirm")),
                    SizedBox(height: 10.h),
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          t.translate("cancel"),
                          style: const TextStyle(color: Colors.grey),
                        ))
                  ],
                );
              });
            }),
      ),
    );
  }
}
