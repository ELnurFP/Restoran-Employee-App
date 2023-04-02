import 'dart:async';

import 'package:dio/dio.dart';
import 'package:template/configs/application.dart';

import 'package:template/models/general_req_model.dart';

import '../../dependency_injection.dart';
import '../../models/get_balance_model.dart';
import 'api_service.dart';

class GetBalanceService extends ApiService<BalanceModel, GeneralInfoReqModel> {
  @override
  FutureOr<BalanceModel?> getApiData(GeneralInfoReqModel body) async {
    var queryParameters = await body.toBase64();
    var response = await locator
        .get<Dio>()
        .get(Application.getBalance, queryParameters: queryParameters);
    if (response.statusCode == 200) {
      return BalanceModel.fromJson(response.data);
    }
    return null;
  }
}
