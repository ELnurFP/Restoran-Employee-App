// ignore_for_file: unnecessary_overrides

import 'package:get_storage/get_storage.dart';

import '../dependency_injection.dart';
import 'base_req_model.dart';

class GeneralInfoReqModel extends BaseReqModel {
  String userId = locator.get<GetStorage>().read('user_id');
  String verfPass = locator.get<GetStorage>().read('verf_pass');
  String lng = locator.get<GetStorage>().read('lang') ?? 'en';

  GeneralInfoReqModel({String? userId, String? verfPass, String? lng}) {
    {
      this.userId = userId ?? locator.get<GetStorage>().read('user_id');
      this.verfPass = verfPass ?? locator.get<GetStorage>().read('verf_pass');
      // this.lng = lng ?? locator.get<GetStorage>().read('lang');
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {'user_id': userId, 'verf_pass': verfPass, 'lng': lng};
  }

  @override
  Future<Map<String, String>> toBase64() {
    return super.toBase64();
  }
}

class GetOrderReqModel extends BaseReqModel {
  String? id;
  String userId = locator.get<GetStorage>().read('user_id');
  String verfPass = locator.get<GetStorage>().read('verf_pass');
  String lng = locator.get<GetStorage>().read('lang') ?? 'en';
  GetOrderReqModel({String? userId, String? verfPass, String? lng, this.id}) {
    {
      this.userId = userId ?? locator.get<GetStorage>().read('user_id');
      this.verfPass = verfPass ?? locator.get<GetStorage>().read('verf_pass');
      this.lng = lng ?? locator.get<GetStorage>().read('lang');
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {'user_id': userId, 'verf_pass': verfPass, 'lng': lng, 'id': id};
  }

  @override
  Future<Map<String, String>> toBase64() {
    return super.toBase64();
  }
}

class GetGuestReqModel extends BaseReqModel {
  String lng = locator.get<GetStorage>().read('lang');
  GetGuestReqModel({String? lng}) {
    {
      this.lng = lng ?? locator.get<GetStorage>().read('lang');
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {'lng': lng};
  }

  @override
  Future<Map<String, String>> toBase64() {
    return super.toBase64();
  }
}
