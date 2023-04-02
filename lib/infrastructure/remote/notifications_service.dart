import 'dart:async';

import 'package:dio/dio.dart';
import 'package:template/configs/application.dart';

import 'package:template/models/general_req_model.dart';

import 'package:template/models/notifications_res_model.dart';

import '../../dependency_injection.dart';

import 'api_service.dart';

class NotificationsService
    extends ApiService<AllNotifications, GeneralInfoReqModel> {
  @override
  FutureOr<AllNotifications?> getApiData(GeneralInfoReqModel body) async {
    var queryParameters = await body.toBase64();

    var response = await locator
        .get<Dio>()
        .get(Application.getNotifications, queryParameters: queryParameters);
    //log(response.data);
    print("response.data ${response.data}");
    if (response.statusCode == 200) {
      return AllNotifications(
          all: response.data
              .map<NotificarionsResModel>(
                  (e) => NotificarionsResModel.fromJson(e))
              .toList());
    }
    return null;
  }
}
