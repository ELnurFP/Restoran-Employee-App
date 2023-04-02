import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:template/constants/constants.dart';
import 'package:template/dependency_injection.dart';
import 'package:template/infrastructure/remote/profile_info_service.dart';
import 'package:template/infrastructure/remote/profile_update_image_service.dart';
import 'package:template/language/localization.dart';
import 'package:template/models/profile_info_res_model.dart';

import 'package:template/presentation/account_page/tabs/my_profile/my_profile.dart';

import '../../../../../cubit/general_cubit.dart';
import '../../../../../infrastructure/remote/profile_update_service.dart';
import '../../../../../models/general_req_model.dart';
import '../../../../../models/profile_update_image_req_model.dart';
import '../../../../../models/profile_update_req_model.dart';

Widget profilImage(
    BuildContext context,
    AppLocalizations t,
    double? percent,
    String? url,
    String? backImageUrl,
    File? ppfile,
    ProfileInfoResModel? profileInfoResModel,
    {bool isView = false}) {
  percent = percent != null ? double.parse(percent.toStringAsFixed(2)) : 0;
  return Stack(
    alignment: Alignment.center,
    children: [
      Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            width: double.infinity,
            height: 147.h,
            padding: EdgeInsets.symmetric(vertical: 17.h),
            decoration: backImageUrl != ''
                ? BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                      image: NetworkImage('https://rayza.az/$backImageUrl'),
                      fit: BoxFit.cover,
                      onError: (error, stackTrace) {
                        return;
                      },
                    ),
                  )
                : const BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                      image: AssetImage(ImageConst.phBack),
                      fit: BoxFit.cover,
                    ),
                  ),
            // child: backImageUrl != ''
            //     ? Image.network(
            //         'https://rayza.az/$backImageUrl',
            //         fit: BoxFit.cover,
            //         errorBuilder: (context, error, stackTrace) {
            //           return Image.asset(
            //             ImageConst.phBack,
            //             fit: BoxFit.cover,
            //           );
            //         },
            //         frameBuilder:
            //             (context, child, frame, wasSynchronouslyLoaded) {
            //           if (wasSynchronouslyLoaded) {
            //             return child;
            //           }
            //           return AnimatedOpacity(
            //             opacity: frame == null ? 0 : 1,
            //             duration: const Duration(seconds: 1),
            //             curve: Curves.easeOut,
            //             child: child,
            //           );
            //         },
            //       )
            //     : Image.asset(
            //         ImageConst.phBack,
            //         fit: BoxFit.cover,
            //       ),
          ),
          SizedBox(
            height: 70.h,
          ),
        ],
      ),
      isView
          ? Positioned(
              top: 30.h,
              left: 20.w,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.of(context).pop(context);
                },
              ),
            )
          : const SizedBox(),
      Positioned(
        top: 90.h,
        child: Container(
          padding: EdgeInsets.all(4.r),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: CircularPercentIndicator(
            progressColor: isView ||
                    locator.get<GetStorage>().read('role') == 'Roles.Worker'
                ? percent == 100
                    ? const Color(0xff3E8937)
                    : percent >= 99 && percent >= 80
                        ? const Color(0xff3E8937)
                        : percent >= 79 && percent >= 60
                            ? const Color(0xffA5D631)
                            : percent >= 59 && percent >= 40
                                ? const Color(0xffFBBC05)
                                : percent >= 39 && percent >= 20
                                    ? const Color(0xffF6E631)
                                    : const Color(0xffEF3910)
                : Colors.transparent,
            circularStrokeCap: CircularStrokeCap.round,
            percent: (percent) / 100,
            radius: 55.r,
            backgroundColor: Colors.white,
            center: CircleAvatar(
                backgroundColor: Colors.white,
                radius:
                    locator.get<GetStorage>().read('role') == 'Roles.Worker' ||
                            isView
                        ? 45.r
                        : 50.h,
                child: url == ''
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100.r),
                        child: Image.asset(
                          ImageConst.ph1,
                          fit: BoxFit.fitHeight,
                          height: locator.get<GetStorage>().read('role') ==
                                  'Roles.Worker'
                              ? 100.h
                              : 140.h,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(90.r),
                        child: Image.network(
                          'https://rayza.az/$url',
                          width: 90.w,
                          height: 90.w,
                          fit: BoxFit.cover,
                          frameBuilder:
                              (context, child, frame, wasSynchronouslyLoaded) {
                            if (wasSynchronouslyLoaded) {
                              return child;
                            }
                            return AnimatedOpacity(
                              opacity: frame == null ? 0 : 1,
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeOut,
                              child: child,
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                color: ColorConst.secondary,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      )),
          ),
        ),
      ),
      if (isView || locator.get<GetStorage>().read('role') == 'Roles.Worker')
        Positioned(
          top: 190.h,
          right: 89.w,
          child: Text(
            '$percent %',
            style: FontConst.font.px12().w400().c(Colors.black),
          ),
        ),
      isView
          ? const SizedBox()
          : Positioned(
              top: 155.h,
              right: 20.w,
              child: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                                providers: [
                                  BlocProvider<
                                      GeneralCubit<ProfileUpdateService,
                                          ProfileUpdateReqModel>>(
                                    create: (context) => GeneralCubit<
                                        ProfileUpdateService,
                                        ProfileUpdateReqModel>(),
                                  ),
                                  BlocProvider<
                                      GeneralCubit<ProfileUpdateImageService,
                                          ProfileUpdateImageReqModel>>(
                                    create: (context) => GeneralCubit<
                                        ProfileUpdateImageService,
                                        ProfileUpdateImageReqModel>(),
                                  )
                                ],
                                child: MyProfilePage(
                                  profileInfoResModel: profileInfoResModel,
                                ),
                              )))
                      .then((value) => context
                          .read<
                              GeneralCubit<ProfileInfoService,
                                  GeneralInfoReqModel>>()
                          .generalRequest(GeneralInfoReqModel()));
                },
                child: Row(
                  children: [
                    SvgPicture.asset(IconConst.editName, height: 18.h),
                    SizedBox(width: 5.w),
                    SizedBox(
                      width: 80,
                      height: 20,
                      child: FittedBox(
                        child: Text(
                          t.translate('edit'),
                          style: FontConst.font
                              .px14()
                              .w500()
                              .c(const Color(0xffFBBC05)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
    ],
  );
}
