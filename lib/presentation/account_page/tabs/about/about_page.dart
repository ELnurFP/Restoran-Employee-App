import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/language/localization.dart';
import 'package:template/presentation/widgets/custom_appbar.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static ValueNotifier<bool> show = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    AppLocalizations? t = AppLocalizations.of(context);
    return WebviewScaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight.h),
        child: customAppBar(
          context,
          t!.translate('about'),
        ),
      ),
      url: 'https://rayza.az/app-about',
    );
  }
}
