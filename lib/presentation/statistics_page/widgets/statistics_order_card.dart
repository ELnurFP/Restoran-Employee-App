// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../constants/color_constant.dart';
import '../../../constants/font_constant.dart';
import '../../../constants/icon_constant.dart';
import '../../../cubit/general_cubit.dart';
import '../../../infrastructure/remote/get_order_service.dart';
import '../../../language/localization.dart';
import '../../../models/general_req_model.dart';
import '../../../models/statistics_res_model.dart';
import '../../ad_view_page/ad_view_page.dart';
import '../../core/shadows.dart';
import '../../main_page/entity/ad_entity.dart';

class StaticticsOrderCard extends StatelessWidget {
  const StaticticsOrderCard({Key? key, required this.t, this.order})
      : super(key: key);

  final Order? order;
  final AppLocalizations t;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              BlocProvider<GeneralCubit<GetOrderService, GetOrderReqModel>>(
            create: (context) =>
                GeneralCubit<GetOrderService, GetOrderReqModel>()
                  ..generalRequest(GetOrderReqModel(id: order!.id)),
            child: AdViewPage(
              adEntity: AdEntity(id: order!.id!),
            ),
          ),
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          boxShadow: Shadows.shadow1,
          color: ColorConst.primary,
          borderRadius: BorderRadius.circular(
            15.r,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ID#${order!.id ?? '-'}",
              style: FontConst.font.w500().px12().copyWith(
                    color: ColorConst.idColor,
                  ),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Icon(
                  Icons.remove_red_eye,
                  color: const Color(0xffFFB340),
                  size: 20.r,
                ),
                SizedBox(width: 12.w),
                SizedBox(
                  width: 250.w,
                  child: Text(
                    t
                        .translate("viewed")
                        .replaceFirst("\$p", order!.views ?? '0'),
                    style: FontConst.font.w400().px12(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: const Color(0xff99DB71),
                  size: 20.r,
                ),
                SizedBox(width: 12.w),
                SizedBox(
                  width: 250.w,
                  child: Text(
                    t
                        .translate("canApply")
                        .replaceFirst("\$p", order!.attendedPeople ?? '0')
                        .replaceFirst("\$t", order!.count ?? '0'),
                    style: FontConst.font.w400().px12(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: const Color(0xff529BF1),
                  size: 20.r,
                ),
                SizedBox(width: 12.w),
                Text(
                  '${t.translate('deadline')}  ${DateFormat("d MMMM, yyyy").format(DateTime.parse(order!.workDate!))}',
                  style: FontConst.font.w400().px12(),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                SizedBox(width: 3.w),
                SvgPicture.asset(
                  IconConst.fund,
                  color: ColorConst.idColor,
                  width: 19.w,
                ),
                SizedBox(width: 9.w),
                Text(
                  order!.orderType != null
                      ? (order!.orderType == '0'
                          ? t.translate("economic")
                          : t.translate("express"))
                      : '',
                  style: FontConst.font.w400().px12(),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(width: 12.w),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffBCF5A1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 13.w, vertical: 5.h),
                  child: Text(
                    "${order!.total} AZN",
                    style: FontConst.font.w500().px10().copyWith(
                          color: ColorConst.idColor,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: ColorConst.seeColors,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  child: Text(
                    t.translate("see"),
                    style: FontConst.font.w400().px12().copyWith(
                          color: ColorConst.dark,
                        ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
