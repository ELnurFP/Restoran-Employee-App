import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/cubit/general_state.dart';
import 'package:template/dependency_injection.dart';
import 'package:template/infrastructure/remote/api_service.dart';
import 'package:template/models/base_req_model.dart';

class GeneralCubit<S extends ApiService, P extends BaseReqModel>
    extends Cubit<GeneralState> {
  GeneralCubit() : super(GeneralInit());

  Future<void> generalRequest(P model) async {
    try {
      emit(GeneralLoading());
      var data = await locator.get<S>().getApiData(model);
      emit(GeneralSuccess(data: data));
    } on SocketException {
      emit(GeneralFail(message: 'No internet connection'));
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      emit(GeneralFail(message: 'Unexpected error'));
    }
  }
}
