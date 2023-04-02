// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:template/cubit/general_state.dart';
import 'package:template/language/localization.dart';
import 'package:template/configs/base64_conventer.dart';
import 'package:template/presentation/main_page/bottom_pages/Profile%20Page/add_review.dart';
import 'package:template/presentation/widgets/custom_dialog.dart';
import '../../constants/constants.dart';
import '../../cubit/general_cubit.dart';
import '../../dependency_injection.dart';
import '../../infrastructure/remote/apply_order_service.dart';
import '../../infrastructure/remote/cancel_order_owner_service.dart';
import '../../infrastructure/remote/get_order_service.dart';
import '../../infrastructure/remote/owner_order_accept_decline_service.dart';
import '../../infrastructure/remote/rate_workers_owner_service.dart';
import '../../infrastructure/remote/update_saved_order_service.dart';
import '../../models/apply_order_req_model.dart';
import '../../models/cancel_order_owner_req_model.dart';
import '../../models/general_req_model.dart';
import '../../models/get_order_res_model.dart';
import '../../models/owner_order_accept_decline_req_model.dart';
import '../../models/rate_workers_owner_req_model.dart';
import '../../models/status_model.dart';
import '../../models/update_saved_orders_req_model.dart';
import '../core/decoder.dart';
import '../core/icon_and_test.dart';
import '../main_page/bottom_pages/Profile Page/choose_reason_page.dart';
import '../main_page/entity/ad_entity.dart';
import '../main_page/widgets/archive_card.dart';
import '../main_page/widgets/cancelled_card.dart';
import 'methods/apply_button.dart';
import 'methods/cancel_button.dart';
import 'methods/employee_item.dart';
import 'methods/employees_list.dart';

enum EmployeeType { employee, accapted, canceled }

class AdViewPage extends StatefulWidget {
  const AdViewPage(
      {Key? key, required this.adEntity, this.orderType = '', this.total = ''})
      : super(key: key);

  final AdEntity adEntity;
  final String orderType;
  final String total;

  @override
  State<AdViewPage> createState() => _AdViewPageState();
}

class _AdViewPageState extends State<AdViewPage> {
  static List<GetApplieds> accapted = [];
  static List<GetApplieds> canceled = [];
  static List<GetApplieds> didntCome = [];
  static List<GetApplieds> employees = [];
  static ValueNotifier<bool> showAccapted = ValueNotifier<bool>(true);
  static ValueNotifier<bool> showCanceled = ValueNotifier<bool>(true);
  static ValueNotifier<bool> showDidntCome = ValueNotifier<bool>(true);
  static ValueNotifier<bool> showEmploye = ValueNotifier<bool>(true);
  static ValueNotifier<bool> showEndedAccapted = ValueNotifier<bool>(true);
  static ValueNotifier<bool> showEndedCanceled = ValueNotifier<bool>(true);

  GetIt get adViewButton => locator;

