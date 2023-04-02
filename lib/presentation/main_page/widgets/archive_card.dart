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
import '../bottom_pages/Profile Page/methods/build_star_raiting.dart';
import '../bottom_pages/Profile Page/profile_view_page.dart';

Padding employeeCard(BuildContext context, String? name, AppLocalizations t,
    {String? jobTitle,
    double? rating,
    String? review,
    required String? personID,
    String? img}) {
  ValueNotifier<bool> show = ValueNotifier<bool>(false);
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.h),
    child: Container(
      width: 335.w,
      decoration: BoxDecoration(
          color: ColorConst.primary,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: Shadows.shadow1),
      padding: EdgeInsets.all(14.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                  radius: 14.r,
                  foregroundImage: img == null || img.isEmpty || img == 'null'
                      ? null
                      : NetworkImage(
                          ('https://rayza.az/$img'),
                        ),
                  child: img == null || img.isEmpty || img == 'null'
                      ? Padding(
                          padding: EdgeInsets.all(10.r),
                          child: SvgPicture.asset(
                            IconConst.person,
                            color: ColorConst.primary,
                            height: 18.r,
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider<
                          GeneralCubit<ProfileViewService,
                              GeneralInfoReqModel>>(
                        create: (context) => GeneralCubit<ProfileViewService,
                            GeneralInfoReqModel>()
                          ..generalRequest(
                              GeneralInfoReqModel(userId: personID)),
                        child: const ProfileViewPage(),
                      ),
                    ),
                  );
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
              const Spacer(),
              if (review != null && review.isNotEmpty)
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
          if (review != null && review.isNotEmpty)
            ValueListenableBuilder(
                valueListenable: show,
                builder: (context, value, child) {
                  return value
                      ? Padding(
                          padding: EdgeInsets.only(left: 35.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10.h),
                              Text(
                                //here
                                jobTitle!,
                                style: FontConst.font.w400().px12().copyWith(
                                    height: 1.5.sp,
                                    letterSpacing: .5.sp,
                                    color: const Color(0xff9C9C9C)),
                              ),
                              SizedBox(height: 10.h),
                              SizedBox(height: 10.h),
                              rating == -1
                                  ? SizedBox(
                                      width: 270.w,
                                    )
                                  : buildStarRating(rating!,
                                      size: 25.h, isCenter: false),
                              SizedBox(height: 10.h),
                              SizedBox(height: 10.h),
                              Text(
                                review.isNotEmpty ? review.fromBase64 : '',
                                style: FontConst.font.w400().px12().copyWith(
                                    height: 1.5.sp,
                                    letterSpacing: .5.sp,
                                    color: ColorConst.dark),
                              )
                            ],
                          ),
                        )
                      : const SizedBox();
                }),
        ],
      ),
    ),
  );
}
