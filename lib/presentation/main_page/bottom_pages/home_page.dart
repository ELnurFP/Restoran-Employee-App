import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:template/configs/base64_conventer.dart';
import 'package:template/cubit/general_cubit.dart';
import 'package:template/cubit/general_state.dart';
import 'package:template/infrastructure/remote/profile_info_service.dart';
import 'package:template/infrastructure/remote/send_banner_click_service.dart';
import 'package:template/models/banner_click_model.dart';
import 'package:template/models/general_req_model.dart';
import 'package:template/presentation/main_page/widgets/statistics_view.dart';
import 'package:template/presentation/statistics_page/statistics_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constants/color_constant.dart';
import '../../../constants/font_constant.dart';
import '../../../constants/image_constant.dart';
import '../../../dependency_injection.dart';
import '../../../infrastructure/remote/get_order_service.dart';
import '../../../infrastructure/remote/main_screen_service.dart';
import '../../../infrastructure/remote/profile_update_image_service.dart';
import '../../../infrastructure/remote/profile_update_service.dart';
import '../../../infrastructure/remote/statistics_service.dart';
import '../../../language/localization.dart';
import '../../../models/main_screen_res_model.dart';
import '../../../models/profile_info_res_model.dart';
import '../../../models/profile_update_image_req_model.dart';
import '../../../models/profile_update_req_model.dart';
import '../../account_page/account_page.dart';
import '../../account_page/tabs/my_profile/my_profile.dart';
import '../../ad_view_page/ad_view_page.dart';
import '../entity/ad_entity.dart';
import '../entity/nofication_entity.dart';
import '../entity/statistics_entity.dart';
import '../widgets/ad_view.dart';
import '../widgets/banner.dart';
import '../widgets/notification_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselController caruselCntrl = CarouselController();
  ValueNotifier<bool> isSaved = ValueNotifier(false);
  GlobalKey<State<StatefulWidget>> key = GlobalKey();
  final PageController pageController =
      PageController(initialPage: 0, viewportFraction: 1);

  @override
  void initState() {
    // locator.get<GetStorage>().read('role') == 'Roles.Worker'
    //     ? WidgetsBinding.instance.addPostFrameCallback((_) async {
    //         await showDialog<String>(
    //           context: context,
    //           builder: (BuildContext context) => SimpleDialog(
    //             backgroundColor: Colors.transparent,
    //             children: <Widget>[popUpAdDialog(context)],
    //           ),
    //         );
    //       })
    //     : null;
    super.initState();
  }

  Widget statistisLis(
      BuildContext context, String? title, List<Map<String, dynamic>> data) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Text(
            title ?? '',
            style: FontConst.font.w600().px18().c(
                  ColorConst.almostBlack,
                ),
          ),
          SizedBox(
            height: 12.h,
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return BlocProvider<
                        GeneralCubit<StatisticsService, GeneralInfoReqModel>>(
                    create: (context) =>
                        GeneralCubit<StatisticsService, GeneralInfoReqModel>()
                          ..generalRequest(GeneralInfoReqModel()),
                    child: const StatisticsPage());
              }),
            ).then((value) {
              context
                  .read<GeneralCubit<MainScreenService, GeneralInfoReqModel>>()
                  .generalRequest(GeneralInfoReqModel());
            }),
            child: StatisticsView(
              statisticsEntity: StatisticsEntity(
                adCount: data.first['ad_count'] ?? '0',
                employeeCount: data.first['emp_count'] ?? '0',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget jobList(
      BuildContext context, String title, List<Map<String, dynamic>>? data) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Text(
            title,
            style: FontConst.font.w600().px18().c(
                  ColorConst.almostBlack,
                ),
          ),
          SizedBox(
            height: 12.h,
          ),
          ...data!.map<Widget>(
            (e) => Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return BlocProvider<
                              GeneralCubit<GetOrderService, GetOrderReqModel>>(
                          create: (context) =>
                              GeneralCubit<GetOrderService, GetOrderReqModel>()
                                ..generalRequest(GetOrderReqModel(id: e['id'])),
                          child: AdViewPage(
                            adEntity: AdEntity.fromJson(e),
                            orderType: locator.get<GetStorage>().read('role') ==
                                    'Roles.Owner'
                                ? e['order_type']
                                : '',
                            total: locator.get<GetStorage>().read('role') ==
                                    'Roles.Owner'
                                ? e['total']
                                : '',
                          ));
                    }),
                  ).then((value) {
                    context
                        .read<
                            GeneralCubit<MainScreenService,
                                GeneralInfoReqModel>>()
                        .generalRequest(GeneralInfoReqModel());
                  });
                },
                child: AdView(
                  adEntity: AdEntity.fromJson(e),
                  saved: e['saved'] ?? false,
                  orderType:
                      locator.get<GetStorage>().read('role') == 'Roles.Owner'
                          ? e['order_type']
                          : '',
                  total: locator.get<GetStorage>().read('role') == 'Roles.Owner'
                      ? e['total']
                      : '',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Widget bannerList(List<Map<String, dynamic>>? data) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: <Widget>[
  //           SizedBox(
  //             height: 20.h,
  //           ),
  //         ] +
  //         data!
  //             .map<Widget>((e) => BlocProvider<
  //                     GeneralCubit<SendBannerClickService,
  //                         BannerClickReqModel>>(
  //                   create: (context) => GeneralCubit<SendBannerClickService,
  //                       BannerClickReqModel>(),
  //                   child: BannerView(
  //                       id: e['id'].toString(),
  //                       imageUrl: e['img'],
  //                       link: e['link'].toString().fromBase64),
  //                 ))
  //             .toList(),
  //   );
  // }

  Widget bannerList(
      List<Map<String, dynamic>>? data, CarouselController caruselCntrl) {
    return SizedBox(
      height: 180.h,
      child: CarouselSlider.builder(
        carouselController: caruselCntrl,
        itemCount: data!.length,
        itemBuilder: ((context, index, realIndex) => BlocProvider<
                GeneralCubit<SendBannerClickService, BannerClickReqModel>>(
            create: (context) =>
                GeneralCubit<SendBannerClickService, BannerClickReqModel>(),
            child: BannerView(
                id: data[index]['id'].toString(),
                imageUrl: data[index]['img'],
                link: data[index]['link'].toString().fromBase64))),
        options: CarouselOptions(
          viewportFraction: 0.95,
          height: 160.h,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
      ),

      // child: PageView.builder(

      //   controller: pageController,
      //   itemCount: data!.length,
      //   itemBuilder: (context, index) {
      //     return BlocProvider<
      //             GeneralCubit<SendBannerClickService, BannerClickReqModel>>(
      //         create: (context) =>
      //             GeneralCubit<SendBannerClickService, BannerClickReqModel>(),
      //         child: BannerView(
      //             id: data[index]['id'].toString(),
      //             imageUrl: data[index]['img'],
      //             link: data[index]['link'].toString().fromBase64));
      //   },
      // ),
    );
  }

  Widget notificationView(Mainscreen? data) {
    return GestureDetector(
      onTap: () async {
        await launchUrl(Uri.parse(data.link!));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.h,
            ),
            NotificationView(
              entity: NotificationEntity(
                  name: data!.title!,
                  id: "1",
                  userId: "0",
                  img: data.icon!,
                  createdAt: "2021-11-03 20:10:10",
                  orderId: "1",
                  personId: "1"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<GeneralCubit<MainScreenService, GeneralInfoReqModel>>()
        .generalRequest(GeneralInfoReqModel());
    return Scaffold(
      key: key,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Center(
          child: Image.asset(
            ImageConst.logo,
            height: 32.h,
            width: 32.h,
          ),
        ),
        actions: [
          SizedBox(
            width: 14.w,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BlocProvider<
                          GeneralCubit<ProfileInfoService,
                              GeneralInfoReqModel>>(
                        create: (context) => GeneralCubit<ProfileInfoService,
                            GeneralInfoReqModel>()
                          ..generalRequest(GeneralInfoReqModel()),
                        child: AccountPage(),
                      )));
            },
            child: Container(
              width: 38.h,
              height: 38.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: locator.get<GetStorage>().read('lang') == 'az'
                    ? const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          ImageConst.az2,
                        ),
                      )
                    : locator.get<GetStorage>().read('lang') == 'en'
                        ? const DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              ImageConst.en,
                            ),
                          )
                        : locator.get<GetStorage>().read('lang') == 'ru'
                            ? const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  ImageConst.ru,
                                ),
                              )
                            : const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  ImageConst.az2,
                                ),
                              ),
              ),
            ),
          ),
          SizedBox(
            width: 16.w,
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context
              .read<GeneralCubit<MainScreenService, GeneralInfoReqModel>>()
              .generalRequest(GeneralInfoReqModel());
        },
        child: BlocConsumer<
            GeneralCubit<MainScreenService, GeneralInfoReqModel>,
            GeneralState>(listener: (context, state) {
          if (state is GeneralSuccess) {
            //String? index = locator.get<GetStorage>().read('index');

            if ((state.data as MainScreenResModel).isProfileCompleted != '1') {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider<
                            GeneralCubit<ProfileUpdateService,
                                ProfileUpdateReqModel>>(
                        create: (context) => GeneralCubit<ProfileUpdateService,
                            ProfileUpdateReqModel>()),
                    BlocProvider<
                            GeneralCubit<ProfileUpdateImageService,
                                ProfileUpdateImageReqModel>>(
                        create: (context) => GeneralCubit<
                            ProfileUpdateImageService,
                            ProfileUpdateImageReqModel>()),
                  ],
                  child: BlocProvider<
                      GeneralCubit<ProfileInfoService, GeneralInfoReqModel>>(
                    create: (context) =>
                        GeneralCubit<ProfileInfoService, GeneralInfoReqModel>()
                          ..generalRequest(GeneralInfoReqModel()),
                    child: BlocConsumer<
                        GeneralCubit<ProfileInfoService, GeneralInfoReqModel>,
                        GeneralState>(listener: (context, state) {
                      if (state is GeneralFail) {
                        AppLocalizations? t = AppLocalizations.of(context);
                        SizedBox(
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
                      }
                    }, builder: (context, state) {
                      if (state is GeneralSuccess) {
                        return MyProfilePage(
                          profileInfoResModel:
                              (state.data as ProfileInfoResModel),
                          fromMain: true,
                        );
                      } else {
                        return const Scaffold(
                          body: Center(
                            child: CircularProgressIndicator(
                              backgroundColor: ColorConst.ekonomColor,
                            ),
                          ),
                        );
                      }
                    }),
                  ),
                );
              }), (route) => false);
            }
          }
        }, builder: (context, state) {
          if (state is GeneralSuccess) {
            //   print((state.data as MainScreenResModel).mainscreen![0]);
            return SizedBox(
              // margin: EdgeInsets.symmetric(horizontal: 16.w),
              height: 812.h,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      // margin: EdgeInsets.symmetric(horizontal: 16.w),
                      //height: 812.h,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: (state.data as MainScreenResModel)
                              .mainscreen!
                              .length,
                          itemBuilder: (context, index) {
                            if ((state.data as MainScreenResModel)
                                    .mainscreen![index]
                                    .type ==
                                'banner') {
                              return bannerList(
                                  (state.data as MainScreenResModel)
                                      .mainscreen![index]
                                      .payload,
                                  caruselCntrl);
                            }
                            if ((state.data as MainScreenResModel)
                                    .mainscreen![index]
                                    .type ==
                                'statistics') {
                              return statistisLis(
                                  context,
                                  (state.data as MainScreenResModel)
                                      .mainscreen![index]
                                      .title,
                                  (state.data as MainScreenResModel)
                                      .mainscreen![index]
                                      .payload!);
                            }
                            if ((state.data as MainScreenResModel)
                                    .mainscreen![index]
                                    .type ==
                                'orders') {
                              return jobList(
                                  context,
                                  (state.data as MainScreenResModel)
                                      .mainscreen![index]
                                      .title!,
                                  (state.data as MainScreenResModel)
                                      .mainscreen![index]
                                      .payload);
                            }
                            if ((state.data as MainScreenResModel)
                                    .mainscreen![index]
                                    .type ==
                                'info') {
                              return notificationView(
                                  (state.data as MainScreenResModel)
                                      .mainscreen![index]);
                            }
                            return const SizedBox();
                          }),
                    ),
                    SizedBox(
                      height: 40.h,
                    )
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}
