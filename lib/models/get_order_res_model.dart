// ignore_for_file: non_constant_identifier_names

import 'base_res_model.dart';

class GetOrderResModel extends BaseResModel {
  String? type;
  GetOrderResModelDetail? order;
  List<GetApplieds>? applied_users;

  GetOrderResModel({this.type, this.order, this.applied_users});

  factory GetOrderResModel.fromJson(Map<String, dynamic> json) {
    return GetOrderResModel(
        type: json['type'],
        order: GetOrderResModelDetail.fromJson(json['order']),
        applied_users: json['applied_users'] != null
            ? (json['applied_users'] as List<dynamic>)
                .map((i) => GetApplieds.fromJson(i))
                .toList()
            : null);
  }
}

class GetOrderResModelDetail {
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
  String? lat;
  String? lon;
  String? radius;
  String? applied;
  String? views;
  String? total;
  String? order_type;
  String? createdAt;
  String? saved;

  String? is_vip;
  GetOrderResModelDetail(
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
      this.status,
      this.lat,
      this.lon,
      this.radius,
      this.applied,
      this.views,
      this.total,
      this.order_type,
      this.createdAt,
      this.saved,
      this.is_vip});

  factory GetOrderResModelDetail.fromJson(Map<String, dynamic> json) {
    return GetOrderResModelDetail(
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
        lat: json['lat'],
        lon: json['lon'],
        radius: json['radius'],
        applied: json['applied'],
        views: json['views'],
        total: json['total'],
        order_type: json['order_type'],
        createdAt: json['createdAt'],
        saved: json['saved'],
        is_vip: json['is_vip']);
  }
}

class GetApplieds {
  String? id;
  String? user_id;
  String? status;
  String? reason;
  String? rate;
  String? comment;
  String? is_not_come;
  String? person_name;
  String? person_surname;
  String? img;
  String? worker_type;
  String? worker_type_name;
  String? owner_type_name;

  GetApplieds(
      {this.id,
      this.user_id,
      this.status,
      this.reason,
      this.rate,
      this.comment,
      this.is_not_come,
      this.person_name,
      this.person_surname,
      this.img,
      this.worker_type,
      this.worker_type_name,
      this.owner_type_name});

  factory GetApplieds.fromJson(Map<String, dynamic> json) {
    return GetApplieds(
        id: json['id'],
        user_id: json['user_id'],
        status: json['status'],
        reason: json['reason'],
        rate: json['rate'],
        comment: json['comment'],
        is_not_come: json['is_not_come'],
        person_name: json['person_name'],
        person_surname: json['person_surname'],
        img: json['img'],
        worker_type: json['worker_type'],
        worker_type_name: json['worker_type_name'],
        owner_type_name: json['owner_type_name']);
  }
}
