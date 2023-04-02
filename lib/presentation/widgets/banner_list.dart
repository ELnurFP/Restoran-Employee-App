import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/configs/base64_conventer.dart';

import '../../cubit/general_cubit.dart';
import '../../infrastructure/remote/send_banner_click_service.dart';
import '../../models/banner_click_model.dart';
import '../main_page/widgets/banner.dart';

class BannerList extends StatelessWidget {
  const BannerList({super.key, this.data});
  final List<Map<String, dynamic>>? data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 180.h,
        width: 375.w,
        child: CarouselSlider.builder(
          itemCount: data!.length,
          itemBuilder: ((context, index, realIndex) => BlocProvider<
                  GeneralCubit<SendBannerClickService, BannerClickReqModel>>(
              create: (context) =>
                  GeneralCubit<SendBannerClickService, BannerClickReqModel>(),
              child: BannerView(
                  id: data![index]['id'].toString(),
                  imageUrl: data![index]['img'],
                  link: data![index]['link'].toString().fromBase64))),
          options: CarouselOptions(
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
      ),
    );
  }
}
