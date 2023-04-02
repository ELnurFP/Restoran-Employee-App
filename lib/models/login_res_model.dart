// ignore_for_file: non_constant_identifier_names

import 'package:get_storage/get_storage.dart';
import 'package:template/models/base_res_model.dart';

import '../dependency_injection.dart';

class LoginResModel extends BaseResModel {
  LoginResModel(
      {this.status,
      String? id,
      this.password,
      this.person_name,
      this.person_surname,
      String? user_type_status,
      String? status_name_az,
      String? status_name_en,
      String? status_name_ru,
      String? verf_pass}) {
    locator.get<GetStorage>().write('user_id', id);
    locator.get<GetStorage>().write('verf_pass', verf_pass);
    locator.get<GetStorage>().write('user_status', user_type_status);
    locator.get<GetStorage>().write('user_status_az', status_name_az);
    locator.get<GetStorage>().write('user_status_en', status_name_en);
    locator.get<GetStorage>().write('user_status_ru', status_name_ru);

    this.id = id ?? '';
    this.verf_pass = verf_pass ?? '';
    this.user_type_status = user_type_status ?? '';
    this.status_name_az = status_name_az ?? '';
    this.status_name_en = status_name_en ?? '';
    this.status_name_ru = status_name_ru ?? '';
  }

  factory LoginResModel.fromJson(Map<String, dynamic> json) => LoginResModel(
      status: json["status"].toString(),
      id: json["id"].toString(),
      password: json['password'].toString(),
      person_name: json['person_name'].toString(),
      person_surname: json['person_surname'].toString(),
      user_type_status: json['user_type_status'],
      status_name_az: json['status_name_az'],
      status_name_en: json['status_name_en'],
      status_name_ru: json['status_name_ru'],
      verf_pass: json['verf_pass'].toString());

  String id = '';
  String? password;
  String? person_name;
  String? person_surname;
  String? status;
  String status_name_az = '';
  String status_name_en = '';
  String status_name_ru = '';
  String user_type_status = '';
  String verf_pass = '';
}
