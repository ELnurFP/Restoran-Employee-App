// ignore_for_file: non_constant_identifier_names, unnecessary_overrides

import 'package:get_storage/get_storage.dart';

import '../dependency_injection.dart';
import 'base_req_model.dart';

class UpdateSavedOrdersReqModel extends BaseReqModel {
  String? id;
  String user_id = locator.get<GetStorage>().read('user_id');
  String verf_pass = locator.get<GetStorage>().read('verf_pass');
  String lng = locator.get<GetStorage>().read('lang');
  String? type;
  UpdateSavedOrdersReqModel(
      {this.id, String? user_id, String? verf_pass, String? lng, this.type}) {
    this.user_id = user_id ?? locator.get<GetStorage>().read('user_id');
    this.verf_pass = verf_pass ?? locator.get<GetStorage>().read('verf_pass');
    this.lng = lng ?? locator.get<GetStorage>().read('lang');
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'verf_pass': verf_pass,
      'lng': lng,
      'type': type
    };
  }

  @override
  Future<Map<String, String>> toBase64() {
    return super.toBase64();
  }
}
