import 'dart:async';

import 'package:dio/dio.dart';
import 'package:template/configs/application.dart';
import 'package:template/models/payment_res_model.dart';

import '../../dependency_injection.dart';
import '../../models/buy_premium_req_model.dart';
import 'api_service.dart';

class BuyPremiumService
    extends ApiService<PaymentResModel, BuyPremiumReqModel> {
  @override
  FutureOr<PaymentResModel?> getApiData(BuyPremiumReqModel body) async {
    var queryParameters = await body.toBase64();
    var response = await locator
        .get<Dio>()
        .get(Application.buyPremium, queryParameters: queryParameters);
    if (response.statusCode == 200) {
      return PaymentResModel.fromJson(response.data);
    }
    return null;
  }
}

class PromoCodeService extends ApiService<PromoCodeModel, PromoCodeReqModel> {
  @override
  FutureOr<PromoCodeModel?> getApiData(PromoCodeReqModel body) async {
    var queryParameters = await body.toBase64();
    var response = await locator
        .get<Dio>()
        .get(Application.promo, queryParameters: queryParameters);
    print('responseTTT: ${response.data}');
    if (response.statusCode == 200) {
      return PromoCodeModel.fromJson(response.data);
    }
    return null;
  }
}
