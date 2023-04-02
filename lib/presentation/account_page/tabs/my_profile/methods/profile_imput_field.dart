import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/language/localization.dart';
import '../../../../../constants/constants.dart';

class ProfileInputField extends StatelessWidget {
  const ProfileInputField({
    super.key,
    required this.title,
    required this.t,
    this.isReadOnly = false,
    this.controller,
    this.onTap,
    this.onChanged,
    this.isDropDown = false,
    this.hintText,
    this.items,
    this.initialValue,
    this.keyboardType,
  });

  final Function()? onTap;
  final Function(Object?)? onChanged;
  final TextEditingController? controller;
  final String? hintText;
  final Object? initialValue;
  final bool isDropDown;
  final bool? isReadOnly;
  final List? items;
  final AppLocalizations t;
  final String title;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 112.w,
          child: Text(
            title,
            style: FontConst.font.px16().w500().copyWith(
                  color: const Color(0xFF333232),
                ),
          ),
        ),
        SizedBox(
          width: 210.w,
          child: isDropDown
              ? DropdownButton(
                  value: initialValue,
                  hint: Text(hintText ?? t.translate("select")),
                  isExpanded: true,
                  onChanged: onChanged,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items!
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList())
              : TextFormField(
                  onTap: onTap,
                  readOnly: isReadOnly!,
                  controller: controller,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: keyboardType,
                  style: FontConst.font
                      .px14()
                      .w400()
                      .copyWith(color: ColorConst.dark),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.h,
                    ),
                    hintText: hintText,
                    fillColor: Colors.transparent,
                    suffixStyle: FontConst.font
                        .px14()
                        .w400()
                        .copyWith(color: ColorConst.softTextColor),
                    hintStyle: FontConst.font
                        .px14()
                        .w400()
                        .copyWith(color: ColorConst.softTextColor),
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: ColorConst.dviderColor)),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: ColorConst.dviderColor)),
                  ),
                ),
        )
      ],
    );
  }
}
