import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/presentation/splash/splash.dart';

import '../../configs/application.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../configs/theme.dart';
import '../../cubit/language_cubit/language_cubit.dart';
import '../../cubit/language_cubit/language_state.dart';
import '../../language/localization.dart';

class BaseWidget extends StatelessWidget {
  const BaseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Application.designSize,
      minTextAdapt: Application.minTextAdapt,
      splitScreenMode: Application.splitScreenMode,
      builder: (_, __) {
        log("ScreenUtil init");
        return BlocProvider(
          create: (BuildContext context) => LocalCubit(),
          child: BlocBuilder<LocalCubit, LocalState>(
            builder: (context, state) {
              return MaterialApp(
                supportedLocales: const [
                  Locale('en', ''),
                  Locale('az', ''),
                  Locale('ru', ''),
                ],
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                debugShowCheckedModeBanner: false,
                title: Application.title,
                theme: AppTheme.currentTheme,
                home: const SplashPage(),
              );
            },
          ),
        );
      },
    );
  }
}
