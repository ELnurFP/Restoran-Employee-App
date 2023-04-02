// ignore_for_file: non_constant_identifier_names

import 'package:template/models/base_res_model.dart';

class CreateOrderResModel extends BaseResModel {
  String? status;
  String? url;
  PriceType? price_list;

  CreateOrderResModel({
    this.status,
    this.url,
    this.price_list,
  });

  factory CreateOrderResModel.fromJson(Map<String, dynamic> json) {
    //print(json);
    return CreateOrderResModel(
        status: json['status'].toString(),
        url: json['url'],
        price_list: json['price_list'] != null
            ? PriceType.fromJson(json['price_list']!)
            : null);
  }
}

class PriceType {
  PriceTypeModel? eco;
  PriceTypeModel? express;

  PriceType({this.eco, this.express});

  factory PriceType.fromJson(Map<String, dynamic> json) {
    //print(json);

    return PriceType(
        eco: json['eco'] != null ? PriceTypeModel.fromJson(json['eco']) : null,
        express: json['express'] != null
            ? PriceTypeModel.fromJson(json['express'])
            : null);
  }
}

class PriceTypeModel {
  String? price;
  String? hours;

  PriceTypeModel({this.price, this.hours});

  factory PriceTypeModel.fromJson(Map<String, dynamic> json) {
    // print(json);

    return PriceTypeModel(
        price: json['price'].toString(), hours: json['hours'].toString());
  }
}
