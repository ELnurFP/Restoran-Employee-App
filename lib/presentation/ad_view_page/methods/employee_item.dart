// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:template/configs/base64_conventer.dart';
import 'package:template/language/localization.dart';
import 'package:template/models/get_order_res_model.dart';
import 'package:template/presentation/ad_view_page/methods/see_button.dart';
import 'package:template/presentation/widgets/custom_dialog.dart';

import '../../../constants/constants.dart';
import '../../../cubit/general_cubit.dart';
import '../../../infrastructure/remote/owner_order_accept_decline_service.dart';
import '../../../infrastructure/remote/profile_info_service.dart';
import '../../../models/general_req_model.dart';
import '../../../models/owner_order_accept_decline_req_model.dart';
import '../../main_page/bottom_pages/Profile Page/profile_view_page.dart';
import 'employees_card_button.dart';

Widget employeeItem(BuildContext c, GetApplieds? emp, int index,
    Function() seeOnTap, String type, AppLocalizations t) {
  print('empIIIII: ${emp!.img}');
  return Container(
    height: 50.h,
    width: 350.w,
    margin: EdgeInsets.symmetric(
      horizontal: 2.w,
      vertical: 7.h,
    ),
    padding: EdgeInsets.symmetric(
      horizontal: 10.w,
      vertical: 5.h,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.r),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 14.r,
          backgroundColor: ColorConst.secondary,
          // foregroundImage:
          //     emp.img == null || emp.img!.isEmpty || emp.img == 'null'
          //         ? null
          //         : NetworkImage(
          //             ('https://rayza.az/${emp.img!}'),
          //           ),
          child: emp.img == null || emp.img!.isEmpty || emp.img == 'null'
              ? Padding(
                  padding: EdgeInsets.all(7.r),
                  child: SvgPicture.asset(
                    IconConst.person,
                    color: ColorConst.primary,
                    height: 22.h,
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(50.r),
                  child: Image.network('https://rayza.az/${emp.img!}',
                      fit: BoxFit.cover,
                      width: 30.w,
                      errorBuilder: (context, error, stackTrace) => Padding(
                            padding: EdgeInsets.all(7.r),
                            child: SvgPicture.asset(
                              IconConst.person,
                              color: ColorConst.primary,
                              fit: BoxFit.cover,
                              width: 30.w,
                            ),
                          ),
                      loadingBuilder: (context, child, loadingProgress) =>
                          loadingProgress == null
                              ? child
                              : Padding(
                                  padding: EdgeInsets.all(7.r),
                                  child: SvgPicture.asset(
                                    IconConst.person,
                                    color: ColorConst.primary,
                                    width: 30.h,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                ),
        ),
        SizedBox(width: 10.w),
        Text(
          emp.img == null || emp.img!.isEmpty || emp.img == 'null'
              ? emp.person_name!.fromBase64
              : '',
          style: FontConst.font.px16().w500().c(
                ColorConst.dark,
              ),
        ),
        SizedBox(width: 10.w),
        seeButton(() {
          Navigator.of(c).push(
            MaterialPageRoute(
              builder: (context) => BlocProvider<
                  GeneralCubit<ProfileViewService, GeneralInfoReqModel>>(
                create: (context) =>
                    GeneralCubit<ProfileViewService, GeneralInfoReqModel>()
                      ..generalRequest(
                          GeneralInfoReqModel(userId: emp.user_id!)),
                child: const ProfileViewPage(),
              ),
            ),
          );
        }, t),
        const Spacer(),
        type == 'EmployeeType.employee'
            ? employeeCardButton(
                () async {
                  customDialogBox(
                    c,
                    () async {
                      await c
                          .read<
                              GeneralCubit<OwnerOrderAcceptDeclineService,
                                  OwnerOrderAcceptDeclineReqModel>>()
                          .generalRequest(OwnerOrderAcceptDeclineReqModel(
                            id: emp.id,
                            type: '0',
                          ));
                    },
                    t.translate("confirmHire"),
                    t,
                    title: t.translate("confirmHireTitle"),
                  );
                },
                t,
                isYes: true,
                isCalcel: false,
              )
            : employeeCardButton(() async {
                customDialogBox(
                  c,
                  () async {
                    await c
                        .read<
                            GeneralCubit<OwnerOrderAcceptDeclineService,
                                OwnerOrderAcceptDeclineReqModel>>()
                        .generalRequest(
                          OwnerOrderAcceptDeclineReqModel(
                            id: emp.id,
                            type: '2',
                          ),
                        );
                  },
                  t.translate("confirmDelete"),
                  t,
                  title: t.translate("confirmDeleteTitle"),
                );
              }, t, isYes: false, isCalcel: true),
        SizedBox(width: 10.w),
        type == 'EmployeeType.employee'
            ? employeeCardButton(
                () async {
                  customDialogBox(
                    c,
                    () async {
                      await c
                          .read<
                              GeneralCubit<OwnerOrderAcceptDeclineService,
                                  OwnerOrderAcceptDeclineReqModel>>()
                          .generalRequest(
                            OwnerOrderAcceptDeclineReqModel(
                              id: emp.id,
                              type: '1',
                            ),
                          );
                    },
                    t.translate("confirmDeleteWorker"),
                    t,
                    title: t.translate("confirmDeleteWorkerTitle"),
                  );
                },
                t,
                isYes: false,
              )
            : const SizedBox(),
      ],
    ),
  );
}
