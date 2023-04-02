import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../constants/constants.dart';

SizedBox announceTabbar(
    List<dynamic> accountCardFields, ValueNotifier selectedIndex) {
  return SizedBox(
    width: 375.w,
    height: 50.h,
    child: ListView.separated(
      padding: EdgeInsets.only(
        top: 5.h,
        bottom: 5.h,
        left: 10.w,
      ),
      itemCount: accountCardFields.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: ((context, index) => ValueListenableBuilder(
            builder: (context, value, _) {
              return InkWell(
                onTap: () => selectedIndex.value = index,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: ColorConst.secondary),
                      color: selectedIndex.value == index
                          ? ColorConst.secondary
                          : Colors.white),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 2.h,
                  ),
                  child: Center(
                      child: Text(
                    accountCardFields[index]['name'],
                    style: TextStyle(
                      color: selectedIndex.value == index
                          ? Colors.white
                          : ColorConst.secondary,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
                ),
              );
            },
            valueListenable: selectedIndex,
          )),
      separatorBuilder: ((context, index) => SizedBox(
            width: 15.w,
          )),
    ),
  );
}
