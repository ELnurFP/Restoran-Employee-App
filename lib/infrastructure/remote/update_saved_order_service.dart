import 'dart:async';

import 'package:dio/dio.dart';
import 'package:template/configs/application.dart';

import 'package:template/models/status_model.dart';

import '../../dependency_injection.dart';

import '../../models/update_saved_orders_req_model.dart';
import 'api_service.dart';

class UpdateSavedOrdersService
    extends ApiService<StatusModel, UpdateSavedOrdersReqModel> {
  @override
  FutureOr<StatusModel?> getApiData(UpdateSavedOrdersReqModel body) async {
    var queryParameters = await body.toBase64();
    var response = await locator
        .get<Dio>()
        .get(Application.sendSavedOrder, queryParameters: queryParameters);

    if (response.statusCode == 200) {
      return StatusModel.fromJson(response.data);
    }
    return null;
  }
}
