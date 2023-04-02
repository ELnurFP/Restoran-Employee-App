import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/infrastructure/remote/apply_order_service.dart';
import 'package:template/infrastructure/remote/buy_premium_service.dart';
import 'package:template/infrastructure/remote/cancel_order_owner_service.dart';
import 'package:template/infrastructure/remote/create_order_service.dart';
import 'package:template/infrastructure/remote/forgot_service.dart';
import 'package:template/infrastructure/remote/get_all_orders_service.dart';
import 'package:template/infrastructure/remote/get_balance_history_service.dart';
import 'package:template/infrastructure/remote/get_favorites.dart';
import 'package:template/infrastructure/remote/get_order_service.dart';
import 'package:template/infrastructure/remote/get_reasons_service.dart';
import 'package:template/infrastructure/remote/get_saved_orders_service.dart';
import 'package:template/infrastructure/remote/get_user_status_types_service.dart';
import 'package:template/infrastructure/remote/increase_payment_service.dart';
import 'package:template/infrastructure/remote/login_service.dart';
import 'package:template/infrastructure/remote/main_screen_service.dart';
import 'package:template/infrastructure/remote/notifications_service.dart';
import 'package:template/infrastructure/remote/owner_order_accept_decline_service.dart';
import 'package:template/infrastructure/remote/premium_service.dart';
import 'package:template/infrastructure/remote/profile_info_service.dart';
import 'package:template/infrastructure/remote/profile_update_image_service.dart';
import 'package:template/infrastructure/remote/profile_update_service.dart';
import 'package:template/infrastructure/remote/rate_workers_owner_service.dart';
import 'package:template/infrastructure/remote/send_banner_click_service.dart';
import 'package:template/infrastructure/remote/update_saved_order_service.dart';
import 'infrastructure/remote/get_balance_service.dart';
import 'infrastructure/remote/otp_service.dart';
import 'infrastructure/remote/sign_in_service.dart';
import 'infrastructure/remote/statistics_service.dart';

final locator = GetIt.instance;

void setupDI() {
  locator.registerSingletonAsync<SharedPreferences>(() async {
    final shared = await SharedPreferences.getInstance();
    return shared;
  });

  locator.registerLazySingleton<Dio>(() => Dio());
  locator.registerLazySingleton<ApplyOrderService>(() => ApplyOrderService());
  locator.registerLazySingleton<BuyPremiumService>(() => BuyPremiumService());
  locator.registerLazySingleton<CancelOrderOwnerService>(
      () => CancelOrderOwnerService());
  locator.registerLazySingleton<CreateOrderService>(() => CreateOrderService());
  locator.registerLazySingleton<GetOrderService>(() => GetOrderService());
  locator
      .registerLazySingleton<GetAllOrdersService>(() => GetAllOrdersService());
  locator.registerLazySingleton<GetBalanceHistoryService>(
      () => GetBalanceHistoryService());
  locator
      .registerLazySingleton<GetFavoritesService>(() => GetFavoritesService());
  locator.registerLazySingleton<GetReasonsService>(() => GetReasonsService());
  locator.registerLazySingleton<GetSavedOrdersService>(
      () => GetSavedOrdersService());
  locator.registerLazySingleton<IncreasePaymentService>(
      () => IncreasePaymentService());
  locator.registerLazySingleton<NotificationsService>(
      () => NotificationsService());
  locator.registerLazySingleton<OwnerOrderAcceptDeclineService>(
      () => OwnerOrderAcceptDeclineService());
  //locator.registerLazySingleton<Dio>(() => Dio());
  locator.registerLazySingleton<PremiumService>(() => PremiumService());
  locator.registerLazySingleton<ProfileInfoService>(() => ProfileInfoService());
  locator.registerLazySingleton<ProfileUpdateImageService>(
      () => ProfileUpdateImageService());
  locator.registerLazySingleton<ProfileUpdateService>(
      () => ProfileUpdateService());
  locator.registerLazySingleton<RateWorkerOwnerService>(
      () => RateWorkerOwnerService());
  locator.registerLazySingleton<UpdateSavedOrdersService>(
      () => UpdateSavedOrdersService());
  locator.registerLazySingleton<MainScreenService>(() => MainScreenService());
  locator.registerLazySingleton<MainGuestScreenService>(
      () => MainGuestScreenService());
  locator.registerLazySingleton<SignInService>(() => SignInService());
  locator.registerLazySingleton<LoginService>(() => LoginService());
  locator.registerLazySingleton<GetStorage>(() => GetStorage());
  locator.registerLazySingleton<SendBannerClickService>(
      () => SendBannerClickService());
  locator.registerLazySingleton<GetUsesStatusTypeService>(
      () => GetUsesStatusTypeService());

  locator.registerLazySingleton<OTPService>(() => OTPService());
  locator.registerLazySingleton<PromoCodeService>(() => PromoCodeService());
  locator.registerLazySingleton<ForgotService>(() => ForgotService());

  locator.registerLazySingleton<ProfileViewService>(() => ProfileViewService());
  locator.registerLazySingleton<GetBalanceService>(() => GetBalanceService());
  locator.registerLazySingleton<StatisticsService>(() => StatisticsService());


  

  //SignInService
  // locator.registerLazySingleton<NetworkRepository>(
  //   () {
  //     final service = NetworkRepository(baseUrl: Application.apiBaseUrl);
  //     return service;
  //   },
  // );
}
