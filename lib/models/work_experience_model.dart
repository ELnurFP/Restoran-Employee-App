// ignore_for_file: non_constant_identifier_names

class WorkExperienceModel {
  String? company;
  String? title;
  String? location;
  bool? currently_work_here;
  String? start_date;
  String? end_date;

  WorkExperienceModel(
      {this.company,
      this.title,
      this.location,
      this.currently_work_here,
      this.start_date,
      this.end_date});

  factory WorkExperienceModel.fromJson(Map<String, dynamic> json) {
    return WorkExperienceModel(
      company: json['company'],
      title: json['title'],
      location: json['location'],
      currently_work_here: json['currently_work_here'],
      start_date: json['start_date'],
      end_date: json['end_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company': company,
      'title': title,
      'location': location,
      'currently_work_here': currently_work_here,
      'start_date': start_date,
      'end_date': end_date,
    };
  }
}

class ReferanceModel {
  String? name;
  String? phone;

  ReferanceModel({this.name, this.phone});

  factory ReferanceModel.fromJson(Map<String, dynamic> json) {
    return ReferanceModel(
      name: json['place'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'place': name,
      'phone': phone,
    };
  }
}

class PlaceLivedModel {
  String? place;

  PlaceLivedModel({this.place});

  factory PlaceLivedModel.fromJson(Map<String, dynamic> json) {
    return PlaceLivedModel(
      place: json['place'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'place': place,
    };
  }
}
