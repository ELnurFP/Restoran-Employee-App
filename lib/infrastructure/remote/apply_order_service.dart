import 'dart:async';

import 'package:dio/dio.dart';
import 'package:template/configs/application.dart';
import 'package:template/models/apply_order_req_model.dart';

import '../../dependency_injection.dart';
import '../../models/status_model.dart';
import 'api_service.dart';

class ApplyOrderService extends ApiService<StatusModel, ApplyOrderReqModel> {
  @override
  FutureOr<StatusModel?> getApiData(ApplyOrderReqModel body) async {
    var queryParameters = await body.toBase64();
    var response = await locator
        .get<Dio>()
        .get(Application.sendOrderApply, queryParameters: queryParameters);
    if (response.statusCode == 200) {
      return StatusModel.fromJson(response.data);
    }
    return null;
  }
}
