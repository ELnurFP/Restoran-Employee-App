import 'dart:async';

import 'package:dio/dio.dart';
import 'package:template/configs/application.dart';

import 'package:template/models/general_req_model.dart';

import '../../dependency_injection.dart';

import '../../models/get_balance_history_res_model.dart';
import 'api_service.dart';

class GetBalanceHistoryService
    extends ApiService<GetBalanceHistoryResModel, GeneralInfoReqModel> {
  @override
  FutureOr<GetBalanceHistoryResModel?> getApiData(
      GeneralInfoReqModel body) async {
    var queryParameters = await body.toBase64();
    var response = await locator
        .get<Dio>()
        .get(Application.getBalanceHistory, queryParameters: queryParameters);
    if (response.statusCode == 200) {
      return GetBalanceHistoryResModel.fromJson(response.data);
    }
    return null;
  }
}
