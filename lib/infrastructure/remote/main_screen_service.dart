import 'dart:async';
import 'package:dio/dio.dart';
import 'package:template/configs/application.dart';
import 'package:template/models/general_req_model.dart';
import 'package:template/models/main_screen_res_model.dart';
import '../../dependency_injection.dart';
import 'api_service.dart';

class MainScreenService
    extends ApiService<MainScreenResModel, GeneralInfoReqModel> {
  @override
  FutureOr<MainScreenResModel?> getApiData(GeneralInfoReqModel body) async {
    var queryParameters = await body.toBase64();
    print(queryParameters);
    var response = await locator
        .get<Dio>()
        .get(Application.getMainScreen, queryParameters: queryParameters);

    if (response.statusCode == 200) {
      return MainScreenResModel.fromJson(response.data);
    }
    return null;
  }
}

class MainGuestScreenService
    extends ApiService<MainScreenResModel, GetGuestReqModel> {
  @override
  FutureOr<MainScreenResModel?> getApiData(GetGuestReqModel body) async {
    var queryParameters = await body.toBase64();
    var response = await locator
        .get<Dio>()
        .get(Application.mainGuest, queryParameters: queryParameters);
    if (response.statusCode == 200) {
      return MainScreenResModel.fromJson(response.data);
    }
    return null;
  }
}
