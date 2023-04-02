import 'dart:async';
import 'package:dio/dio.dart';
import 'package:template/configs/application.dart';
import 'package:template/models/banner_click_model.dart';
import 'package:template/models/status_model.dart';
import '../../dependency_injection.dart';
import 'api_service.dart';

class SendBannerClickService
    extends ApiService<StatusModel, BannerClickReqModel> {
  @override
  FutureOr<StatusModel?> getApiData(BannerClickReqModel body) async {
    var queryParameters = await body.toBase64();
    var response = await locator
        .get<Dio>()
        .get(Application.sendBannerClick, queryParameters: queryParameters);

    if (response.statusCode == 200) {
      return StatusModel.fromJson(response.data);
    }
    return null;
  }
}
