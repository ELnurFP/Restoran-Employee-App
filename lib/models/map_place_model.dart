// ignore_for_file: non_constant_identifier_names, unnecessary_new, prefer_collection_literals

class MapPlacesModel {
  String? place_name;
  String? lat;
  String? lon;
  String? isMain;

  MapPlacesModel({this.place_name, this.lat, this.lon, this.isMain});

  MapPlacesModel.fromJson(Map<String, dynamic> json) {
    place_name = json['place_name'];
    lat = json['lat'];
    lon = json['lon'];
    isMain = json['isMain'];
  }
//thisz
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['place_name'] = place_name;
    data['lat'] = lat;
    data['lon'] = lon;
    data['isMain'] = isMain;
    return data;
  }
}
