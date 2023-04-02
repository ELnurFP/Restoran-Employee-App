// ignore_for_file: unnecessary_overrides

import 'package:get_storage/get_storage.dart';

import '../dependency_injection.dart';
import 'base_req_model.dart';

class BuyPremiumReqModel extends BaseReqModel {
  String userId = locator.get<GetStorage>().read('user_id');
  String? id;
  String verfPass = locator.get<GetStorage>().read('verf_pass');
  String lng = locator.get<GetStorage>().read('lang');

  BuyPremiumReqModel({String? userId, String? verfPass, String? lng, this.id}) {
    this.userId = userId ?? locator.get<GetStorage>().read('user_id');
    this.verfPass = verfPass ?? locator.get<GetStorage>().read('verf_pass');
    this.lng = lng ?? locator.get<GetStorage>().read('lang');
  }

  @override
  Map<String, dynamic> toJson() {
    return {'user_id': userId, 'id': id, 'verf_pass': verfPass, 'lng': lng};
  }

  @override
  Future<Map<String, String>> toBase64() {
    return super.toBase64();
  }
}

class PromoCodeReqModel extends BaseReqModel {
  String userId = locator.get<GetStorage>().read('user_id');

  String? promocode;
  String verfPass = locator.get<GetStorage>().read('verf_pass');
  String? lng = locator.get<GetStorage>().read('lang');

  PromoCodeReqModel(
      {String? userId, String? verfPass, this.lng, this.promocode}) {
    this.userId = userId ?? locator.get<GetStorage>().read('user_id');
    this.verfPass = verfPass ?? locator.get<GetStorage>().read('verf_pass');
    //this.lng = lng ?? locator.get<GetStorage>().read('lang');
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'promocode': promocode,
      'verf_pass': verfPass,
      'lng': lng
    };
  }

  @override
  Future<Map<String, String>> toBase64() {
    return super.toBase64();
  }
}
