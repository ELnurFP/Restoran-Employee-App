import 'dart:async';

import 'package:dio/dio.dart';
import 'package:template/configs/application.dart';

import 'package:template/models/create_order_req_model.dart';
import 'package:template/models/create_order_res_model.dart';

import '../../dependency_injection.dart';

import 'api_service.dart';

class CreateOrderService
    extends ApiService<CreateOrderResModel, CreateOrderReqModel> {
  @override
  FutureOr<CreateOrderResModel?> getApiData(CreateOrderReqModel body) async {
    var queryParameters = await body.toBase64();

    var response = await locator
        .get<Dio>()
        .get(Application.sendOrderCreate, queryParameters: queryParameters);

    if (response.statusCode == 200) {
      return CreateOrderResModel.fromJson(response.data);
    }
    return null;
  }
}
