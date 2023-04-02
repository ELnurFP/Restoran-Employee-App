import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:template/configs/base64_conventer.dart';
import 'package:template/constants/constants.dart';
import 'package:template/cubit/general_cubit.dart';
import 'package:template/cubit/general_state.dart';
import 'package:template/dependency_injection.dart';
import 'package:template/infrastructure/remote/profile_info_service.dart';
import 'package:template/models/general_req_model.dart';
import 'package:template/models/profile_info_res_model.dart';
import '../../../../language/localization.dart';
import 'methods/about_tab.dart';
import 'methods/profile_image.dart';
import 'methods/rating_bar.dart';
import 'methods/user_info.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ValueNotifier<int> _valueNotifier = ValueNotifier(0);

  @override
  void initState() {
    _valueNotifier.value = 0;
    super.initState();
  }

  final isWorker = locator.get<GetStorage>().read('role') == 'Roles.Worker';
  @override
  Widget build(BuildContext context) {
    AppLocalizations? t = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          context
              .read<GeneralCubit<ProfileInfoService, GeneralInfoReqModel>>()
              .generalRequest(GeneralInfoReqModel());
        },
        child: BlocBuilder<
            GeneralCubit<ProfileInfoService, GeneralInfoReqModel>,
            GeneralState>(
          builder: (context, state) {
            if (state is GeneralLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GeneralSuccess) {
              locator.get<GetStorage>().write(
                  'map',
                  (state.data as ProfileInfoResModel)
                      .thisUser
                      ?.mapsJson!
                      .fromBase64);

              return SizedBox(
                //size
                height: 750.h,
                width: 375.w,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        child: profilImage(
                            context,
                            t!,
                            double.tryParse(((state.data as ProfileInfoResModel)
                                    .userRates
                                    ?.respects) ??
                                '0'),
                            (state.data as ProfileInfoResModel).thisUser?.img ??
                                '',
                            (state.data as ProfileInfoResModel)
                                    .thisUser
                                    ?.backImg ??
                                '',
                            null,
                            (state.data as ProfileInfoResModel)),
                      ), //217.h
                      userInfo(
                        "${((state.data as ProfileInfoResModel).thisUser?.personName ?? '').fromBase64} ${(((state.data as ProfileInfoResModel).thisUser?.personSurname) ?? '').fromBase64} ",
                        ((state.data as ProfileInfoResModel)
                                .thisUser
                                ?.userTypeStatus
                                .toString()) ??
                            '',
                        //here 1
                        (state.data as ProfileInfoResModel).userStatues ?? [],
                        (state.data as ProfileInfoResModel).userRates?.rate !=
                                null
                            ? double.parse(((state.data as ProfileInfoResModel)
                                    .userRates
                                    ?.rate)!)
                                .roundToDouble()
                            : 0,

                        (state.data as ProfileInfoResModel).userRates?.notGo,
                        t,
                      ), //80.h
                      SizedBox(height: 10.h),
                      DefaultTabController(
                        length: isWorker ? 2 : 1,
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
                                    t.translate('about'),
                                    style: FontConst.font
                                        .w500()
                                        .px16()
                                        .copyWith(
                                            color: const Color(0xff737373)),
                                  ),
                                ),
                                if (isWorker)
                                  Tab(
                                    child: Text(
                                      t.translate('review'),
                                      style: FontConst.font
                                          .w500()
                                          .px14()
                                          .copyWith(
                                              color: const Color(0xff737373)),
                                    ),
                                  ),
                              ],
                            ),
                            ValueListenableBuilder<int>(
                              valueListenable: _valueNotifier,
                              builder: (context, value, child) {
                                return _valueNotifier.value == 0
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
                                            .thisUser
                                            ?.workExperienceJson,
                                        (state
                                                .data as ProfileInfoResModel)
                                            .thisUser
                                            ?.referancesJson,
                                        (state.data as ProfileInfoResModel)
                                            .thisUser
                                            ?.mapsJson,
                                        (state.data as ProfileInfoResModel)
                                                .thisUser!
                                                .lat ??
                                            '0',
                                        (state.data as ProfileInfoResModel)
                                                .thisUser!
                                                .lon ??
                                            '0',
                                        (state.data as ProfileInfoResModel)
                                                .workInRayza ??
                                            [])
                                    //here 2
                                    : Column(
                                        children: [
                                          SizedBox(height: 15.h),
                                          ratingBar((state.data
                                                  as ProfileInfoResModel)
                                              .userRates!),
                                          SizedBox(height: 22.h),
                                        ],
                                      );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
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
      ),
    );
  }
}
