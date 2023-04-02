import 'dart:async';

import 'package:dio/dio.dart';
import 'package:template/configs/application.dart';

import 'package:template/models/general_req_model.dart';
import 'package:template/models/get_all_orders_res_model.dart';

import '../../dependency_injection.dart';

import '../../models/base_res_model.dart';
import 'api_service.dart';

class AllOrderList extends BaseResModel {
  List<GetAllOrdersResModel>? all;

  AllOrderList({this.all});
}

class GetAllOrdersService
    extends ApiService<AllOrderList, GeneralInfoReqModel> {
  @override
  FutureOr<AllOrderList?> getApiData(GeneralInfoReqModel body) async {
    var queryParameters = await body.toBase64();
    var response = await locator
        .get<Dio>()
        .get(Application.getAllOrders, queryParameters: queryParameters);
    if (response.statusCode == 200) {
      return AllOrderList(
          all: response.data
              .map<GetAllOrdersResModel>(
                  (e) => GetAllOrdersResModel.fromJson(e))
              .toList());
    }
    return null;
  }
}
