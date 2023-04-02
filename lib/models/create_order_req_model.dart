// ignore_for_file: non_constant_identifier_names, unnecessary_overrides

import 'package:get_storage/get_storage.dart';

import '../dependency_injection.dart';
import 'base_req_model.dart';

class CreateOrderReqModel extends BaseReqModel {
  String userId = locator.get<GetStorage>().read('user_id');
  String verfPass = locator.get<GetStorage>().read('verf_pass');
  String lng = locator.get<GetStorage>().read('lang');
  String? worker_id;
  String? count;
  String? gender;
  int? age_from;
  int? age_to;
  String? work_date;
  int? is_perminent;
  String? work_hours;
  String? address;
  String? lat;
  String? lon;
  String? description;
  String? price_type;

  CreateOrderReqModel(
      {String? userId,
      String? verfPass,
      String? lng,
      this.address,
      this.age_from,
      this.age_to,
      this.count,
      this.description,
      this.gender,
      this.is_perminent,
      this.lat,
      this.lon,
      this.price_type,
      this.work_date,
      this.work_hours,
      this.worker_id}) {
    this.userId = userId ?? locator.get<GetStorage>().read('user_id');
    this.verfPass = verfPass ?? locator.get<GetStorage>().read('verf_pass');
    this.lng = lng ?? locator.get<GetStorage>().read('lang');
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'verf_pass': verfPass,
      'lng': lng,
      'worker_type': worker_id,
      'count': count,
      'gender': gender,
      'age_from': age_from,
      'age_to': age_to,
      'work_date': work_date,
      'is_perminent': is_perminent,
      'work_hours': work_hours,
      'address': address,
      'lat': lat,
      'lon': lon,
      'description': description,
      'price_type': price_type
    };
  }

  @override
  Future<Map<String, String>> toBase64() {
    return super.toBase64();
  }
}
