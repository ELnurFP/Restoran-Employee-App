// ignore_for_file: unnecessary_overrides

import 'base_req_model.dart';

class ForgotReqModel extends BaseReqModel {
  String? number;

  ForgotReqModel({
    this.number,
  });

  @override
  Map<String, dynamic> toJson() {
    return {'number': number};
  }

  @override
  Future<Map<String, String>> toBase64() {
    return super.toBase64();
  }
}
