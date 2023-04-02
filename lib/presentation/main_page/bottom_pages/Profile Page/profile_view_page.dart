import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/configs/base64_conventer.dart';
import 'package:template/constants/constants.dart';
import 'package:template/cubit/general_cubit.dart';
import 'package:template/cubit/general_state.dart';
import 'package:template/infrastructure/remote/profile_info_service.dart';
import 'package:template/language/localization.dart';
import 'package:template/models/general_req_model.dart';
import 'package:template/models/profile_info_res_model.dart';
import 'methods/about_tab.dart';
import 'methods/profile_image.dart';
import 'methods/rating_bar.dart';
import 'methods/review_card.dart';
import 'methods/user_info.dart';

class ProfileViewPage extends StatefulWidget {
  const ProfileViewPage({Key? key}) : super(key: key);

  @override
  State<ProfileViewPage> createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> {
  final ValueNotifier<int> _valueNotifier = ValueNotifier(0);

  @override
  void initState() {
    _valueNotifier.value = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations? t = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<GeneralCubit<ProfileViewService, GeneralInfoReqModel>,
          GeneralState>(
        builder: (context, state) {
          if (state is GeneralLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GeneralSuccess) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  profilImage(
                      context,
                      t!,
                      double.tryParse(((state.data as ProfileInfoResModel)
                              .userRates
                              ?.respects) ??
                          '0'),
                      (state.data as ProfileInfoResModel).thisUser?.img ?? '',
                      (state.data as ProfileInfoResModel).thisUser?.backImg ??
                          '',
                      null,
                      (state.data as ProfileInfoResModel),
                      isView: true), //217.h
                  userInfo(
                    "${((state.data as ProfileInfoResModel).thisUser?.personName ?? '').fromBase64} ${(((state.data as ProfileInfoResModel).thisUser?.personSurname) ?? '').fromBase64} ${((state.data as ProfileInfoResModel).thisUser?.personFatherName ?? '').fromBase64}",
                    ((state.data as ProfileInfoResModel)
                            .thisUser
                            ?.userTypeStatus) ??
                        '',
                    (state.data as ProfileInfoResModel).userStatues ?? [],
                    (state.data as ProfileInfoResModel).userRates?.rate == null
                        ? double.tryParse(((state.data as ProfileInfoResModel)
                                .userRates
                                ?.rate) ??
                            '0')
                        : 0,
                    (state.data as ProfileInfoResModel).userRates?.notGo,
                    t,
                    isView: true,
                  ), //80.h
                  SizedBox(height: 10.h),
                  DefaultTabController(
                    length: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TabBar(
                          onTap: (index) {
                            _valueNotifier.value = index;
                          },
                          indicatorColor: ColorConst.secondary,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorWeight: 6.h,
                          tabs: [
                            Tab(
                              child: Text(
                                t.translate('about').toUpperCase(),
                                style: FontConst.font
                                    .w500()
                                    .px16()
                                    .copyWith(color: const Color(0xff737373)),
                              ),
                            ),
                            Tab(
                              child: Text(
                                t.translate('review').toUpperCase(),
                                style: FontConst.font
                                    .w500()
                                    .px14()
                                    .copyWith(color: const Color(0xff737373)),
                              ),
                            ),
                          ],
                        ),
                        ValueListenableBuilder(
                          valueListenable: _valueNotifier,
                          builder: (context, value, child) {
                            return value == 0
                                ? aboutTab(
                                    t,
                                    (state.data as ProfileInfoResModel)
                                            .thisUser
                                            ?.gender ??
                                        '',
                                    (state.data as ProfileInfoResModel)
                                            .thisUser
                                            ?.birthday ??
                                        DateTime.now(),
                                    (state.data as ProfileInfoResModel)
                                            .thisUser
                                            ?.address ??
                                        '',
                                    (state.data as ProfileInfoResModel)
                                            .thisUser!
                                            .workExperienceJson ??
                                        '',
                                    (state.data as ProfileInfoResModel)
                                            .thisUser!
                                            .referancesJson ??
                                        '',
                                    (state.data as ProfileInfoResModel)
                                        .thisUser
                                        ?.mapsJson,
                                    (state.data as ProfileInfoResModel)
                                            .thisUser
                                            ?.lat ??
                                        '0',
                                    (state.data as ProfileInfoResModel)
                                            .thisUser
                                            ?.lon ??
                                        '0',
                                    (state.data as ProfileInfoResModel)
                                            .workInRayza ??
                                        [],
                                    isView: (state.data as ProfileInfoResModel)
                                                .thisUser
                                                ?.type ==
                                            '1'
                                        ? true
                                        : false,
                                  )
                                : (state.data as ProfileInfoResModel)
                                                .userReviews ==
                                            null ||
                                        (state.data as ProfileInfoResModel)
                                            .userReviews!
                                            .isEmpty
                                    ? Center(
                                        child: Image.asset(ImageConst.noRewiew))
                                    : Column(
                                        children: [
                                          SizedBox(height: 15.h),
                                          ratingBar((state.data
                                                      as ProfileInfoResModel)
                                                  .userRates ??
                                              UserRates()),
                                          SizedBox(height: 22.h),
                                          Divider(
                                            color: ColorConst.dviderColor,
                                            height: 1.h,
                                          ),
                                          SizedBox(height: 11.h),
                                          SizedBox(
                                            child: ListView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                padding: EdgeInsets.zero,
                                                itemCount: ((state.data as ProfileInfoResModel)
                                                            .userReviews ??
                                                        [])
                                                    .length,
                                                itemBuilder: ((context, index) => reviewCard(
                                                    (state.data as ProfileInfoResModel)
                                                            .userReviews![index]
                                                            .name ??
                                                        '',
                                                    (state.data as ProfileInfoResModel)
                                                            .userReviews![index]
                                                            .comment ??
                                                        '',
                                                    double.tryParse((state.data as ProfileInfoResModel).userReviews![index].rate ?? '0'),
                                                    (state.data as ProfileInfoResModel).userReviews![index].workType,
                                                    t,
                                                    complaint: (state.data as ProfileInfoResModel).userReviews![index].isNotCome ?? '-1'))),
                                          ),
                                          SizedBox(height: 20.h),
                                        ],
                                      );
                          },
                        )
                      ],
                    ),
                  ),
                ],
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
            return Center(child: Text(t!.translate("wentWrong")));
          }
        },
      ),
    );
  }
}
