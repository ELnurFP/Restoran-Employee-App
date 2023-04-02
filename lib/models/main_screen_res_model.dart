import 'package:template/models/base_res_model.dart';

// MainScreenResModel mainScreenResModelFromJson(String str) =>
//     MainScreenResModel.fromJson(json.decode(str));

// String mainScreenResModelToJson(MainScreenResModel data) =>
//     json.encode(data.toJson());

class MainScreenResModel extends BaseResModel {
  MainScreenResModel({this.mainscreen, this.isProfileCompleted});

  List<Mainscreen>? mainscreen;
  String? isProfileCompleted;

  factory MainScreenResModel.fromJson(Map<String, dynamic> json) =>
      MainScreenResModel(
        isProfileCompleted: json['is_profile_completed'].toString(),
        mainscreen: List<Mainscreen>.from(
            json["mainscreen"].map((x) => Mainscreen.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mainscreen": List<dynamic>.from(
            mainscreen!.map<Map<String, dynamic>>((x) => x.toJson())),
      };
}

class Mainscreen {
  Mainscreen({
    this.type,
    this.payload,
    this.title,
    this.link,
    this.icon,
  });

  String? type;
  List<Map<String, dynamic>>? payload;
  String? title;
  String? link;
  String? icon;

  factory Mainscreen.fromJson(Map<String, dynamic> json) => Mainscreen(
        type: json["type"],
        payload: json["payload"] == null
            ? []
            : List<Map<String, dynamic>>.from(json["payload"]!.map((x) =>
                Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
        title: json["title"],
        link: json["link"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "payload": payload == null
            ? []
            : List<dynamic>.from(payload!.map((x) =>
                Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
        "title": title,
        "link": link,
        "icon": icon,
      };
}
