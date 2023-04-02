import 'package:template/models/base_res_model.dart';

class StatusModel extends BaseResModel {
  int? status;

  StatusModel({this.status});
  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(status: json['status']);
  }
}
