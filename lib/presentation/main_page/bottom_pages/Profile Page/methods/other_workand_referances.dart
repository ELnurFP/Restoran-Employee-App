import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:template/language/localization.dart';
import 'package:template/presentation/core/phone_dialer.dart';

import '../../../../../constants/constants.dart';

class OtherWorkAndReferencesWidget extends StatelessWidget {
  const OtherWorkAndReferencesWidget(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.t});

  final String subtitle;
  final AppLocalizations t;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Text(
          title,
          style: FontConst.font.w500().px14().copyWith(
                color: ColorConst.dark,
              ),
        ),
        SizedBox(height: 5.h),
        GestureDetector(
          onTap: () {
            launchCaller(subtitle, context, t);
          },
          child: Text(
            subtitle,
            style: FontConst.font.w500().px14().copyWith(
                  color: ColorConst.subtitleColor,
                  decoration: TextDecoration.underline,
                ),
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}

class WorkFieldWidget extends StatelessWidget {
  const WorkFieldWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.startDate,
    this.endDate,
    this.isContinue = false,
    this.isRayza = false,
    this.rayzaDate,
  });

  final String? endDate;
  final bool isContinue;
  final bool isRayza;
  final DateTime? rayzaDate;
  final String? startDate;
  final String subtitle;
  final String title;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMMM d, y');
    final formattedStartDate = isRayza
        ? dateFormat.format(rayzaDate!)
        : dateFormat.format(DateTime.now());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Text(
          '$title • $subtitle',
          style: FontConst.font.w500().px14().copyWith(
                color: ColorConst.dark,
              ),
        ),
        SizedBox(height: 5.h),
        if (isRayza)
          Text(
            formattedStartDate,
            style: FontConst.font.w500().px14().copyWith(
                  color: ColorConst.subtitleColor,
                ),
          )
        else if (startDate != null && startDate!.isNotEmpty)
          Flexible(
            child: Text(
              overflow: TextOverflow.clip,
              isContinue ? '$startDate ' : '$startDate - $endDate',
              style: FontConst.font.w500().px14().copyWith(
                    color: ColorConst.subtitleColor,
                  ),
            ),
          )
        else
          const SizedBox(),
        SizedBox(height: 10.h),
      ],
    );
  }
}
