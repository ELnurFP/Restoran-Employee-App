import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:template/language/localization.dart';

import '../../../widgets/custom_appbar.dart';

class BePartnerPage extends StatelessWidget {
  const BePartnerPage({Key? key}) : super(key: key);

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
      url: 'https://rayza.az/be-partner',
    );
  }
}
