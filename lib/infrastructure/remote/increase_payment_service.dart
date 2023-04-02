import 'dart:async';

import 'package:dio/dio.dart';
import 'package:template/configs/application.dart';

import 'package:template/models/increase_payment_req_model.dart';
import 'package:template/models/payment_res_model.dart';

import '../../dependency_injection.dart';

import 'api_service.dart';

class IncreasePaymentService
    extends ApiService<PaymentResModel, IncreasePaymentReqModel> {
  @override
  FutureOr<PaymentResModel?> getApiData(IncreasePaymentReqModel body) async {
    var queryParameters = await body.toBase64();
    var response = await locator
        .get<Dio>()
        .get(Application.increaseBalance, queryParameters: queryParameters);
    if (response.statusCode == 200) {
      return PaymentResModel.fromJson(response.data);
    }
    return null;
  }
}
