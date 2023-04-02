// ignore_for_file: non_constant_identifier_names

import 'package:get_storage/get_storage.dart';
import 'package:template/models/base_res_model.dart';

import '../dependency_injection.dart';

class OTPResModel extends BaseResModel {
  OTPResModel({this.status, this.uid, this.verf_pass}) {
    locator.get<GetStorage>().write('user_id', uid);
    locator.get<GetStorage>().write('verf_pass', verf_pass);
  }

  String? status;
  String? uid;
  String? verf_pass;

  factory OTPResModel.fromJson(Map<String, dynamic> json) => OTPResModel(
      status: json["status"].toString(),
      uid: json["uid"].toString(),
      verf_pass: json['verf_pass'].toString());
}
