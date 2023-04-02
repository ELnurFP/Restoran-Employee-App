// ignore_for_file: non_constant_identifier_names

import 'package:template/models/base_res_model.dart';

class AllNotifications extends BaseResModel {
  List<NotificarionsResModel>? all;

  AllNotifications({this.all});
}

class NotificarionsResModel extends BaseResModel {
  String? id;
  String? user_id;
  String? order_id;
  String? person_id;
  String? name;
  String? createdAt;
  String? img;

  NotificarionsResModel(
      {this.id,
      this.user_id,
      this.order_id,
      this.person_id,
      this.name,
      this.createdAt,
      this.img});

  factory NotificarionsResModel.fromJson(Map<String, dynamic> json) {
    return NotificarionsResModel(
        id: json['id'],
        user_id: json['user_id'],
        order_id: json['order_id'],
        person_id: json['person_id'],
        name: json['name'],
        createdAt: json['createdAt'],
        img: json['img']);
  }
}
