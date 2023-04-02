import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/constants/image_constant.dart';
import 'package:template/language/localization.dart';
import 'package:template/models/get_all_orders_res_model.dart';

import '../../../../../cubit/general_cubit.dart';
import '../../../../../infrastructure/remote/get_order_service.dart';
import '../../../../../models/general_req_model.dart';
import '../../../../ad_view_page/ad_view_page.dart';
import '../../../entity/ad_entity.dart';
import '../../../widgets/ad_view.dart';

SizedBox adsCard(List<GetAllOrdersResModel> activeList, AppLocalizations t) {
  return SizedBox(
    height: 600.h,
    child: activeList.isEmpty
        ? Center(child: Image.asset(ImageConst.noRewiew))
        : ListView.separated(
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => SizedBox(height: 10.h),
            itemCount: activeList.isNotEmpty ? activeList.length : 0,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => BlocProvider<
                              GeneralCubit<GetOrderService, GetOrderReqModel>>(
                          create: (context) =>
                              GeneralCubit<GetOrderService, GetOrderReqModel>()
                                ..generalRequest(GetOrderReqModel(
                                    id: activeList[index].id!)),
                          child: AdViewPage(
                            adEntity: AdEntity(
                              id: activeList[index].id!,
                              gender: activeList[index].gender ?? "2",
                              address: activeList[index].address ?? "empty",
                              attendees:
                                  activeList[index].attended_people ?? "0",
                              count: activeList[index].count ?? "0",
                              description: activeList[index].description ?? "0",
                              isPermanent:
                                  activeList[index].is_perminent ?? "1",
                              isVip: activeList[index].isVip ?? 'null',
                              ownerType:
                                  activeList[index].owner_type_name ?? "0",
                              views: activeList[index].views ?? "0",
                              workDate: activeList[index].work_date ?? "0",
                              workerType:
                                  activeList[index].worker_type_name ?? "0",
                              workHours: activeList[index].work_hours ?? "0",
                              status: activeList[index].status ?? "-1",
                            ),
                          )))));
                },
                child: AdView(
                  adEntity: AdEntity(
                    id: activeList[index].id!,
                    gender: activeList[index].gender ?? "2",
                    address: activeList[index].address ?? "empty",
                    attendees: activeList[index].attended_people ?? "0",
                    count: activeList[index].count ?? "0",
                    description: activeList[index].description ?? "0",
                    isPermanent: activeList[index].is_perminent ?? "1",
                    isVip: activeList[index].isVip ?? 'null',
                    ownerType: activeList[index].owner_type_name ?? "0",
                    views: activeList[index].views ?? "0",
                    workDate: activeList[index].work_date ?? "0",
                    workerType: activeList[index].worker_type_name ?? "0",
                    workHours: activeList[index].work_hours ?? "0",
                    status: activeList[index].status ?? "-1",
                  ),
                ),
              );
            },
          ),
  );
}
