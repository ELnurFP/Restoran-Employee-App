// ignore_for_file: non_constant_identifier_names, unnecessary_overrides

import 'package:get_storage/get_storage.dart';

import '../dependency_injection.dart';
import 'base_req_model.dart';

class RateWorkerOwnerReqModel extends BaseReqModel {
  String? opr_id;
  String userId = locator.get<GetStorage>().read('user_id');
  String verfPass = locator.get<GetStorage>().read('verf_pass');
  String lng = locator.get<GetStorage>().read('lang');
  String? order_id;
  String? not_come;
  String? rate;

  String? comment;

  RateWorkerOwnerReqModel(
      {String? userId,
      String? verfPass,
      String? lng,
      this.comment,
      this.not_come,
      this.order_id,
      this.rate,
      this.opr_id}) {
    this.userId = userId ?? locator.get<GetStorage>().read('user_id');
    this.verfPass = verfPass ?? locator.get<GetStorage>().read('verf_pass');
    this.lng = lng ?? locator.get<GetStorage>().read('lang');
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'opr_id': opr_id,
      'user_id': userId,
      'verf_pass': verfPass,
      'not_come': not_come,
      'lng': lng,
      'order_id': order_id,
      'rate': rate,
      'comment': comment
    };
  }

  @override
  Future<Map<String, String>> toBase64() {
    return super.toBase64();
  }
}
