// ignore_for_file: unnecessary_overrides

import 'package:get_storage/get_storage.dart';
import 'package:template/dependency_injection.dart';

import 'base_req_model.dart';

class LoginReqModel extends BaseReqModel {
  String? number;
  String? password;
  String type =
      locator.get<GetStorage>().read('role') == 'Roles.Owner' ? '0' : '1';
  String? token = locator.get<GetStorage>().read('notifyToken');

  LoginReqModel({
    this.number,
    this.password,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'password': password,
      'type': type,
      'token': token,
    };
  }

  @override
  Future<Map<String, String>> toBase64() {
    return super.toBase64();
  }
}
