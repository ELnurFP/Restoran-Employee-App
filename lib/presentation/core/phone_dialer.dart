import 'package:flutter/material.dart';
import 'package:template/language/localization.dart';
import 'package:url_launcher/url_launcher.dart';

/// Launches the given [phoneNumber] in the dialer.
launchCaller(
  String phoneNumber,
  BuildContext context,
  AppLocalizations t,
) async {
  Uri url = Uri.parse("tel:$phoneNumber");
  if (!await launchUrl(url)) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            t.translate("callerError"),
          ),
        ),
      );
    }
  }
}
