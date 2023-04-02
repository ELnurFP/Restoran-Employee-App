import 'dart:async';

import 'package:dio/dio.dart';
import 'package:template/configs/application.dart';

import 'package:template/models/general_req_model.dart';

import 'package:template/models/get_order_res_model.dart';

import '../../dependency_injection.dart';

import 'api_service.dart';

class GetOrderService extends ApiService<GetOrderResModel, GetOrderReqModel> {
  @override
  FutureOr<GetOrderResModel?> getApiData(GetOrderReqModel body) async {
    var queryParameters = await body.toBase64();
    var response = await locator
        .get<Dio>()
        .get(Application.getOrder, queryParameters: queryParameters);
    print('responseTTT: ${response.data['applied_users']}');
    if (response.statusCode == 200) {
      return GetOrderResModel.fromJson(response.data);
    }
    return null;
  }
}
