// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:template/constants/constants.dart';

import '../../core/shadows.dart';
import '../entity/nofication_entity.dart';

class NotificationView extends StatelessWidget {
  final NotificationEntity entity;

  const NotificationView({
    Key? key,
    required this.entity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        10.h,
      ),
      decoration: BoxDecoration(
        color: ColorConst.primary,
        boxShadow: Shadows.shadow1,
        borderRadius: BorderRadius.circular(
          15.r,
        ),
        border: Border.all(
          color: const Color(0xFFE549FF),
          width: 0.5.w,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //
          Container(
            height: 38.h,
            width: 38.h,
            decoration: BoxDecoration(
                color: const Color(0xFFE549FF),
                image: entity.img.isNotEmpty
                    ? DecorationImage(
                        image: CachedNetworkImageProvider(entity.img))
                    : null,
                shape: BoxShape.circle),
            child: entity.img.isEmpty
                ? Center(
                    child: SvgPicture.asset(
                      IconConst.like,
                      height: 19.h,
                      width: 19.h,
                      fit: BoxFit.cover,
                      color: ColorConst.primary,
                    ),
                  )
                : null,
          ),
          SizedBox(
            width: 10.h,
          ),
          Expanded(
            child: Text(
              entity.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: FontConst.font.w400().px14().c(
                    ColorConst.almostBlack,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