  Widget _header(
      BuildContext context, GetOrderResModel orderData, AppLocalizations t) {
    print('applyTTT : ${orderData.order!.worker_type}');
    String statusText() {
      switch (orderData.order!.applied!) {
        case "0":
          return t.translate("requestSent");
        case "1":
          return t.translate("requestAccepted");
        case "2":
          return t.translate("requestRejected");
        case "3":
          return t.translate("requestAcceptedByEmployer");
        case "4":
          return t.translate("orderCancelled");
        case "5":
          return t.translate("workerDidNotGo");
        case "6":
          return t.translate("completedSuccessfully");
        default:
          return t.translate("requestCancelledByWorker");
      }
    }

    Color statusColor() {
      switch (orderData.order!.applied!) {
        case "0":
          return const Color(0xffEBBE08);
        case "1":
          return const Color(0xffEE7317);
        case "2":
          return const Color(0xff313131);
        case "3":
          return const Color(0xff1A4916);
        case "4":
          return const Color(0xffDE1D0F);
        case "5":
          return const Color(0xff53278A);
        case "6":
          return const Color(0xff01B460);
        default:
          return const Color(0xff2F5ED6);
      }
    }

    return Container(
      margin: EdgeInsets.only(
        left: 12.w,
        right: 22.w,
        top: 5,
        bottom: 14.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
                        orderData.order!.owner_type_name != null &&
                                orderData.order!.owner_type_name!.isNotEmpty
                            ? Decoder.text(orderData.order!.owner_type_name!)[0]
                            : "A",
                        style: FontConst.font.w600().px22().c(
                              ColorConst.purpleW500,
                            ),
                      ),
                    ),
                  ),
                  if (orderData.order!.is_vip != '0' &&
                      orderData.order!.is_vip != null)
                    Positioned(
                      top: -1.h,
                      right: 0,
                      left: 0,
                      child: SvgPicture.asset(
                        IconConst.crown,
                        width: 25.w,
                        color: const Color(0xFFDBA932),
                      ),
                    )
                ],
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150.w,
                    child: orderData.order!.worker_type_name != null
                        ? Text(
                            Decoder.text(orderData.order!.worker_type_name!),
                            style: FontConst.font.w500().px16().c(
                                  ColorConst.dark,
                                ),
                          )
                        : const Text('-'),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  SizedBox(
                    width: 150.w,
                    child: orderData.order!.owner_type_name != null
                        ? Text(
                            Decoder.text(orderData.order!.owner_type_name!),
                            overflow: TextOverflow.ellipsis,
                            style: FontConst.font.w400().px14().c(
                                  ColorConst.lightDark,
                                ),
                          )
                        : const Text('-'),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'ID #${orderData.order!.id}',
                style: FontConst.font.c(const Color(0xff929292)),
              ),
              SizedBox(
                height: 8.h,
              ),
              orderData.order != null &&
                      orderData.order!.applied != null &&
                      orderData.order!.applied != '' &&
                      orderData.order!.applied!.isNotEmpty
                  ? Container(
                      width: 130.w,
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: statusColor(),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              statusText(),
                              textAlign: TextAlign.center,
                              style: FontConst.font
                                  .c(Colors.white)
                                  .copyWith(fontSize: 10.sp)
                                  .w500(),
                            ),
                          ],
                        ),
                      ),
                    )
                  : (orderData.order!.status!.isNotEmpty &&
                          orderData.order!.applied != '')
                      ? Container(
                          padding: EdgeInsets.all(
                            7.h,
                          ),
                          width: 85.w,
                          decoration: BoxDecoration(
                            color: orderData.order!.status == '0'
                                ? ColorConst.orangeStatus
                                : orderData.order!.status.toString() == '3'
                                    ? Colors.black
                                    : orderData.order!.status.toString() == '4'
                                        ? const Color(0xffE90B0B)
                                        : ColorConst.secondary,
                            borderRadius: BorderRadius.circular(
                              12.r,
                            ),
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                  orderData.order!.status == '0'
                                      ? t.translate("active")
                                      : orderData.order!.status == '1'
                                          ? t.translate("completed")
                                          : orderData.order!.status
                                                      .toString() ==
                                                  '2'
                                              ? t.translate("ended")
                                              : orderData.order!.status
                                                          .toString() ==
                                                      '3'
                                                  ? t.translate("archived")
                                                  : t.translate("cancelled"),
                                  textAlign: TextAlign.center,
                                  style: FontConst.font.w400().px10().c(
                                        orderData.order!.status == '3'
                                            ? Colors.black
                                            : ColorConst.whiteSupporter,
                                      ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
            ],
          )
        ],
      ),
    );
  }

  Widget _body(BuildContext context, List<GetApplieds> employees,
      GetOrderResModel orderData, AppLocalizations t) {
    //  print('attends ${orderData.applied_users!.length}');
    ValueNotifier<bool> fav =
        ValueNotifier(orderData.order!.saved == '0' ? false : true);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            orderData.order!.views != null && orderData.order!.views!.isNotEmpty
                ? IconAndText(
                    IconConst.show,
                    t
                        .translate("viewed")
                        .replaceFirst("\$p", orderData.order!.views!),
                    Colors.orange)
                : const Spacer(),
            locator.get<GetStorage>().read('role') == 'Roles.Worker'
                // semed bax
                ? BlocProvider(
                    create: (context) => GeneralCubit<UpdateSavedOrdersService,
                        UpdateSavedOrdersReqModel>(),
                    child: BlocListener<
                            GeneralCubit<UpdateSavedOrdersService,
                                UpdateSavedOrdersReqModel>,
                            GeneralState>(
                        listener: (context, state) {
                          if (state is GeneralSuccess) {
                            fav.value = !fav.value;
                          }
                        },
                        child: ValueListenableBuilder<bool>(
                            valueListenable: fav,
                            builder: (context, value, child) {
                              // value = widget.adEntity.saved == '0'
                              //     ? false
                              //     : true;

                              return IconButton(
                                  onPressed: () async {
                                    //BlocProvider.of<GeneralCubit<UpdateSavedOrdersService, UpdateSavedOrdersReqModel>>(context).call(UpdateSavedOrdersReqModel(

                                    // fav.value = !fav.value;
                                    await context
                                        .read<
                                            GeneralCubit<
                                                UpdateSavedOrdersService,
                                                UpdateSavedOrdersReqModel>>()
                                        .generalRequest(
                                            UpdateSavedOrdersReqModel(
                                          id: orderData.order!.id,
                                          type: !fav.value ? '0' : '1',
                                        ));
                                  },
                                  icon: Icon(fav.value
                                      ? Icons.bookmark
                                      : Icons.bookmark_outline));
                            })),
                  )
                : const SizedBox()
          ],
        ),
        if (orderData.order!.attended_people!.isNotEmpty &&
            orderData.order!.count!.isNotEmpty)
          IconAndText(
            IconConst.done,
            "${orderData.order!.attended_people ?? '0'} / ${orderData.order!.count}",
            // context.loc.applicantCounter
            //     .replaceAll("\$a", widget.adEntity.attendees)
            //     .replaceAll(
            //       "\$t",
            //       widget.adEntity.count,
            //     ),
            const Color(0xFF99DB71),
          ),
        if (orderData.order!.work_date!.isNotEmpty)
          IconAndText(
            IconConst.calendar,
            '${t.translate('deadline')}  ${DateFormat("d MMMM, yyyy").format(DateTime.parse(orderData.order!.work_date!))}',
            ColorConst.blue,
          ),
        if (orderData.order!.work_hours!.isNotEmpty)
          IconAndText(
            IconConst.time,
            orderData.order!.work_hours!.fromBase64,
            ColorConst.blue,
          ),
        if (orderData.order!.address!.isNotEmpty)
          IconAndText(
            IconConst.location,
            Decoder.text(orderData.order!.address!),
            ColorConst.orange,
          ),
        if (orderData.order!.gender!.isNotEmpty)
          IconAndText(
            orderData.order!.gender == "0"
                ? IconConst.man
                : orderData.order!.gender == "1"
                    ? IconConst.woman
                    : IconConst.gender,
            orderData.order!.gender == "0"
                ? t.translate("male") // context.loc.male
                : orderData.order!.gender == "1"
                    ? t.translate("female") // context.loc.female
                    : t.translate("allGender"), //context.loc.allGender,
            ColorConst.blue,
          ),
        if (orderData.order!.order_type != null &&
            orderData.order!.order_type!.isNotEmpty)
          locator.get<GetStorage>().read('role') != 'Roles.Worker'
              ? Row(
                  children: [
                    IconAndText(
                        orderData.order!.order_type == '0'
                            ? IconConst.fund
                            : IconConst.starFull,
                        orderData.order!.order_type == '0'
                            ? t.translate("economic")
                            : t.translate("express"),
                        orderData.order!.order_type == '0'
                            ? ColorConst.ekonomColor
                            : ColorConst.exspressColor),
                    SizedBox(
                      width: 10.w,
                    ),
                    if (orderData.order!.total!.isNotEmpty &&
                        orderData.order!.total != null)
                      Container(
                        padding: EdgeInsets.only(
                            right: 10.w, left: 10.w, top: 7.h, bottom: 5.h),
                        decoration: BoxDecoration(
                          color: const Color(0xffBCF5A1),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          '${orderData.order!.total!} AZN',
                          textAlign: TextAlign.center,
                          style: FontConst.font
                              .w400()
                              .px12()
                              .c(const Color(0xff4FAB30)),
                        ),
                      )
                  ],
                )
              : const SizedBox(),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          height: 120.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: GoogleMap(
              circles: {
                Circle(
                  strokeColor: Colors.blue,
                  fillColor: Colors.blue.withOpacity(0.3),
                  circleId: CircleId(orderData.order!.address!),
                  strokeWidth: 1,
                  center: LatLng(double.tryParse(orderData.order!.lat!)!,
                      double.tryParse(orderData.order!.lon!)!),
                  radius: 10000,
                )
              },
              mapType: MapType.normal,
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(
                // bearing: 192.8334901395799,
                target: LatLng(double.tryParse(orderData.order!.lat!)!,
                    double.tryParse(orderData.order!.lon!)!),
                // tilt: 59.440717697143555,
                zoom: 10,
              ),
              // markers: {
              //   Marker(
              //     markerId: const MarkerId(
              //       "position",
              //     ),
              //     position: LatLng(double.tryParse(orderData.order!.lat!)!,
              //         double.tryParse(orderData.order!.lon!)!),
              //   )
              // },
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        if (orderData.order!.description!.isNotEmpty)
          Padding(
            padding: EdgeInsets.all(
              10.r,
            ),
            child: SizedBox(
              width: 375.w,
              child: Text(
                orderData.order!.description!.fromBase64,
                style: FontConst.font.px12().w400().copyWith(height: 1.5),
              ),
            ),
          ),
        SizedBox(
          height: 40.h,
        ),
        locator.get<GetStorage>().read('role') == 'Roles.Worker' &&
                orderData.order!.status == '0'
            ? orderData.order!.applied == null
                ? BlocProvider(
                    create: (context) =>
                        GeneralCubit<ApplyOrderService, ApplyOrderReqModel>(),
                    child: BlocConsumer<
                        GeneralCubit<ApplyOrderService, ApplyOrderReqModel>,
                        GeneralState>(
                      listener: (context, state) {
                        if (state is GeneralSuccess) {
                          if ((state.data as StatusModel).status == 1) {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => const SuccessfullPage()));
                            //come here w
                            customDialogBox(
                              context,
                              () {
                                context
                                    .read<
                                        GeneralCubit<GetOrderService,
                                            GetOrderReqModel>>()
                                    .generalRequest(GetOrderReqModel(
                                        id: orderData.order!.id));
                                Navigator.pop(context);
                              },
                              t.translate("confirmApply"),
                              t,
                              title: t.translate("confirmApplyTitle"),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(t.translate("errorEccured")),
                              behavior: SnackBarBehavior.floating,
                            ));
                          }
                        } else if (state is GeneralFail) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(t.translate("errorEccured")),
                            behavior: SnackBarBehavior.floating,
                          ));
                        }
                      },
                      builder: (context, state) {
                        return applyButton(() {
                          context
                              .read<
                                  GeneralCubit<ApplyOrderService,
                                      ApplyOrderReqModel>>()
                              .generalRequest(
                                ApplyOrderReqModel(
                                  id: orderData.order!.id!,
                                  type: '0',
                                ),
                              );
                        }, t);
                      },
                    ),
                  )
                : orderData.order!.applied != null &&
                        orderData.order!.applied != 'null' &&
                        (orderData.order!.applied == '0' ||
                            orderData.order!.applied == '1')
                    ? cancelButton(() {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChooseAReasonPage(
                            orderId: orderData.order!.id!,
                          ),
                        ));
                      }, t)
                    : const SizedBox()
            : locator.get<GetStorage>().read('role') == 'Roles.Owner' &&
                    orderData.order!.status == '0'
                ? BlocProvider(
                    create: (context) => GeneralCubit<CancelOrderOwnerService,
                        CancelOrderOwnerReqModel>(),
                    child: BlocConsumer<
                        GeneralCubit<CancelOrderOwnerService,
                            CancelOrderOwnerReqModel>,
                        GeneralState>(
                      listener: (context, state) {
                        if (state is GeneralSuccess) {
                          if ((state.data as StatusModel).status == 1) {
                            context
                                .read<
                                    GeneralCubit<GetOrderService,
                                        GetOrderReqModel>>()
                                .generalRequest(GetOrderReqModel(
                                  id: orderData.order!.id,
                                ));
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(t.translate("successfull")),
                              behavior: SnackBarBehavior.floating,
                            ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(t.translate("errorEccured")),
                              behavior: SnackBarBehavior.floating,
                            ));
                          }
                        } else if (state is GeneralFail) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(t.translate("errorEccured")),
                            behavior: SnackBarBehavior.floating,
                          ));
                        }
                      },
                      builder: (context, state) {
                        return cancelButton(() {
                          customDialogBox(context, () {
                            context
                                .read<
                                    GeneralCubit<CancelOrderOwnerService,
                                        CancelOrderOwnerReqModel>>()
                                .generalRequest(
                                  CancelOrderOwnerReqModel(
                                    id: orderData.order!.id!,
                                  ),
                                );
                            Navigator.pop(context);
                          }, t.translate("confirmCancelOrder"), t);
                        }, t);
                      },
                    ),
                  )
                : const SizedBox(),
        SizedBox(
          height: 30.h,
        ),
        locator.get<GetStorage>().read('role') == 'Roles.Worker'
            ? const SizedBox()
            : orderData.order!.status! == '0'
                ? Column(
                    children: [
                      employeesList(showEmploye, t.translate("employees"),
                          employees.isEmpty, t),
                      ValueListenableBuilder(
                        valueListenable: showEmploye,
                        builder: (context, value, child) {
                          return value
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: employees.length,
                                  itemBuilder: (context, index) {
                                    return employeeItem(
                                        context, employees[index], index, () {
                                      setState(() {});
                                    }, EmployeeType.employee.toString(), t);
                                  },
                                )
                              : const SizedBox();
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      const Divider(
                        color: ColorConst.border,
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      employeesList(showAccapted, t.translate("accapted"),
                          accapted.isEmpty, t),
                      ValueListenableBuilder(
                        valueListenable: showAccapted,
                        builder: (context, value, child) {
                          return value
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: accapted.length,
                                  itemBuilder: (context, index) {
                                    return employeeItem(
                                        context, accapted[index], index, () {
                                      setState(() {});
                                    }, EmployeeType.accapted.toString(), t);
                                  },
                                )
                              : const SizedBox();
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      const Divider(
                        color: ColorConst.border,
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      employeesList(showCanceled, t.translate("cancelled"),
                          canceled.isEmpty, t),
                      ValueListenableBuilder(
                        valueListenable: showCanceled,
                        builder: (context, value, child) {
                          return value
                              ? SizedBox(
                                  // height: 200.h,
                                  width: 370.w,
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: canceled.length,
                                    itemBuilder: (context, index) {
                                      return newCancelledCard(
                                        context,
                                        canceled[index].person_name != null
                                            ? canceled[index]
                                                .person_name!
                                                .fromBase64
                                            : '--',
                                        t,
                                        jobTitle: canceled[index].id,
                                        personID: canceled[index].user_id,
                                        img: canceled[index].img,
                                        cause: canceled[index].reason,
                                        status: canceled[index].status,
                                      );

                                      // cancelledEmpItem(
                                      //     context, canceled[index], t);
                                    },
                                  ),
                                )
                              : const SizedBox();
                        },
                      ),
                    ],
                  )
                //review
                : orderData.order!.status! == '1'
                    ? Column(
                        children: [
                          orderData.applied_users!.isNotEmpty
                              ? InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => BlocProvider(
                                                  create: (context) => GeneralCubit<
                                                      RateWorkerOwnerService,
                                                      RateWorkerOwnerReqModel>(),
                                                  child: AddReviewPage(
                                                    orderId:
                                                        orderData.order!.id!,
                                                    applieds:
                                                        orderData.applied_users,
                                                  ),
                                                )))
                                        .then((value) => context
                                            .read<
                                                GeneralCubit<GetOrderService,
                                                    GetOrderReqModel>>()
                                            .generalRequest(GetOrderReqModel(
                                                id: orderData.order!.id)));
                                  },
                                  child: Container(
                                    width: 320.w,
                                    height: 50.h,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.w, vertical: 10.h),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 246, 237, 155),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        t.translate("rateOrder"),
                                        //  t.translate("review"),
                                        style: FontConst.font.c(Colors.black87),
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          SizedBox(
                            height: 15.h,
                          ),
                          employeesList(showEndedAccapted,
                              t.translate("accapted"), accapted.isEmpty, t),
                          ValueListenableBuilder(
                              valueListenable: showEndedAccapted,
                              builder: (context, value, child) {
                                return value
                                    ? Column(
                                        children: [
                                          ...accapted
                                              .map((e) => employeeCard(context,
                                                  e.person_name!.fromBase64, t,
                                                  jobTitle:
                                                      e.worker_type!.fromBase64,
                                                  img: e.img,
                                                  personID: e.user_id,
                                                  rating: e.rate == null
                                                      ? -1
                                                      : double.tryParse(
                                                          e.rate!)!,
                                                  review: e.comment))
                                              .toList(),
                                        ],
                                      )
                                    : const SizedBox();
                              }),
                          SizedBox(
                            height: 20.h,
                          ),
                          const Divider(
                            color: ColorConst.border,
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          employeesList(showEndedCanceled,
                              t.translate("cancelled"), canceled.isEmpty, t),
                          ValueListenableBuilder(
                              valueListenable: showEndedCanceled,
                              builder: (context, value, child) {
                                return value
                                    ? Column(
                                        children: [
                                          ...canceled
                                              .map((e) => newCancelledCard(
                                                  context,
                                                  e.person_name!.fromBase64,
                                                  t,
                                                  jobTitle: e.id,
                                                  personID: e.user_id,
                                                  img: e.img,
                                                  cause: e.reason))
                                              .toList(),
                                        ],
                                      )
                                    : const SizedBox();
                              }),
                          SizedBox(
                            height: 20.h,
                          ),
                          const Divider(
                            color: ColorConst.border,
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          employeesList(showDidntCome,
                              t.translate("didNotCome"), didntCome.isEmpty, t),
                          ValueListenableBuilder(
                              valueListenable: showDidntCome,
                              builder: (context, value, child) {
                                return value
                                    ? Column(
                                        children: [
                                          ...didntCome
                                              .map((e) => employeeCard(context,
                                                  e.person_name!.fromBase64, t,
                                                  jobTitle:
                                                      e.worker_type!.fromBase64,
                                                  personID: e.user_id,
                                                  img: e.img,
                                                  rating: e.rate == null
                                                      ? -1
                                                      : double.tryParse(
                                                          e.rate!)!,
                                                  review: e.comment))
                                              .toList(),
                                        ],
                                      )
                                    : const SizedBox();
                              }),
                        ],
                      )
                    : Column(
                        children: [
                          employeesList(showEndedAccapted,
                              t.translate("accapted"), accapted.isEmpty, t),
                          ValueListenableBuilder(
                              valueListenable: showEndedAccapted,
                              builder: (context, value, child) {
                                return value
                                    ? Column(
                                        children: [
                                          ...accapted
                                              .map((e) => employeeCard(context,
                                                  e.person_name!.fromBase64, t,
                                                  jobTitle:
                                                      e.worker_type!.fromBase64,
                                                  personID: e.user_id,
                                                  img: e.img,
                                                  rating: e.rate == null
                                                      ? -1
                                                      : double.tryParse(
                                                          e.rate!)!,
                                                  review: e.comment))
                                              .toList(),
                                        ],
                                      )
                                    : const SizedBox();
                              }),
                          SizedBox(
                            height: 20.h,
                          ),
                          const Divider(
                            color: ColorConst.border,
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          employeesList(showEndedCanceled,
                              t.translate("cancelled"), canceled.isEmpty, t),
                          ValueListenableBuilder(
                              valueListenable: showEndedCanceled,
                              builder: (context, value, child) {
                                return value
                                    ? Column(
                                        children: [
                                          ...canceled
                                              .map((e) => newCancelledCard(
                                                    context,
                                                    e.person_name!.fromBase64,
                                                    t,
                                                    jobTitle: e.id,
                                                    personID: e.user_id,
                                                    img: e.img,
                                                  ))
                                              .toList(),
                                        ],
                                      )
                                    : const SizedBox();
                              }),
                          SizedBox(
                            height: 20.h,
                          ),
                          const Divider(
                            color: ColorConst.border,
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          employeesList(showDidntCome,
                              t.translate("didNotCome"), didntCome.isEmpty, t),
                          ValueListenableBuilder(
                              valueListenable: showDidntCome,
                              builder: (context, value, child) {
                                return value
                                    ? Column(
                                        children: [
                                          ...didntCome
                                              .map((e) => employeeCard(context,
                                                  e.person_name!.fromBase64, t,
                                                  jobTitle:
                                                      e.worker_type!.fromBase64,
                                                  img: e.img,
                                                  personID: e.user_id,
                                                  rating: e.rate == null
                                                      ? -1
                                                      : double.tryParse(
                                                          e.rate!)!,
                                                  review: e.comment))
                                              .toList(),
                                        ],
                                      )
                                    : const SizedBox();
                              }),
                        ],
                      ),
        SizedBox(
          height: 100.h,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations? t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop(context);
            //
          },
          child: Center(
            child: SvgPicture.asset(
              IconConst.back,
              height: 15.h,
              width: 15.h,
            ),
          ),
        ),
        title: Text(
          t!.translate("myAdvertisement"),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<
              GeneralCubit<OwnerOrderAcceptDeclineService,
                  OwnerOrderAcceptDeclineReqModel>>(
            create: (context) => GeneralCubit<OwnerOrderAcceptDeclineService,
                OwnerOrderAcceptDeclineReqModel>(),
          )
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<
                GeneralCubit<OwnerOrderAcceptDeclineService,
                    OwnerOrderAcceptDeclineReqModel>,
                GeneralState>(listener: (context, state) {
              if (state is GeneralSuccess) {
                if ((state.data as StatusModel).status == 1) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(t.translate("successfull")),
                    behavior: SnackBarBehavior.floating,
                  ));
                  setState(() {
                    context
                        .read<GeneralCubit<GetOrderService, GetOrderReqModel>>()
                        .generalRequest(GetOrderReqModel(
                          id: widget.adEntity.id,
                        ));
                  });
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(t.translate("errorEccured")),
                    behavior: SnackBarBehavior.floating,
                  ));
                }
              } else if (state is GeneralFail) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(t.translate("errorEccured")),
                  behavior: SnackBarBehavior.floating,
                ));
              }
            }),
          ],
          child: BlocBuilder<GeneralCubit<GetOrderService, GetOrderReqModel>,
              GeneralState>(
            builder: (context, state) {
              if (state is GeneralLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is GeneralFail) {
                return SizedBox(
                  height: 750.h,
                  width: 375.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(ImageConst.noRewiew),
                      SizedBox(height: 10.h),
                      Text(t.translate("unexpected")),
                    ],
                  ),
                );
              }

              if (state is GeneralSuccess) {
                GetOrderResModel orderData = state.data as GetOrderResModel;

                if (orderData.applied_users != null) {
                  employees = orderData.applied_users!
                      .where((element) => element.status == '0')
                      .toList();
                  accapted = orderData.applied_users!
                      .where((element) => element.status == '1')
                      .toList();
                  canceled = orderData.applied_users!
                      .where((element) =>
                          element.status == '2' ||
                          element.status == '3' ||
                          element.status == '7')
                      .toList();
                  didntCome = orderData.applied_users!
                      .where((element) =>
                          element.is_not_come == '1' || element.status == '5')
                      .toList();
                }

                return SizedBox(
                  height: 812.h,
                  width: 375.w,
                  child: ListView(
                    children: [
                      _header(
                        context,
                        orderData,
                        t,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: _body(context, employees, orderData, t),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Text(t.translate("error")),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
