import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/configs/base64_conventer.dart';
import 'package:template/constants/constants.dart';
import 'package:template/cubit/general_state.dart';
import 'package:template/infrastructure/remote/notifications_service.dart';
import 'package:template/language/localization.dart';
import 'package:template/models/general_req_model.dart';
import 'package:template/presentation/main_page/entity/ad_entity.dart';
import 'package:template/presentation/widgets/custom_appbar.dart';
import '../../../cubit/general_cubit.dart';
import '../../../infrastructure/remote/get_order_service.dart';
import '../../../infrastructure/remote/profile_info_service.dart';
import '../../../models/notifications_res_model.dart';
import '../../ad_view_page/ad_view_page.dart';
import 'Profile Page/profile_view_page.dart';

class AlertPage extends StatelessWidget {
  const AlertPage({Key? key}) : super(key: key);

  BlocProvider notificationCard(BuildContext c, String? image, String message,
      String? orderID, String? personID) {
    return BlocProvider(
      create: (context) =>
          GeneralCubit<ProfileViewService, GeneralInfoReqModel>(),
      child: InkWell(
        onTap: () {
          if (personID != "0" && orderID == "0") {
            Navigator.of(c).push(
              MaterialPageRoute(
                builder: (context) => BlocProvider<
                    GeneralCubit<ProfileViewService, GeneralInfoReqModel>>(
                  create: (context) =>
                      GeneralCubit<ProfileViewService, GeneralInfoReqModel>()
                        ..generalRequest(GeneralInfoReqModel(userId: personID)),
                  child: const ProfileViewPage(),
                ),
              ),
            );
          } else if (orderID != "0" && personID == "0") {
            Navigator.of(c).push(MaterialPageRoute(
                builder: (context) => BlocProvider<
                        GeneralCubit<GetOrderService, GetOrderReqModel>>(
                    create: (context) =>
                        GeneralCubit<GetOrderService, GetOrderReqModel>()
                          ..generalRequest(GetOrderReqModel(id: orderID)),
                    child: AdViewPage(
                      adEntity: AdEntity(id: orderID!),
                    ))));
          } else {}
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 27.5.w),
          child: Column(
            children: [
              Row(
                children: [
                  image != null
                      ? CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 19.r,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(19.r),
                            child: Image.network('https://rayza.az/$image',
                                width: 38.w,
                                height: 38.h,
                                fit: BoxFit.cover, frameBuilder: (context,
                                    child, frame, wasSynchronouslyLoaded) {
                              if (wasSynchronouslyLoaded) {
                                return child;
                              }
                              return AnimatedOpacity(
                                opacity: frame == null ? 0 : 1,
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeOut,
                                child: child,
                              );
                            }, errorBuilder: (context, error, stackTrace) {
                              return CircleAvatar(
                                backgroundColor: const Color(0xff93D6F4),
                                radius: 19,
                                child: Center(
                                    child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 19.r,
                                        foregroundImage: const AssetImage(
                                          ImageConst.notf,
                                        ))),
                              );
                            }),
                          ),
                          // foregroundImage: NetworkImage(
                          // ,
                          //      ),
                        )
                      : orderID != '0' && personID == '0'
                          ? CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 19.r,
                              foregroundImage: const AssetImage(
                                ImageConst.notf,
                              ))
                          : CircleAvatar(
                              backgroundColor: const Color(0xff93D6F4),
                              radius: 19.r,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 5.h),
                                    Text(
                                      'i',
                                      style: FontConst.font
                                          .w400()
                                          .px22()
                                          .copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                              )),
                  const Spacer(),
                  SizedBox(
                    width: 260.w,
                    child: Text(
                      message,
                      style: FontConst.font.w400().px14().copyWith(
                            color: const Color(0xff000000),
                            letterSpacing: 0.5,
                            height: 1.5,
                          ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                ],
              ),
              SizedBox(height: 15.h),
              Divider(
                color: const Color(0xffD7D7D7),
                thickness: 1.h,
                height: 0,
              ),
              SizedBox(height: 15.h),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations? t = AppLocalizations.of(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context
              .read<GeneralCubit<NotificationsService, GeneralInfoReqModel>>()
              .generalRequest(GeneralInfoReqModel());
        },
        child: SingleChildScrollView(
          child: BlocBuilder<
              GeneralCubit<NotificationsService, GeneralInfoReqModel>,
              GeneralState>(
            builder: (context, state) {
              if (state is GeneralFail) {
                return SizedBox(
                  height: 812.h,
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
              } else if (state is GeneralSuccess) {
                return Column(
                  children: [
                    customAppBar(context, t!.translate("notifications"),
                        isback: false),
                    SizedBox(height: 23.h),
                    SizedBox(
                      height: 812.h,
                      child: (state.data as AllNotifications).all!.isEmpty
                          ? Column(
                              children: [
                                SizedBox(height: 100.h),
                                Image.asset(ImageConst.noRewiew),
                              ],
                            )
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount:
                                  (state.data as AllNotifications).all!.length,
                              itemBuilder: (context, index) => notificationCard(
                                    context,
                                    (state.data as AllNotifications)
                                        .all![index]
                                        .img,
                                    (state.data as AllNotifications)
                                        .all![index]
                                        .name!
                                        .fromBase64,
                                    (state.data as AllNotifications)
                                        .all![index]
                                        .order_id,
                                    (state.data as AllNotifications)
                                        .all![index]
                                        .person_id,
                                  )),
                    ),
                  ],
                );
              } else {
                return SizedBox(
                    height: 812.h,
                    width: 375.w,
                    child: const Center(child: CircularProgressIndicator()));
              }
            },
          ),
        ),
      ),
    );
  }
}
