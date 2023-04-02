import 'dart:async';

import 'package:dio/dio.dart';
import 'package:template/configs/application.dart';

import 'package:template/models/general_req_model.dart';

import '../../dependency_injection.dart';

import '../../models/statistics_res_model.dart';
import 'api_service.dart';

class StatisticsService
    extends ApiService<StatisticsResModel, GeneralInfoReqModel> {
  @override
  FutureOr<StatisticsResModel?> getApiData(GeneralInfoReqModel body) async {
    var queryParameters = await body.toBase64();
    var response = await locator
        .get<Dio>()
        .get(Application.getStatistics, queryParameters: queryParameters);

    if (response.statusCode == 200) {
      return StatisticsResModel.fromJson(response.data);
    }
    return null;
  }
}
