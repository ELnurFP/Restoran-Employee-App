import 'dart:async';

import 'package:dio/dio.dart';

import 'package:template/models/general_with_order_req_model.dart';

import 'package:template/models/get_reasons_res_model.dart';

import '../../configs/application.dart';
import '../../dependency_injection.dart';

import '../../models/base_res_model.dart';
import 'api_service.dart';

class AllReasons extends BaseResModel {
  List<GetReasonsResModel>? all;
  AllReasons({this.all});
}

class GetReasonsService
    extends ApiService<AllReasons, GeneralWithOrderReqModel> {
  @override
  FutureOr<AllReasons?> getApiData(GeneralWithOrderReqModel body) async {
    var queryParameters = await body.toBase64();
    var response = await locator
        .get<Dio>()
        .get(Application.getReasons, queryParameters: queryParameters);

    if (response.statusCode == 200) {
      return AllReasons(
          all: response.data
              .map<GetReasonsResModel>((e) => GetReasonsResModel.fromJson(e))
              .toList());
    }
    return null;
  }
}
