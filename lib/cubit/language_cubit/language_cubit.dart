import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import '../../dependency_injection.dart';
import '../../language/localization.dart';
import 'language_state.dart';

class LocalCubit extends Cubit<LocalState> {
  LocalCubit() : super(LocalInitState());

  void changeLocal(String lang, BuildContext context) {
    AppLocalizations? t = AppLocalizations.of(context);
    locator.get<GetStorage>().write('lang', lang);
    t!.load();
    emit(ChangeLocalState(lang: lang));
  }
}
