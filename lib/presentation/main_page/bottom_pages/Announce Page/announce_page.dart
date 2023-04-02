import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/language/localization.dart';
import 'package:template/presentation/main_page/bottom_pages/Announce%20Page/methods/tabbar.dart';

import '../../../../constants/image_constant.dart';
import '../../../../cubit/general_cubit.dart';
import '../../../../cubit/general_state.dart';
import '../../../../infrastructure/remote/get_all_orders_service.dart';
import '../../../../models/general_req_model.dart';
import '../../../widgets/custom_appbar.dart';
import 'tabs/ads_card.dart';

class AnnouncePage extends StatelessWidget {
  const AnnouncePage({Key? key}) : super(key: key);
  static final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    AppLocalizations? t = AppLocalizations.of(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context
              .read<GeneralCubit<GetAllOrdersService, GeneralInfoReqModel>>()
              .generalRequest(GeneralInfoReqModel());
        },
        child: SizedBox(
          height: 812.h,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 20.h),
              child: BlocBuilder<
                  GeneralCubit<GetAllOrdersService, GeneralInfoReqModel>,
                  GeneralState>(
                builder: (context, state) {
                  if (state is GeneralFail) {
                    return SizedBox(
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
                  } else if (state is GeneralSuccess) {
                    final List<dynamic> accountCardFields = [
                      {
                        'name': t!.translate("active"),
                        "widget": adsCard(
                            (state.data as AllOrderList)
                                .all!
                                .where((element) => element.status == "0")
                                .toList(),
                            t),
                      },
                      {
                        'name': t.translate("cancelled"),
                        "widget": adsCard(
                            (state.data as AllOrderList)
                                .all!
                                .where((element) => element.status == "4")
                                .toList(),
                            t),
                      },
                      {
                        'name': t.translate("archive"),
                        "widget": adsCard(
                            (state.data as AllOrderList)
                                .all!
                                .where((element) => element.status == "3")
                                .toList(),
                            t),
                      },
                      {
                        'name': t.translate("completed"),
                        "widget": adsCard(
                            (state.data as AllOrderList)
                                .all!
                                .where((element) => element.status == "1")
                                .toList(),
                            t),
                      },
                    ];

                    return Column(
                      children: [
                        customAppBar(context, t.translate("advertisements"),
                            isback: false),
                        SizedBox(height: 10.h),
                        announceTabbar(accountCardFields, _selectedIndex),
                        SizedBox(height: 10.h),
                        ValueListenableBuilder(
                          valueListenable: _selectedIndex,
                          builder: (context, value, child) {
                            return accountCardFields[_selectedIndex.value]
                                ['widget'];
                          },
                        ),
                      ],
                    );
                  } else {
                    return SizedBox(
                        height: 812.h,
                        width: 375.w,
                        child:
                            const Center(child: CircularProgressIndicator()));
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
