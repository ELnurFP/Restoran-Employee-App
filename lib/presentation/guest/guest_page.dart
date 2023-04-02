import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/configs/base64_conventer.dart';
import 'package:template/cubit/general_cubit.dart';
import 'package:template/cubit/general_state.dart';
import 'package:template/infrastructure/remote/send_banner_click_service.dart';
import 'package:template/models/banner_click_model.dart';
import 'package:template/models/general_req_model.dart';
import '../../../constants/color_constant.dart';
import '../../../constants/font_constant.dart';
import '../../../infrastructure/remote/main_screen_service.dart';
import '../../../models/main_screen_res_model.dart';
import '../../language/localization.dart';
import '../main_page/entity/ad_entity.dart';
import '../main_page/entity/nofication_entity.dart';
import '../main_page/widgets/ad_view.dart';
import '../main_page/widgets/banner.dart';
import '../main_page/widgets/notification_view.dart';
import '../registration/role_choser_page.dart';
import '../widgets/main_buton.dart';
import 'guest_adview.dart';

class GuestPage extends StatefulWidget {
  const GuestPage({Key? key}) : super(key: key);

  @override
  State<GuestPage> createState() => _GuestPageState();
}

class _GuestPageState extends State<GuestPage> {
  final CarouselController caruselCntrl = CarouselController();
  ValueNotifier<bool> isSaved = ValueNotifier(false);
  final PageController pageController =
      PageController(initialPage: 0, viewportFraction: 1);

  final _key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  Widget jobList(
      BuildContext context, String title, List<Map<String, dynamic>>? data) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                '  $title',
                style: FontConst.font.w600().px18().c(
                      ColorConst.almostBlack,
                    ),
              ),
              SizedBox(
                height: 12.h,
              ),
            ] +
            data!
                .map<Widget>((e) => Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (context) => GuestAdViewPage(
                                          adEntity: AdEntity.fromJson(e),
                                        )))
                                .then((value) {
                              context
                                  .read<
                                      GeneralCubit<MainGuestScreenService,
                                          GetGuestReqModel>>()
                                  .generalRequest(GetGuestReqModel());
                            });
                          },
                          child: AdView(
                            adEntity: AdEntity.fromJson(e),
                          )),
                    ))
                .toList(),
      ),
    );
  }

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
          height: 160.h,
          autoPlay: true,
          viewportFraction: 0.95,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  Widget notificationView(Mainscreen? data) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations? t = AppLocalizations.of(context);
    context
        .read<GeneralCubit<MainGuestScreenService, GetGuestReqModel>>()
        .generalRequest(GetGuestReqModel());
    return Scaffold(
      key: _key,
      body: BlocBuilder<GeneralCubit<MainGuestScreenService, GetGuestReqModel>,
          GeneralState>(builder: (context, state) {
        if (state is GeneralSuccess) {
          return Column(
            children: [
              SizedBox(
                height: 65.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: registerButton(
                  context,
                  () => {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const RoleChooserPage()),
                        (route) => false)
                  },
                  t!.translate("register"),
                ),
              ),
              Container(
                //    margin: EdgeInsets.symmetric(horizontal: 16.w),
                padding: EdgeInsets.zero,
                height: 700.h,
                child: ListView.builder(
                    itemCount:
                        (state.data as MainScreenResModel).mainscreen!.length,
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
                      } else if ((state.data as MainScreenResModel)
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
                      } else if ((state.data as MainScreenResModel)
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
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
