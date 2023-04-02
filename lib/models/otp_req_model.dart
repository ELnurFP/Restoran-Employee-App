// ignore_for_file: unnecessary_overrides, non_constant_identifier_names

import 'package:get_storage/get_storage.dart';

import '../dependency_injection.dart';
import 'base_req_model.dart';

class OTPReqModel extends BaseReqModel {
  String uid = locator.get<GetStorage>().read('uid');
  String? otp;
  String pass_new_code;
  String? password;

  OTPReqModel({this.password, this.otp, this.pass_new_code = '0'});

  @override
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'password': password,
      'pass_new_mode': pass_new_code,
      'otp': otp
    };
  }

  @override
  Future<Map<String, String>> toBase64() {
    return super.toBase64();
  }
}
