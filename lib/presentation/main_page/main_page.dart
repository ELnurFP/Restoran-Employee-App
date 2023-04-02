// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:template/constants/constants.dart';
import 'package:template/dependency_injection.dart';

import '../../cubit/general_cubit.dart';
import '../../cubit/general_state.dart';
import '../../infrastructure/remote/create_order_service.dart';
import '../../infrastructure/remote/get_all_orders_service.dart';
import '../../infrastructure/remote/get_user_status_types_service.dart';
import '../../infrastructure/remote/main_screen_service.dart';
import '../../infrastructure/remote/notifications_service.dart';
import '../../infrastructure/remote/profile_info_service.dart';
import '../../models/create_order_req_model.dart';
import '../../models/general_req_model.dart';
import '../../models/get_user_status_req_model.dart';
import '../../models/notifications_res_model.dart';
import 'bottom_pages/Announce Page/announce_page.dart';
import 'bottom_pages/Profile Page/profile_page.dart';
import 'bottom_pages/alert_page.dart';
import 'bottom_pages/home_page.dart';
import 'create_advertisement/create_advertisement.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int initIndex = 0;
  List<Widget> pages = [
    BlocProvider<GeneralCubit<MainScreenService, GeneralInfoReqModel>>(
        create: (context) =>
            GeneralCubit<MainScreenService, GeneralInfoReqModel>()
              ..generalRequest(GeneralInfoReqModel()),
        child: const HomePage()),
    BlocProvider(
        create: (context) =>
            GeneralCubit<GetAllOrdersService, GeneralInfoReqModel>()
              ..generalRequest(GeneralInfoReqModel()),
        child: const AnnouncePage()),
    BlocProvider(
        create: (context) =>
            GeneralCubit<NotificationsService, GeneralInfoReqModel>()
              ..generalRequest(GeneralInfoReqModel()),
        child: const AlertPage()),
    BlocProvider(
        create: (context) =>
            GeneralCubit<ProfileInfoService, GeneralInfoReqModel>()
              ..generalRequest(GeneralInfoReqModel()),
        child: const ProfilePage())
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        backgroundColor: ColorConst.primary,
        extendBodyBehindAppBar: true,
        floatingActionButton: locator.get<GetStorage>().read('role') ==
                'Roles.Owner'
            ? FloatingActionButton(
                heroTag: "btn1",
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(providers: [
                                BlocProvider<
                                    GeneralCubit<CreateOrderService,
                                        CreateOrderReqModel>>(
                                  create: (context) => GeneralCubit<
                                      CreateOrderService,
                                      CreateOrderReqModel>(),
                                ),
                                BlocProvider<
                                    GeneralCubit<GetUsesStatusTypeService,
                                        GetUserStatusTypeReqModel>>(
                                  create: (context) => GeneralCubit<
                                      GetUsesStatusTypeService,
                                      GetUserStatusTypeReqModel>()
                                    ..generalRequest(
                                        GetUserStatusTypeReqModel(type: '1')),
                                )
                              ], child: const CreateAdvertisement())))
                      .then((value) {
                    setState(() {});
                  });
                },
                child: SvgPicture.asset(
                  IconConst.add,
                  height: 80.h,

                  // color: ColorConst.secondary,
                ),
              )
            : null,
        body: pages[initIndex],
        bottomNavigationBar: BlocProvider(
            create: (context) =>
                GeneralCubit<NotificationsService, GeneralInfoReqModel>()
                  ..generalRequest(GeneralInfoReqModel()),
            child: BlocBuilder<
                GeneralCubit<NotificationsService, GeneralInfoReqModel>,
                GeneralState>(
              builder: (context, state) {
                if (state is GeneralLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GeneralSuccess) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: BottomNavigationBar(
                        backgroundColor: ColorConst.secondaryDark,
                        currentIndex: initIndex,
                        showSelectedLabels: false,
                        showUnselectedLabels: false,
                        type: BottomNavigationBarType.fixed,
                        onTap: (index) {
                          // here we switch between tabs
                          setState(() {
                            initIndex = index;
                          });
                        },
                        items: [
                          BottomNavigationBarItem(
                            // backgroundColor: ColorConst.secondaryDark,
                            icon: SvgPicture.asset(
                              IconConst.home,
                              height: 24.h,
                              color: initIndex == 0
                                  ? ColorConst.primary
                                  : ColorConst.BCBABA,
                            ),
                            label: "",
                          ),
                          BottomNavigationBarItem(
                            backgroundColor: ColorConst.secondaryDark,
                            icon: Padding(
                              padding: EdgeInsets.only(
                                  right:
                                      locator.get<GetStorage>().read('role') ==
                                              'Roles.Owner'
                                          ? 25.w
                                          : 0.w),
                              child: SvgPicture.asset(
                                IconConst.announce,
                                height: 24.h,
                                color: initIndex == 1
                                    ? ColorConst.primary
                                    : ColorConst.BCBABA,
                              ),
                            ),
                            label: "",
                          ),
                          BottomNavigationBarItem(
                            backgroundColor: ColorConst.secondaryDark,
                            icon: SizedBox(
                              height: 24.h,
                              //s width: 24.w,
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: locator
                                                    .get<GetStorage>()
                                                    .read('role') ==
                                                'Roles.Owner'
                                            ? 25.w
                                            : 0),
                                    child: SvgPicture.asset(
                                      IconConst.alert,
                                      height: 24.h,
                                      color: initIndex == 2
                                          ? ColorConst.primary
                                          : ColorConst.BCBABA,
                                    ),
                                  ),
                                  (state.data as AllNotifications).all!.isEmpty
                                      ? const SizedBox()
                                      : Positioned(
                                          top: -3.h,
                                          right: 0,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: ColorConst.orangeStatus),
                                            padding: EdgeInsets.all(3.5.r),
                                            child: Center(
                                              child: Text(
                                                (state.data as AllNotifications)
                                                    .all!
                                                    .length
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 10.sp,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ))
                                ],
                              ),
                            ),
                            label: "",
                          ),
                          BottomNavigationBarItem(
                            backgroundColor: ColorConst.secondaryDark,
                            icon: SvgPicture.asset(
                              IconConst.worker,
                              height: 24.h,
                              color: initIndex == 3
                                  ? ColorConst.primary
                                  : ColorConst.BCBABA,
                            ),
                            label: "",
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )),
      ),
    );
  }
}
