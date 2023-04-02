// ignore_for_file: unnecessary_overrides

import 'package:get_storage/get_storage.dart';

import '../dependency_injection.dart';
import 'base_req_model.dart';

class ApplyOrderReqModel extends BaseReqModel {
  String? id;
  String userId = locator.get<GetStorage>().read('user_id');
  String verfPass = locator.get<GetStorage>().read('verf_pass');
  String lng = locator.get<GetStorage>().read('lang');
  String? type;
  String? reason;

  ApplyOrderReqModel(
      {this.type, this.id, this.reason})
      : super();

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'verf_pass': verfPass,
      'type': type,
      'lng': lng,
      'reason': reason
    };
  }

  @override
  Future<Map<String, String>> toBase64() {
    return super.toBase64();
  }
}
