// To parse this JSON data, do
//
//     final profileInfoResModel = profileInfoResModelFromJson(jsonString);

import 'dart:convert';

import 'package:template/models/base_res_model.dart';

ProfileInfoResModel profileInfoResModelFromJson(String str) =>
    ProfileInfoResModel.fromJson(json.decode(str));

String profileInfoResModelToJson(ProfileInfoResModel data) =>
    json.encode(data.toJson());

class ProfileInfoResModel extends BaseResModel {
  ProfileInfoResModel(
      {this.userStatues,
      this.thisUser,
      this.userRates,
      this.userReviews,
      this.workInRayza});
  List<UserStatue>? userStatues;
  ThisUser? thisUser;
  UserRates? userRates;
  List<UserReview>? userReviews;
  List<WorkInRayza>? workInRayza;

  factory ProfileInfoResModel.fromJson(Map<String, dynamic> json) {
    return ProfileInfoResModel(
      userStatues: List<UserStatue>.from(
          json["user_statues"].map((x) => UserStatue.fromJson(x))),
      thisUser: ThisUser.fromJson(json["this_user"]),
      userRates: UserRates.fromJson(json["user_rates"]),
      userReviews: List<UserReview>.from(
          json["user_reviews"].map((x) => UserReview.fromJson(x))),
      workInRayza: List<WorkInRayza>.from(
          json["work_in_rayza"].map((x) => WorkInRayza.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "user_statues": List<dynamic>.from(userStatues!.map((x) => x.toJson())),
        "this_user": thisUser!.toJson(),
        "user_rates": userRates!.toJson(),
        "user_reviews": List<dynamic>.from(userReviews!.map((x) => x.toJson())),
        "work_in_rayza":
            List<dynamic>.from(workInRayza!.map((x) => x.toJson())),
      };
}

class ThisUser {
  ThisUser(
      {this.img,
      this.type,
      this.userTypeStatus,
      this.lat,
      this.lon,
      this.address,
      this.personName,
      this.personSurname,
      this.personFatherName,
      this.email,
      this.number,
      this.birthday,
      this.gender,
      this.workExperienceJson,
      this.peremiumAccountDate,
      this.isBlock,
      this.extraNumberJson,
      this.referancesJson,
      this.backImg,
      this.mapsJson,
      this.age,
      this.placeName});

  String? img;
  String? type;
  String? userTypeStatus;
  String? lat;
  String? lon;
  String? address;
  String? personName;
  String? personSurname;
  String? personFatherName;
  String? placeName;
  String? email;
  String? number;
  DateTime? birthday;
  String? gender;
  String? workExperienceJson;
  String? peremiumAccountDate;
  String? isBlock;
  String? extraNumberJson;
  String? referancesJson;
  String? backImg;
  String? mapsJson;
  String? age;

  factory ThisUser.fromJson(Map<String, dynamic> json) => ThisUser(
        img: json["img"].toString(),
        type: json["type"].toString(),
        userTypeStatus: json["user_type_status"]..toString(),
        lat: json["lat"].toString(),
        lon: json["lon"].toString(),
        address: json["address"].toString(),
        personName: json["person_name"].toString(),
        personSurname: json["person_surname"].toString(),
        personFatherName: json["person_father_name"].toString(),
        email: json["email"].toString(),
        number: json["number"].toString(),
        birthday: DateTime.parse(json["birthday"]),
        gender: json["gender"].toString(),
        workExperienceJson: json["work_experience_json"].toString(),
        peremiumAccountDate: json["peremium_account_date"].toString(),
        isBlock: json["is_block"].toString(),
        extraNumberJson: json["extra_number_json"].toString(),
        referancesJson: json["referances_json"].toString(),
        backImg: json["back_img"].toString(),
        mapsJson: json["maps_json"].toString(),
        age: json["age"].toString(),
        placeName: json["place_name"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "img": img,
        "type": type,
        "user_type_status": userTypeStatus,
        "lat": lat,
        "lon": lon,
        "address": address,
        "person_name": personName,
        "person_surname": personSurname,
        "person_father_name": personFatherName,
        "email": email,
        "number": number,
        "birthday":
            "${birthday!.year.toString().padLeft(4, '0')}-${birthday!.month.toString().padLeft(2, '0')}-${birthday!.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "work_experience_json": workExperienceJson,
        "peremium_account_date": peremiumAccountDate,
        "is_block": isBlock,
        "extra_number_json": extraNumberJson,
        "referances_json": referancesJson,
        "back_img": backImg,
        "maps_json": mapsJson,
        "age": age,
        "placeName": placeName,
      };
}

class UserRates {
  UserRates({
    this.count,
    this.rate,
    this.star5,
    this.star4,
    this.star3,
    this.star2,
    this.star1,
    this.notGo,
    this.respects,
  });

  String? count;
  String? rate;
  String? star5;
  String? star4;
  String? star3;
  String? star2;
  String? star1;
  String? notGo;
  String? respects;

  factory UserRates.fromJson(Map<String, dynamic> json) => UserRates(
        count: json["count"].toString(),
        rate: json["rate"].toString(),
        star5: json["star5"].toString(),
        star4: json["star4"].toString(),
        star3: json["star3"].toString(),
        star2: json["star2"].toString(),
        star1: json["star1"].toString(),
        notGo: json["not_go"].toString(),
        respects: json["respects"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "rate": rate,
        "star5": star5,
        "star4": star4,
        "star3": star3,
        "star2": star2,
        "star1": star1,
        "not_go": notGo,
        "respects": respects,
      };
}

class WorkInRayza {
  String? id;
  String? placeName;
  String? workType;
  String? date;
  DateTime? createdAt;

  WorkInRayza({
    this.id,
    this.placeName,
    this.workType,
    this.date,
    this.createdAt,
  });

  factory WorkInRayza.fromJson(Map<String, dynamic> json) => WorkInRayza(
        id: json["id"].toString(),
        placeName: json["place_name"].toString(),
        workType: json["work_type"].toString(),
        date: json["date"].toString(),
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "place_name": placeName,
        "work_type": workType,
        "date": date,
        "created_at":
            "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
      };
}

class UserReview {
  UserReview({
    this.id,
    this.name,
    this.rate,
    this.comment,
    this.workType,
    this.isNotCome,
  });

  String? id;
  String? name;
  String? rate;
  String? comment;
  String? workType;
  String? isNotCome;

  factory UserReview.fromJson(Map<String, dynamic> json) => UserReview(
        id: json["id"].toString(),
        name: json["name"].toString(),
        rate: json["rate"].toString(),
        comment: json["comment"].toString(),
        workType: json["work_type"].toString(),
        isNotCome: json["is_not_come"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "rate": rate,
        "comment": comment,
        "work_type": workType,
        "is_not_come": isNotCome,
      };
}

class UserStatue {
  UserStatue({
    this.id,
    this.type,
    this.name,
    this.hidden,
  });

  String? id;
  String? type;
  String? name;
  String? hidden;

  factory UserStatue.fromJson(Map<String, dynamic> json) => UserStatue(
        id: json["id"].toString(),
        type: json["type"].toString(),
        name: json["name"].toString(),
        hidden: json["hidden"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "hidden": hidden,
      };
}
