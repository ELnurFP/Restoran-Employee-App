import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/constants/constants.dart';

/// isRequired puts a red * at the end of the text field
TextFormField customTextFiled(
  String hintText,
  TextEditingController controller,
  Function(String?)? validator, {
  bool isRequired = false,
  TextInputType? keyboardType,
  int? maxLength,
  int? maxLines,
  double? radius = 13,
  double? verticalPadding = 12,
  Function()? onTap,
  bool? readOnly,
}) {
  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius!.r),
    borderSide: BorderSide(
      color: const Color(0xffBEBEBE),
      width: 1.h,
    ),
  );
  return TextFormField(
    readOnly: readOnly ?? false,
    textCapitalization: TextCapitalization.sentences,
    onTap: onTap,
    maxLines: maxLines,
    controller: controller,
    validator: (value) => validator!(value!),
    maxLength: maxLength,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      fillColor: Colors.white,
      counterText: "",
      hintText: hintText,
      hintStyle: FontConst.font.w400().px14().copyWith(
            color: const Color(0xff989898),
          ),
      isDense: true,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: verticalPadding!.h,
      ),
      border: outlineInputBorder,
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      errorBorder: outlineInputBorder,
      focusedErrorBorder: outlineInputBorder,
      suffixIcon: isRequired
          ? Padding(
              padding: EdgeInsets.only(right: 15.w),
              child: Text(
                "*",
                style: FontConst.font.w400().px12().copyWith(
                      color: const Color(0xffFA0C0C),
                    ),
              ),
            )
          : null,
      suffixIconConstraints:
          isRequired ? BoxConstraints(maxHeight: 30.h, minHeight: 28.h) : null,
    ),
  );
}
