import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:template/configs/base64_conventer.dart';
import 'package:template/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/infrastructure/remote/buy_premium_service.dart';
import 'package:template/infrastructure/remote/get_balance_history_service.dart';
import 'package:template/infrastructure/remote/get_balance_service.dart';
import 'package:template/infrastructure/remote/increase_payment_service.dart';
import 'package:template/infrastructure/remote/premium_service.dart';
import 'package:template/infrastructure/remote/profile_info_service.dart';
import 'package:template/language/localization.dart';
import 'package:template/models/buy_premium_req_model.dart';
import 'package:template/models/general_req_model.dart';
import 'package:template/models/increase_payment_req_model.dart';
import 'package:template/models/profile_info_res_model.dart';
import 'package:template/presentation/account_page/tabs/my_profile/methods/account_card.dart';
import 'package:template/presentation/account_page/tabs/my_profile/my_profile.dart';
import 'package:template/presentation/account_page/tabs/premium_page/premium_page.dart';
import 'package:template/presentation/registration/role_choser_page.dart';
import 'package:template/presentation/widgets/custom_dialog.dart';
import 'package:template/presentation/widgets/get_premium.dart';
import '../../cubit/general_cubit.dart';
import '../../cubit/general_state.dart';
import '../../dependency_injection.dart';
import '../../infrastructure/remote/profile_update_image_service.dart';
import '../../infrastructure/remote/profile_update_service.dart';
import '../../models/profile_update_image_req_model.dart';
import '../../models/profile_update_req_model.dart';
import '../main_page/bottom_pages/Announce Page/tabs/favorites_ad.dart';
import '../widgets/custom_appbar.dart';
import 'tabs/about/about_page.dart';
import 'tabs/balance/balance_page.dart';
import 'tabs/be_partner/be_partner_page.dart';
import 'tabs/language/language_page.dart';

class AccountPage extends StatelessWidget {
  AccountPage({super.key, this.data});

  final ProfileInfoResModel? data;

