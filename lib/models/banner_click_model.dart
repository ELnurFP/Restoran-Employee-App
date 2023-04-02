// ignore_for_file: unnecessary_overrides

import 'package:get_storage/get_storage.dart';

import '../dependency_injection.dart';
import 'base_req_model.dart';

class BannerClickReqModel extends BaseReqModel {
  String userId = locator.get<GetStorage>().read('user_id');
  String verfPass = locator.get<GetStorage>().read('verf_pass');
  String? id;

  BannerClickReqModel({String? userId, String? verfPass, this.id}){
    this.userId = userId??locator.get<GetStorage>().read('user_id');
    this.verfPass = verfPass??locator.get<GetStorage>().read('verf_pass');
  }


  @override
  Map<String, dynamic> toJson() {
    return {'user_id': userId, 'verf_pass': verfPass, 'id': id};
  }

  @override
  Future<Map<String, String>> toBase64() {
    return super.toBase64();
  }
}
