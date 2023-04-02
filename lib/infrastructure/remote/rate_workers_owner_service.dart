import 'dart:async';

import 'package:dio/dio.dart';

import 'package:template/models/status_model.dart';

import '../../configs/application.dart';
import '../../dependency_injection.dart';

import '../../models/rate_workers_owner_req_model.dart';
import 'api_service.dart';

class RateWorkerOwnerService
    extends ApiService<StatusModel, RateWorkerOwnerReqModel> {
  @override
  FutureOr<StatusModel?> getApiData(RateWorkerOwnerReqModel body) async {
    var queryParameters = await body.toBase64();
    print('queryParametersTTT: $queryParameters');

    var response = await locator
        .get<Dio>()
        .get(Application.sendOrderRate, queryParameters: queryParameters);
    print('responseTTT: ${response.data}');
    if (response.statusCode == 200) {
      return StatusModel.fromJson(response.data);
    }
    return null;
  }
}
