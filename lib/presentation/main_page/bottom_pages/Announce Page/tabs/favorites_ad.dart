import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/language/localization.dart';

import '../../../../../constants/constants.dart';
import '../../../../../cubit/general_cubit.dart';
import '../../../../../cubit/general_state.dart';
import '../../../../../infrastructure/remote/get_order_service.dart';
import '../../../../../infrastructure/remote/get_saved_orders_service.dart';
import '../../../../../models/general_req_model.dart';
import '../../../../../models/get_saved_orders_res_model.dart';
import '../../../../ad_view_page/ad_view_page.dart';

import '../../../entity/ad_entity.dart';
import '../../../widgets/ad_view.dart';

class FavoritesAds extends StatelessWidget {
  const FavoritesAds({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations? t = AppLocalizations.of(context);
    return BlocProvider(
        create: (context) =>
            GeneralCubit<GetSavedOrdersService, GeneralInfoReqModel>()
              ..generalRequest(GeneralInfoReqModel()),
        child: Scaffold(
          appBar: AppBar(
            title: Text(t!.translate("favorite")),
          ),
          body: SizedBox(
            //height: 600.h,
            child: BlocBuilder<
                GeneralCubit<GetSavedOrdersService, GeneralInfoReqModel>,
                GeneralState>(
              builder: (context, state) {
                if (state is GeneralLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GeneralSuccess) {
                  List<GetSavedOrdersResModel> data =
                      (state.data as AllSavedList).all!;
                  return data.isEmpty
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(ImageConst.noRewiew),
                            Text(t.translate("noFavFound")),
                          ],
                        ))
                      : ListView.separated(
                          padding: EdgeInsets.zero,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10.h),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                // print('${activeList[index].description.fromBase64}');
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => BlocProvider<
                                                GeneralCubit<GetOrderService,
                                                    GetOrderReqModel>>(
                                            create: (context) => GeneralCubit<
                                                GetOrderService,
                                                GetOrderReqModel>()
                                              ..generalRequest(GetOrderReqModel(
                                                  id: data[index].id!)),
                                            child: AdViewPage(
                                              adEntity: AdEntity(
                                                id: data[index].id ?? "1121212",
                                                gender:
                                                    data[index].gender ?? "2",
                                                address:
                                                    data[index].description ??
                                                        "empty",
                                                attendees: data[index]
                                                        .attended_people ??
                                                    "0",
                                                count: data[index].count ?? "0",
                                                description:
                                                    data[index].description ??
                                                        "0",
                                                isPermanent:
                                                    data[index].is_perminent ??
                                                        "1",
                                                isVip: "0",
                                                ownerType: data[index]
                                                        .owner_type_name ??
                                                    "0",
                                                // views: data[index].! ?? "0",
                                                workDate:
                                                    data[index].work_date ??
                                                        "0",
                                                workerType: data[index]
                                                        .worker_type_name ??
                                                    "0",
                                                workHours:
                                                    data[index].work_hours ??
                                                        "0",
                                                status:
                                                    data[index].status ?? "-1",
                                              ),
                                            ))))
                                    .then((value) async {
                                  await context
                                      .read<
                                          GeneralCubit<GetSavedOrdersService,
                                              GeneralInfoReqModel>>()
                                      .generalRequest(GeneralInfoReqModel());
                                });
                              },
                              child: AdView(
                                adEntity: AdEntity(
                                  id: data[index].id!,
                                  gender: data[index].gender ?? "2",
                                  address: data[index].description ?? "empty",
                                  attendees: data[index].attended_people ?? "0",
                                  count: data[index].count ?? "0",
                                  description: data[index].description ?? "0",
                                  isPermanent: data[index].is_perminent ?? "1",
                                  isVip: "0",
                                  ownerType: data[index].owner_type_name ?? "0",
                                  // views: data[index].! ?? "0",
                                  workDate: data[index].work_date ?? "0",
                                  workerType:
                                      data[index].worker_type_name ?? "0",
                                  workHours: data[index].work_hours ?? "0",
                                  status: data[index].status ?? "-1",
                                ),
                              ),
                            );
                          },
                        );
                } else if (state is GeneralFail) {
                  return SizedBox(
                    height: 600.h,
                    width: 375.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(ImageConst.noRewiew),
                        SizedBox(height: 10.h),
                        Text(t.translate("unexpected")),
                      ],
                    ),
                  );
                } else {
                  return Center(child: Text(t.translate("wentWrong")));
                }
              },
            ),
          ),
        ));
  }
}
