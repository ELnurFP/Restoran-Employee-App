// ignore_for_file: unnecessary_overrides

import 'package:get_storage/get_storage.dart';

import '../dependency_injection.dart';
import 'base_req_model.dart';

class OwnerOrderAcceptDeclineReqModel extends BaseReqModel {
  String? id;
  String userId = locator.get<GetStorage>().read('user_id');
  String verfPass = locator.get<GetStorage>().read('verf_pass');
  String lng = locator.get<GetStorage>().read('lang');
  String? type;

  OwnerOrderAcceptDeclineReqModel(
      {String? userId, String? verfPass, String? lng, this.type, this.id}) {
    this.userId = userId ?? locator.get<GetStorage>().read('user_id');
    this.verfPass = verfPass ?? locator.get<GetStorage>().read('verf_pass');
    this.lng = lng ?? locator.get<GetStorage>().read('lang');
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'verf_pass': verfPass,
      'type': type,
      'lng': lng,
    };
  }

  @override
  Future<Map<String, String>> toBase64() {
    return super.toBase64();
  }
}
