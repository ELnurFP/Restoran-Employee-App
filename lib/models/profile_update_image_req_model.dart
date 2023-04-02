// ignore_for_file: unnecessary_overrides

import 'dart:io';

import 'package:get_storage/get_storage.dart';

import '../dependency_injection.dart';
import 'base_req_model.dart';

class ProfileUpdateImageReqModel extends BaseReqModel {
  String userId = locator.get<GetStorage>().read('user_id');
  String verfPass = locator.get<GetStorage>().read('verf_pass');
  File? img;
  File? background;

  ProfileUpdateImageReqModel(
      {String? userId, String? verfPass, this.img, this.background}) {
    this.userId = userId ?? locator.get<GetStorage>().read('user_id');
    this.verfPass = verfPass ?? locator.get<GetStorage>().read('verf_pass');
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'verf_pass': verfPass,
      // 'img': img,
      // 'background': background
    };
  }

  @override
  Future<Map<String, String>> toBase64() {
    return super.toBase64();
  }
}
