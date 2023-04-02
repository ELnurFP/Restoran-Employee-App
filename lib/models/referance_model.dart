class ReferanceModel {
  String? phone;
  String? person;

  ReferanceModel({this.phone, this.person});

  ReferanceModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    person = json['person'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['person'] = person;
    return data;
  }
}
