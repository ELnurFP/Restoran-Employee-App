import 'package:template/models/base_res_model.dart';

class GetReasonsResModel extends BaseResModel {
  String? id;
  String? name;

  GetReasonsResModel({
    this.id,
    this.name,
  });

  factory GetReasonsResModel.fromJson(Map<String, dynamic> json) {
    return GetReasonsResModel(id: json['id'], name: json['name']);
  }
}
