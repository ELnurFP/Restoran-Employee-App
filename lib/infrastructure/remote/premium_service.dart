import 'dart:async';

import 'package:dio/dio.dart';
import 'package:template/configs/application.dart';

import 'package:template/models/general_req_model.dart';

import 'package:template/models/premium_res_model.dart';

import '../../dependency_injection.dart';

import 'api_service.dart';

class PremiumService extends ApiService<PremiumResModel, GeneralInfoReqModel> {
  @override
  FutureOr<PremiumResModel?> getApiData(GeneralInfoReqModel body) async {
    var queryParameters = await body.toBase64();
    var response = await locator
        .get<Dio>()
        .get(Application.getPremiums, queryParameters: queryParameters);
    if (response.statusCode == 200) {
      return PremiumResModel.fromJson(response.data);
    }
    return null;
  }
}
