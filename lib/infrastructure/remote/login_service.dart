import 'dart:async';
import 'package:dio/dio.dart';
import 'package:template/configs/application.dart';
import 'package:template/models/login_req_model.dart';
import 'package:template/models/login_res_model.dart';
import '../../dependency_injection.dart';
import 'api_service.dart';

class LoginService extends ApiService<LoginResModel, LoginReqModel> {
  @override
  FutureOr<LoginResModel?> getApiData(LoginReqModel body) async {
    var queryParameters = await body.toBase64();
    var response = await locator
        .get<Dio>()
        .get(Application.login, queryParameters: queryParameters);
    if (response.statusCode == 200) {
      return LoginResModel.fromJson(response.data);
    }
    return null;
  }
}
