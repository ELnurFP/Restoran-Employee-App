import 'dart:async';

import 'package:dio/dio.dart';
import 'package:template/infrastructure/remote/api_service.dart';
import 'package:template/models/get_favorites.dart';

import '../../configs/application.dart';
import '../../dependency_injection.dart';
import '../../models/base_res_model.dart';
import '../../models/general_req_model.dart';

class AllFavList extends BaseResModel {
  List<GetFavoritesResModel>? all;

  AllFavList({this.all});
}

class GetFavoritesService extends ApiService<AllFavList, GeneralInfoReqModel> {
  @override
  FutureOr<AllFavList?> getApiData(GeneralInfoReqModel body) async {
    var queryParameters = await body.toBase64();
    var response = await locator
        .get<Dio>()
        .get(Application.getFavorites, queryParameters: queryParameters);
    if (response.statusCode == 200) {
      return AllFavList(
          all: response.data
              .map<GetFavoritesResModel>(
                  (e) => GetFavoritesResModel.fromJson(e))
              .toList());
    }
    return null;
  }
}
