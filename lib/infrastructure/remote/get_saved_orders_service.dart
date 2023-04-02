import 'dart:async';

import 'package:dio/dio.dart';

import 'package:template/models/general_req_model.dart';

import 'package:template/models/get_saved_orders_res_model.dart';

import '../../configs/application.dart';
import '../../dependency_injection.dart';

import '../../models/base_res_model.dart';
import 'api_service.dart';

class AllSavedList extends BaseResModel {
  List<GetSavedOrdersResModel>? all;

  AllSavedList({this.all});
}

class GetSavedOrdersService
    extends ApiService<AllSavedList, GeneralInfoReqModel> {
  @override
  FutureOr<AllSavedList?> getApiData(GeneralInfoReqModel body) async {
    var queryParameters = await body.toBase64();
    var response = await locator
        .get<Dio>()
        .get(Application.getSavedOrders, queryParameters: queryParameters);
    if (response.statusCode == 200) {
      return AllSavedList(
          all: response.data
              .map<GetSavedOrdersResModel>(
                  (e) => GetSavedOrdersResModel.fromJson(e))
              .toList());
    }
    return null;
  }
}
