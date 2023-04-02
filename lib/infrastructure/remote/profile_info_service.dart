import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:template/configs/application.dart';

import 'package:template/models/general_req_model.dart';

import 'package:template/models/profile_info_res_model.dart';

import '../../dependency_injection.dart';

import 'api_service.dart';

class ProfileInfoService
    extends ApiService<ProfileInfoResModel, GeneralInfoReqModel> {
  @override
  FutureOr<ProfileInfoResModel?> getApiData(GeneralInfoReqModel body) async {
    var queryParameters = await body.toBase64();
    var response = await locator
        .get<Dio>()
        .get(Application.getProfile, queryParameters: queryParameters);

    if (response.statusCode == 200) {
      return ProfileInfoResModel.fromJson(response.data);
    }
    return null;
  }
}

class ProfileViewService
    extends ApiService<ProfileInfoResModel, GeneralInfoReqModel> {
  @override
  FutureOr<ProfileInfoResModel?> getApiData(GeneralInfoReqModel body) async {
    var queryParameters = await body.toBase64();
    if (kDebugMode) {
      print('queryParameters $queryParameters');
      print(queryParameters);
    }
    var response = await locator
        .get<Dio>()
        .get(Application.getProfileView, queryParameters: queryParameters);
    if (kDebugMode) {
      print('${response.statusCode} status code ');
      var allUserStatuses = response.data["user_statues"];
      print("--------------------");
      print("allUserStatuses $allUserStatuses");
      print("--------------------");
    }

    if (response.statusCode == 200) {
      return ProfileInfoResModel.fromJson(response.data);
    }
    return null;
  }
}
