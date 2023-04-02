import 'package:template/models/base_res_model.dart';

class PaymentResModel extends BaseResModel {
  String? status;
  String? img;
  String? title;
  String? description;

  PaymentResModel({this.status, this.img, this.title, this.description});

  factory PaymentResModel.fromJson(Map<String, dynamic> json) {
    return PaymentResModel(
        status: json['status'],
        img: json['img'],
        title: json['title'],
        description: json['description']);
  }
}
