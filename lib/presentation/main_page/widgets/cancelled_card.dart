// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:template/configs/base64_conventer.dart';
import 'package:template/language/localization.dart';

import '../../../constants/color_constant.dart';
import '../../../constants/font_constant.dart';
import '../../../constants/icon_constant.dart';
import '../../../cubit/general_cubit.dart';
import '../../../infrastructure/remote/profile_info_service.dart';
import '../../../models/general_req_model.dart';
import '../../core/shadows.dart';
import '../bottom_pages/Profile Page/profile_view_page.dart';

Padding newCancelledCard(BuildContext context, String? name, AppLocalizations t,
    {String? jobTitle,
    required String? personID,
    String? cause,
    String? img,
    String? status}) {
  ValueNotifier<bool> show = ValueNotifier<bool>(true);
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.h),
    child: Container(
      width: 370.w,
      decoration: BoxDecoration(
          color: ColorConst.primary,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: Shadows.shadow1),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                  radius: 14.r,
                  backgroundColor: ColorConst.secondary,
                  foregroundImage: img == null || img.isEmpty || img == 'null'
                      ? null
                      : NetworkImage(
                          ('https://rayza.az/$img'),
                        ),
                  child: img == null || img.isEmpty || img == 'null'
                      ? Padding(
                          padding: EdgeInsets.all(7.r),
                          child: SvgPicture.asset(
                            IconConst.person,
                            color: ColorConst.primary,
                            height: 22.h,
                          ),
                        )
                      : null),
              SizedBox(width: 10.w),
              Text(
                name == null || name.isEmpty || name == 'null' ? '' : name,
                style: FontConst.font.w400().px14().copyWith(
                      height: 1.5.sp,
                      letterSpacing: .5.sp,
                    ),
              ),
              SizedBox(width: 10.w),
              InkWell(
                onTap: () {
                  personID!.isNotEmpty
                      ? Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BlocProvider<
                                GeneralCubit<ProfileViewService,
                                    GeneralInfoReqModel>>(
                              create: (context) => GeneralCubit<
                                  ProfileViewService, GeneralInfoReqModel>()
                                ..generalRequest(
                                    GeneralInfoReqModel(userId: personID)),
                              child: const ProfileViewPage(),
                            ),
                          ),
                        )
                      : ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(t.translate('noProfile'))));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorConst.seeColors,
                      borderRadius: BorderRadius.circular(6.r)),
                  padding:
                      EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
                  child: Text(
                    t.translate("see"),
                    style: FontConst.font.w400().px14().copyWith(
                          height: 1.5.sp,
                          letterSpacing: .5.sp,
                          color: ColorConst.dark,
                        ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                t.translate("cause"),
                style: FontConst.font.w400().px12().copyWith(
                    height: 1.5.sp,
                    letterSpacing: .5.sp,
                    color: const Color(0xff9C9C9C)),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  show.value = !show.value;
                },
                child: ValueListenableBuilder(
                  valueListenable: show,
                  builder: (context, value, child) {
                    return Padding(
                      padding: EdgeInsets.all(10.0.w),
                      child: SizedBox(
                        width: 30.w,
                        height: 30.h,
                        child: Center(
                          child: SvgPicture.asset(
                              value ? IconConst.upArrow : IconConst.downArrow,
                              width: 15.w,
                              color: ColorConst.dark),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          ValueListenableBuilder(
              valueListenable: show,
              builder: (context, value, child) {
                return value
                    ? Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10.h),
                              Text(
                                cause == null ||
                                        cause == 'null' ||
                                        cause.trim() == ''
                                    ? t.translate("ownerCanceled")
                                    : cause.fromBase64,
                                style: FontConst.font.w400().px12().copyWith(
                                    height: 1.5.sp,
                                    letterSpacing: .5.sp,
                                    color: ColorConst.dark),
                              )
                            ],
                          ),
                        ),
                      )
                    : const SizedBox();
              }),
        ],
      ),
    ),
  );
}
