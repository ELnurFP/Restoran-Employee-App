import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../cubit/general_cubit.dart';
import '../../../infrastructure/remote/send_banner_click_service.dart';
import '../../../models/banner_click_model.dart';

class BannerView extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String link;

  const BannerView(
      {Key? key, required this.id, required this.imageUrl, required this.link})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async{
        launchUrl(Uri.parse(link));

        await context
            .read<GeneralCubit<SendBannerClickService, BannerClickReqModel>>()
            .generalRequest(BannerClickReqModel(id: id));
      },
      child: Container(
        height: 130.h,
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                // imageUrl!=null?
                "https://rayza.az/$imageUrl"
                //   :
                //   "https://img.freepik.com/free-photo/abstract-futuristic-background-with-3d-design_1361-3532.jpg?size=626&ext=jpg",
                //
                ),
          ),
          borderRadius: BorderRadius.circular(
            18.r,
          ),
        ),
      ),
    );
  }
}
