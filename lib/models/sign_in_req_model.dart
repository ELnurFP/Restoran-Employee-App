// ignore_for_file: unnecessary_overrides, non_constant_identifier_names

import 'package:get_storage/get_storage.dart';

import '../dependency_injection.dart';
import 'base_req_model.dart';

class SignInReqModel extends BaseReqModel {
  String? name;
  String? number;
  String? email;
  String? password;
  String? type;
  String? user_type_status;
  String? login_type;
  String? token = locator.get<GetStorage>().read('notifyToken');

  SignInReqModel(
      {this.email,
      this.name,
      this.type,
      this.number,
      this.password,
      this.user_type_status,
      this.login_type});

  @override
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'number': number,
      'password': password,
      'user_type': type,
      'user_type_status': user_type_status,
      'login_type': login_type,
      'token': token,
    };
  }

  @override
  Future<Map<String, String>> toBase64() {
    return super.toBase64();
  }
}
