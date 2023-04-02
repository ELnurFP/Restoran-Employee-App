// ignore_for_file: non_constant_identifier_names

import 'base_res_model.dart';

class GetSavedOrdersResModel extends BaseResModel {
  String? id;
  String? worker_type_name;
  String? owner_type_name;
  String? worker_type;
  String? owner_type;
  String? status;
  String? gender;
  String? work_date;
  String? is_perminent;
  String? work_hours;
  String? address;
  String? description;
  String? count;
  String? attended_people;

  GetSavedOrdersResModel(
      {this.id,
      this.worker_type_name,
      this.work_date,
      this.work_hours,
      this.worker_type,
      this.address,
      this.attended_people,
      this.count,
      this.description,
      this.gender,
      this.is_perminent,
      this.owner_type,
      this.owner_type_name,
      this.status});

  factory GetSavedOrdersResModel.fromJson(Map<String, dynamic> json) {
    return GetSavedOrdersResModel(
      id: json['id'],
      work_date: json['work_date'],
      work_hours: json['work_hours'],
      worker_type: json['worker_type'],
      worker_type_name: json['worker_type_name'],
      address: json['address'],
      attended_people: json['attended_people'],
      count: json['count'],
      description: json['description'],
      gender: json['gender'],
      is_perminent: json['is_perminent'],
      owner_type: json['owner_type'],
      owner_type_name: json['owner_type_name'],
      status: json['status'],
    );
  }
}
