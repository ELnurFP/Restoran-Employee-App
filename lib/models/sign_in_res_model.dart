import 'package:get_storage/get_storage.dart';
import 'package:template/dependency_injection.dart';
import 'package:template/models/base_res_model.dart';

class SignInResModel extends BaseResModel {
  SignInResModel({
    this.status,
    String? uid,
  }) {
    locator.get<GetStorage>().write('uid', uid);
  }

  String? status;
  String? uid;

  factory SignInResModel.fromJson(Map<String, dynamic> json) => SignInResModel(
        status: json["status"].toString(),
        uid: json["uid"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "uid": uid,
      };
}
