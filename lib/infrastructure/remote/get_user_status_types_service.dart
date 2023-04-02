import 'dart:async';

import 'package:dio/dio.dart';
import 'package:template/models/get_user_status_req_model.dart';
import 'package:template/models/get_user_status_type_res_model.dart';

import '../../configs/application.dart';
import '../../dependency_injection.dart';
import 'api_service.dart';

class GetUsesStatusTypeService
    extends ApiService<GetUserStatusTypeResModel, GetUserStatusTypeReqModel> {
  @override
  FutureOr<GetUserStatusTypeResModel?> getApiData(
      GetUserStatusTypeReqModel body) async {
    var queryParameters = await body.toBase64();
    var response = await locator
        .get<Dio>()
        .get(Application.userStatusTypes, queryParameters: queryParameters);
    if (response.statusCode == 200) {
      return GetUserStatusTypeResModel(
          types: response.data
              .map<UserType>((e) => UserType.fromJson(e))
              .toList());
    }
    return null;
  }
}
