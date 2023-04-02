import 'package:template/models/base_res_model.dart';

abstract class GeneralState {}

class GeneralInit extends GeneralState {}

class GeneralLoading extends GeneralState {}

class GeneralSuccess<R extends BaseResModel> extends GeneralState {
  // ignore: prefer_typing_uninitialized_variables
  R? data;
  GeneralSuccess({this.data});
}

class GeneralFail extends GeneralState {
  String? message;
  GeneralFail({this.message});
}