  final _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    AppLocalizations? t = AppLocalizations.of(context);
    return Scaffold(
      key: _key,
      body: BlocBuilder<GeneralCubit<ProfileInfoService, GeneralInfoReqModel>,
          GeneralState>(builder: (context, state) {
        if (state is GeneralSuccess) {
          List<dynamic> accountCardFields = [
            {
              "id": 0,
              'name': t!.translate("myProfile"),
              "widget": MultiBlocProvider(
                providers: [
                  BlocProvider<
                          GeneralCubit<ProfileUpdateService,
                              ProfileUpdateReqModel>>(
                      create: (context) => GeneralCubit<ProfileUpdateService,
                          ProfileUpdateReqModel>()),
                  BlocProvider<
                          GeneralCubit<ProfileUpdateImageService,
                              ProfileUpdateImageReqModel>>(
                      create: (context) => GeneralCubit<
                          ProfileUpdateImageService,
                          ProfileUpdateImageReqModel>()),
                ],
                child: MyProfilePage(
                  profileInfoResModel: (state.data as ProfileInfoResModel),
                  fromMain: true,
                ),
              ),
              "icon": IconConst.person,
            },
            {
              "id": 1,
              'name': t.translate("language"),
              "widget": const LanguagePage(),
              "icon": IconConst.translate
            },
            {
              "id": 2,
              'name': t.translate("about"),
              "widget": const AboutPage(),
              "icon": IconConst.info,
            },
            {
              "id": 3,
              'name': t.translate("balance"),
              "widget": MultiBlocProvider(providers: [
                BlocProvider<
                        GeneralCubit<GetBalanceHistoryService,
                            GeneralInfoReqModel>>(
                    create: (context) => GeneralCubit<GetBalanceHistoryService,
                        GeneralInfoReqModel>()
                      ..generalRequest(GeneralInfoReqModel())),
                BlocProvider<
                        GeneralCubit<GetBalanceService, GeneralInfoReqModel>>(
                    create: (context) =>
                        GeneralCubit<GetBalanceService, GeneralInfoReqModel>()
                          ..generalRequest(GeneralInfoReqModel())),
                BlocProvider<GeneralCubit<PremiumService, GeneralInfoReqModel>>(
                  create: (context) =>
                      GeneralCubit<PremiumService, GeneralInfoReqModel>()
                        ..generalRequest(GeneralInfoReqModel()),
                ),
                BlocProvider<
                        GeneralCubit<IncreasePaymentService,
                            IncreasePaymentReqModel>>(
                    create: (context) => GeneralCubit<IncreasePaymentService,
                        IncreasePaymentReqModel>()),
                BlocProvider<
                        GeneralCubit<BuyPremiumService, BuyPremiumReqModel>>(
                    create: (context) =>
                        GeneralCubit<BuyPremiumService, BuyPremiumReqModel>()),
                BlocProvider<GeneralCubit<PromoCodeService, PromoCodeReqModel>>(
                  create: (context) =>
                      GeneralCubit<PromoCodeService, PromoCodeReqModel>(),
                )
              ], child: const BalancePage()),
              "icon": IconConst.balance
            },
            {
              "id": 4,
              'name': t.translate("favorite"),
              "widget": const FavoritesAds(),
              "icon": IconConst.like
            },
            {
              "id": 5,
              'name': t.translate("bePartner"),
              "widget": const BePartnerPage(),
              "icon": IconConst.star
            },
            {
              "id": 6,
              'name': t.translate("logout"),
              "widget": const Placeholder(),
              "icon": IconConst.logout,
            },
          ];
          //   locator.get<GetStorage>().read('role') == 'Roles.Worker'

          return SingleChildScrollView(
            child: Column(
              children: [
                customAppBar(context,
                    "${(state.data as ProfileInfoResModel).thisUser!.personName!.fromBase64} ${(state.data as ProfileInfoResModel).thisUser!.personSurname!.fromBase64}"),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Divider(
                          color: ColorConst.dviderColor,
                          thickness: 1.h,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          itemBuilder: ((context, index) => locator
                                          .get<GetStorage>()
                                          .read('role') ==
                                      'Roles.Owner' &&
                                  accountCardFields[index]["id"] == 4
                              ? const SizedBox()
                              : accountCard(
                                  accountCardFields[index]["icon"],
                                  accountCardFields[index]["name"],
                                  () async {
                                    if (accountCardFields[index]["id"] == 6) {
                                      customDialogBox(
                                        context,
                                        () async {
                                          locator
                                              .get<GetStorage>()
                                              .remove('role');
                                          locator
                                              .get<GetStorage>()
                                              .remove('user_id');
                                          locator
                                              .get<GetStorage>()
                                              .remove('verf_pass');

                                          await Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(builder:
                                                      (context) {
                                            return const RoleChooserPage();
                                          }), (route) => false).then(
                                                  (value) async => await context
                                                      .read<
                                                          GeneralCubit<
                                                              ProfileInfoService,
                                                              GeneralInfoReqModel>>()
                                                      .generalRequest(
                                                          GeneralInfoReqModel()));
                                        },
                                        t.translate("confirmLogout"),
                                        t,
                                        title:
                                            t.translate("confirmLogoutTitle"),
                                      );
                                    } else {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              accountCardFields[index]
                                                  ["widget"],
                                        ),
                                      );
                                    }
                                  },
                                )),
                          itemCount: accountCardFields.length),
                      SizedBox(height: 40.h),
                      locator.get<GetStorage>().read('role') == 'Roles.Worker'
                          ?
                          //here
                          (state.data as ProfileInfoResModel)
                                      .thisUser!
                                      .peremiumAccountDate ==
                                  '0000-00-00'
                              ? Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: premiumButton(() {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return MultiBlocProvider(providers: [
                                          BlocProvider<
                                              GeneralCubit<PremiumService,
                                                  GeneralInfoReqModel>>(
                                            create: (context) => GeneralCubit<
                                                PremiumService,
                                                GeneralInfoReqModel>()
                                              ..generalRequest(
                                                  GeneralInfoReqModel()),
                                          ),
                                          BlocProvider<
                                                  GeneralCubit<
                                                      BuyPremiumService,
                                                      BuyPremiumReqModel>>(
                                              create: (context) => GeneralCubit<
                                                  BuyPremiumService,
                                                  BuyPremiumReqModel>()),
                                        ], child: const PremiumPage());
                                      },
                                    )).then((value) async {
                                      await context
                                          .read<
                                              GeneralCubit<ProfileInfoService,
                                                  GeneralInfoReqModel>>()
                                          .generalRequest(
                                              GeneralInfoReqModel());
                                    });
                                  }, t.translate("getPremium")),
                                )
                              : premiumButton(
                                  () => null,
                                  (state.data as ProfileInfoResModel)
                                      .thisUser!
                                      .peremiumAccountDate!)
                          : const SizedBox(),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ],
            ),
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
