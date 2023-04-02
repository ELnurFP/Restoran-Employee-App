// ignore_for_file: unnecessary_overrides

import 'base_req_model.dart';

class GetUserStatusTypeReqModel extends BaseReqModel {
  String? type;

  GetUserStatusTypeReqModel({this.type});

  @override
  Map<String, dynamic> toJson() {
    return {'type': type, 'lng': 'az'};
  }

  @override
  Future<Map<String, String>> toBase64() {
    return super.toBase64();
  }
}
