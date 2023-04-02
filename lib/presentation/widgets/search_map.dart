import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/language/localization.dart';

import '../../constants/constants.dart';

class SearchMapWidget extends StatelessWidget {
  const SearchMapWidget({super.key, required this.controller, required this.t});
  final TextEditingController controller;
  final AppLocalizations t;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return t.translate("adressConstraint");
        }
        return null;
      },
      textCapitalization: TextCapitalization.sentences,
      controller: controller,
      decoration: InputDecoration(
        hintText: t.translate("addressHint"),
        hintStyle: FontConst.font
            .px14()
            .w400()
            .copyWith(color: const Color(0xff949494)),
        filled: true,
        isDense: true,
        fillColor: Colors.transparent,
        suffixIcon: Image.asset(ImageConst.map, height: 23.h),
      ),
    );
  }
}
