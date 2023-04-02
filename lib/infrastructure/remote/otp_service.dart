import 'dart:async';
import 'package:dio/dio.dart';
import 'package:template/configs/application.dart';
import 'package:template/models/otp_req_model.dart';
import 'package:template/models/otp_res_model.dart';

import '../../dependency_injection.dart';
import 'api_service.dart';

class OTPService extends ApiService<OTPResModel, OTPReqModel> {
  @override
  FutureOr<OTPResModel?> getApiData(OTPReqModel body) async {
    var queryParameters = await body.toBase64();
    var response = await locator
        .get<Dio>()
        .get(Application.otp, queryParameters: queryParameters);
    if (response.statusCode == 200) {
      return OTPResModel.fromJson(response.data);
    }
    return null;
  }
}
