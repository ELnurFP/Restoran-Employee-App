// ignore_for_file: non_constant_identifier_names

import 'package:template/models/base_res_model.dart';

class PremiumResModel extends BaseResModel {
  String? title;
  String? description;
  String? img;
  List<PremiumResModelDetails>? packages;

  PremiumResModel({this.title, this.description, this.img, this.packages});

  factory PremiumResModel.fromJson(Map<String, dynamic> json) {
    return PremiumResModel(
        title: json['title'],
        description: json['description'],
        img: json['img'],
        packages: json['packages'].isNotEmpty?
            json['packages'].map<PremiumResModelDetails>((e) => PremiumResModelDetails.fromJson(e))
            .toList():[]);
  }
}

class PremiumResModelDetails {
  String? id;
  String? name;
  String? duration;
  String? price;
  String? per_month;

  PremiumResModelDetails(
      {this.id, this.name, this.duration, this.price, this.per_month});

  factory PremiumResModelDetails.fromJson(Map<String, dynamic> json) {
    return PremiumResModelDetails(
        id: json['id'],
        name: json['name'],
        duration: json['duration'],
        price: json['price'],
        per_month: json['per_month']);
  }
}
