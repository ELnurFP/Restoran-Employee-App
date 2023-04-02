import 'dart:async';

import 'package:dio/dio.dart';
import 'package:template/configs/application.dart';
import 'package:template/models/cancel_order_owner_req_model.dart';

import 'package:template/models/status_model.dart';

import '../../dependency_injection.dart';

import 'api_service.dart';

class CancelOrderOwnerService
    extends ApiService<StatusModel, CancelOrderOwnerReqModel> {
  @override
  FutureOr<StatusModel?> getApiData(CancelOrderOwnerReqModel body) async {
    var queryParameters = await body.toBase64();
    var response = await locator.get<Dio>().get(
        Application.sendOrderStatusCancel,
        queryParameters: queryParameters);

    if (response.statusCode == 200) {
      return StatusModel.fromJson(response.data);
    }
    return null;
  }
}
