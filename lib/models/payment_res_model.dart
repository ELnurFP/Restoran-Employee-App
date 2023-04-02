import 'base_res_model.dart';

class PaymentResModel extends BaseResModel {
  int? status;
  String? url;

  PaymentResModel({
    this.status,
    this.url,
  });

  factory PaymentResModel.fromJson(Map<String, dynamic> json) {
    return PaymentResModel(status: json['status'], url: json['url']);
  }
}

class PromoCodeModel extends BaseResModel {
  int? status;
  String? img;
  String? description;
  String? title;

  PromoCodeModel({this.status, this.img, this.description, this.title});

  factory PromoCodeModel.fromJson(Map<String, dynamic> json) {
    return PromoCodeModel(
        status: json['status'],
        img: json['img'],
        description: json['description'],
        title: json['title']);
  }
}
