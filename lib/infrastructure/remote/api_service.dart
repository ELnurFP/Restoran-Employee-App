import 'dart:async';

import 'package:template/models/base_req_model.dart';

import '../../models/base_res_model.dart';

abstract class ApiService<G extends BaseResModel, P extends BaseReqModel> {
  FutureOr<G?> getApiData(P body);
}
