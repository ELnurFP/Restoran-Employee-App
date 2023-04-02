import 'dart:async';

import 'package:dio/dio.dart';
import 'package:template/configs/application.dart';

import 'package:template/models/profile_update_image_req_model.dart';
import 'package:template/models/status_model.dart';

import '../../dependency_injection.dart';

import 'api_service.dart';

class ProfileUpdateImageService
    extends ApiService<StatusModel, ProfileUpdateImageReqModel> {
  @override
  FutureOr<StatusModel?> getApiData(ProfileUpdateImageReqModel body) async {
    //  print('${body.toJson()}    body');
    var queryParameters = await body.toBase64();

    // print("${queryParameters['img']} param");
    FormData formdata = FormData();

    // print(body.img!.path.split('/').last);
    formdata.files.addAll([
      if (body.img != null)
        MapEntry(
            'img',
            MultipartFile.fromFileSync(body.img!.path.toString(),
                filename: body.img!.path.split('/').last)),
      if (body.background != null)
        MapEntry(
            'background',
            MultipartFile.fromFileSync(body.background!.path.toString(),
                filename: body.background!.path.split('/').last))
    ]);

    var response = await locator.get<Dio>().post(Application.updateImage,
        queryParameters: queryParameters, data: formdata);
    if (response.statusCode == 200) {
      return StatusModel.fromJson(response.data);
    }
    return null;
  }
}
