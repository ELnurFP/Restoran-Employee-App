// ignore_for_file: non_constant_identifier_names, unnecessary_overrides

import 'package:get_storage/get_storage.dart';

import '../dependency_injection.dart';
import 'base_req_model.dart';

class ProfileUpdateReqModel extends BaseReqModel {
  String userId = locator.get<GetStorage>().read('user_id');
  String? verfPass = locator.get<GetStorage>().read('verf_pass');
  String? lng = locator.get<GetStorage>().read('lang');
  String? place_name;
  String? user_type_status;
  double? lat;
  double? lon;
  String? address;
  String? person_name;
  String? person_surname;
  String? person_father_name;
  String? email;
  DateTime? birthday;
  String? gender;
  String? work_experience_json;
  String? referances_json;
  String? maps_json;

  ProfileUpdateReqModel(
      {String? userId,
      String? verfPass,
      String? lng,
      this.work_experience_json,
      this.maps_json,
      this.place_name,
      this.user_type_status,
      this.lat,
      this.lon,
      this.address,
      this.person_name,
      this.person_surname,
      this.person_father_name,
      this.email,
      this.birthday,
      this.referances_json,
      this.gender}) {
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
      'place_name': place_name,
      'user_type_status': user_type_status,
      'lat': lat,
      'lon': lon,
      'address': address,
      'person_name': person_name,
      'person_surname': person_surname,
      'person_father_name': person_father_name,
      'email': email,
      'birthday': birthday != null ? birthday!.toIso8601String() : null,
      'gender': gender,
      'work_experience_json': work_experience_json,
      'referances_json': referances_json,
      'maps_json': maps_json,
    };
  }

  @override
  Future<Map<String, String>> toBase64() {
    return super.toBase64();
  }
}
