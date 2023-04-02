import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/constants/constants.dart';
import 'package:template/cubit/general_state.dart';
import 'package:template/language/localization.dart';
import 'package:template/models/statistics_res_model.dart';
import 'package:template/presentation/main_page/entity/statistics_entity.dart';
import 'package:template/presentation/main_page/widgets/statistics_view.dart';
import 'package:template/presentation/statistics_page/widgets/chart_card.dart';
import 'package:template/presentation/statistics_page/widgets/statistics_order_card.dart';
import 'package:template/presentation/widgets/custom_appbar.dart';
import '../../cubit/general_cubit.dart';
import '../../infrastructure/remote/statistics_service.dart';
import '../../models/general_req_model.dart';
import 'widgets/total_view_widget.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations t = AppLocalizations.of(context)!;
    return Scaffold(
      body: BlocBuilder<GeneralCubit<StatisticsService, GeneralInfoReqModel>,
          GeneralState>(builder: (context, state) {
        if (state is GeneralSuccess) {
          StatisticsResModel data = state.data as StatisticsResModel;
          print('data.viewCount  ${data.viewCount}');
          return SingleChildScrollView(
            child: Column(
              children: [
                customAppBar(context, t.translate("statistics")),
                SizedBox(height: 30.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    children: [
                      StatisticsView(
                        statisticsEntity: StatisticsEntity(
                            adCount: data.adCount ?? '0',
                            employeeCount: data.empCount ?? '0'),
                        titleSize: 14,
                      ),
                      SizedBox(height: 19.h),
                      if (data.viewCount != null && data.viewCount != "null")
                        TotalViewWidget(
                          totalView: data.viewCount!.isNotEmpty
                              ? int.parse(data.viewCount!)
                              : 0,
                        ),
                      SizedBox(height: 19.h),
                      ChartCard(
                        t: t,
                        isViews: true,
                        datas: data.statistics,
                      ),
                      SizedBox(height: 19.h),
                      ChartCard(
                        t: t,
                        isViews: false,
                        datas: data.statistics,
                      ),
                      SizedBox(height: 19.h),
                      Divider(
                        color: const Color(0xffCECECE),
                        thickness: 1.h,
                      ),
                      SizedBox(height: 20.h),
                      if (data.orders != null)
                        ...data.orders!.map<StaticticsOrderCard>(
                          (e) => StaticticsOrderCard(
                            t: t,
                            order: e,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: ColorConst.ekonomColor,
            ),
          );
        }
      }),
    );
  }
}
