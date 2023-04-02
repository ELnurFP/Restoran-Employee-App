import 'dart:async';
import 'package:dio/dio.dart';
import 'package:template/configs/application.dart';
import 'package:template/models/forgot_req_model.dart';
import '../../dependency_injection.dart';
import '../../models/sign_in_res_model.dart';
import 'api_service.dart';

class ForgotService extends ApiService<SignInResModel, ForgotReqModel> {
  @override
  FutureOr<SignInResModel?> getApiData(ForgotReqModel body) async {
    var queryParameters = await body.toBase64();
    var response = await locator
        .get<Dio>()
        .get(Application.forgot, queryParameters: queryParameters);

    if (response.statusCode == 200) {
      return SignInResModel.fromJson(response.data);
    }
    return null;
  }
}
