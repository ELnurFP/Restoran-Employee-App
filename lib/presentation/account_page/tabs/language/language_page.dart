import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/constants/constants.dart';

import '../../../../cubit/language_cubit/language_cubit.dart';
import '../../../../cubit/language_cubit/language_state.dart';
import '../../../../language/localization.dart';
import '../../../widgets/custom_appbar.dart';
import 'methods/language_card.dart';
import 'package:template/presentation/main_page/main_page.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});
  static var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28.r),
    borderSide: BorderSide.none,
  );
  @override
  Widget build(BuildContext context) {
    AppLocalizations? t = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<LocalCubit, LocalState>(
        builder: (context, state) {
          return Column(
            children: [
              customAppBar(context, t!.translate('selectLang')),
              SizedBox(height: 23.h),
              InkWell(
                  onTap: () {
                    BlocProvider.of<LocalCubit>(context)
                        .changeLocal('az', context);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const MainPage()),
                        (route) => false);
                  },
                  child: languageCard("Azerbaijani", ImageConst.az2)),
              InkWell(
                  onTap: () {
                    BlocProvider.of<LocalCubit>(context)
                        .changeLocal('en', context);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const MainPage()),
                        (route) => false);
                  },
                  child: languageCard("English", ImageConst.en)),
              InkWell(
                  onTap: () {
                    BlocProvider.of<LocalCubit>(context)
                        .changeLocal('ru', context);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const MainPage()),
                        (route) => false);
                  },
                  child: languageCard("Russian", ImageConst.ru)),
            ],
          );
        },
      ),
    );
  }
}
