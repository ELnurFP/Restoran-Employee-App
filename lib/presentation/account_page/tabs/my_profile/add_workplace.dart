// ignore_for_file: deprecated_member_use, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:template/constants/constants.dart";
import "package:template/language/localization.dart";
import "package:template/presentation/widgets/custom_appbar.dart";
import "package:template/presentation/widgets/main_buton.dart";

import "../../../../models/work_experience_model.dart";

class AddWorkPlace extends StatefulWidget {
  const AddWorkPlace({super.key, required this.workExperienceList});

  final ValueNotifier<List<Map<String, dynamic>>> workExperienceList;

  @override
  State<AddWorkPlace> createState() => _AddWorkPlaceState();
}

class _AddWorkPlaceState extends State<AddWorkPlace> {
  late String _initialFromDay = DateTime.now().day.toString();
  late String _initialFromMonth = _months[DateTime.now().month - 1];
  late String _initialFromYear = DateTime.now().year.toString();
  late String _initialToDay = DateTime.now().day.toString();
  late String _initialToMonth = _months[DateTime.now().month - 1];
  late String _initialToYear = DateTime.now().year.toString();
  late bool _isCurrentWorkplace = false;
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final List<String> _months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  final TextEditingController _nameController = TextEditingController();

  List getMonths(bool isFrom) {
    final List<String> months = [];
    final int year = int.parse(isFrom ? _initialFromYear : _initialToYear);
    final int currentYear = DateTime.now().year;
    final int currentMonth = DateTime.now().month;

    if (year == currentYear) {
      if (!isFrom && _fromDate().year == _toDate().year) {
        for (int i = _months.indexOf(_initialFromMonth);
            i < currentMonth;
            i++) {
          months.add(_months[i]);
        }
      } else {
        for (int i = 0; i < currentMonth; i++) {
          months.add(_months[i]);
        }
      }
    } else {
      if (!isFrom && _fromDate().year == _toDate().year) {
        for (int i = _months.indexOf(_initialFromMonth);
            i < _months.length;
            i++) {
          months.add(_months[i]);
        }
      } else {
        months.addAll(_months);
      }
    }
    return months;
  }

  String getInitialMonth(bool isFrom) {
    int initialMonth =
        _months.indexOf(isFrom ? _initialFromMonth : _initialToMonth) + 1;
    final int year = int.parse(isFrom ? _initialFromYear : _initialToYear);
    final int currentYear = DateTime.now().year;
    final int currentMonth = DateTime.now().month;
    if (_fromDate().year == _toDate().year) {
      if (_months.indexOf(_initialToMonth) <
          _months.indexOf(_initialFromMonth)) {
        _initialToMonth = _months[_months.indexOf(_initialFromMonth)];
        return _months[_months.indexOf(_initialFromMonth)];
      }
    }
    if (year == currentYear && initialMonth > currentMonth) {
      isFrom
          ? _initialFromMonth = _months[currentMonth - 1]
          : _initialToMonth = _months[currentMonth - 1];
      return _months[currentMonth - 1];
    } else {
      return isFrom ? _initialFromMonth : _initialToMonth;
    }
  }

  Container customDatePicker(
      Function(Object?)? onChanged, String value, List items,
      {double? width}) {
    return Container(
        width: width,
        height: 40.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.r),
          border: Border.all(
            color: ColorConst.ligtGrey,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
        child: Center(
          child: DropdownButton(
            iconSize: 15.sp,
            isDense: true,
            iconEnabledColor: ColorConst.ligtGrey,
            icon: Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: const Icon(Icons.keyboard_arrow_down_outlined)),
            underline: Container(),
            value: value,
            items: items
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Text(e,
                            style: FontConst.font
                                .w400()
                                .px14()
                                .c(ColorConst.ligtGrey)),
                      ),
                    ))
                .toList(),
            onChanged: onChanged,
          ),
        ));
  }

  SizedBox customTextField(TextEditingController controller, String hintText) {
    return SizedBox(
      width: 270.w,
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        controller: controller,
        style: FontConst.font
            .px14()
            .w400()
            .copyWith(color: ColorConst.softTextColor),
        decoration: InputDecoration(
          hintText: hintText,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            vertical: 15.h,
          ),
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
              borderSide: BorderSide(width: 1, color: ColorConst.dviderColor)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: ColorConst.dviderColor)),
        ),
      ),
    );
  }

  DateTime _fromDate() => DateTime(int.parse(_initialFromYear),
      _months.indexOf(_initialFromMonth) + 1, int.parse(_initialFromDay));

  DateTime _toDate() => DateTime(int.parse(_initialToYear),
      _months.indexOf(_initialToMonth) + 1, int.parse(_initialToDay));

  List _getYears(bool isFrom) {
    final List<String> years = [];
    final int currentYear = DateTime.now().year;
    if (isFrom) {
      for (int i = 1950; i <= currentYear; i++) {
        years.add(i.toString());
      }
    } else {
      for (int i = _fromDate().year; i <= currentYear; i++) {
        years.add(i.toString());
      }
    }
    if (_fromDate().year > _toDate().year) {
      _initialToYear = _initialFromYear;
    }
    return years;
  }

  List<String> _getDays(bool isFrom) {
    final List<String> days = [];
    final int year = int.parse(isFrom ? _initialFromYear : _initialToYear);
    final int month =
        _months.indexOf(isFrom ? _initialFromMonth : _initialToMonth) + 1;
    final int currentYear = DateTime.now().year;
    final int currentMonth = DateTime.now().month;
    final int currentDay = DateTime.now().day;
    final int daysInMonth = DateTime(year, month + 1, 0).day;
    int k = 0;
    int i = 1;
    if (!isFrom &&
        _fromDate().year == _toDate().year &&
        _fromDate().month == _toDate().month) {
      i = int.parse(_initialFromDay);
    }
    if (year == currentYear && month == currentMonth) {
      k = currentDay;
    } else {
      k = daysInMonth;
    }
    for (i; i <= k; i++) {
      days.add(i.toString());
    }
    return days;
  }

  String _getinitialDay(bool isFrom) {
    final int year = int.parse(isFrom ? _initialFromYear : _initialToYear);
    final int month =
        _months.indexOf(isFrom ? _initialFromMonth : _initialToMonth) + 1;
    final int currentYear = DateTime.now().year;
    final int currentMonth = DateTime.now().month;
    final int currentDay = DateTime.now().day;
    final int daysInMonth = DateTime(year, month + 1, 0).day;
    int initialDay =
        isFrom ? int.parse(_initialFromDay) : int.parse(_initialToDay);

    if (_fromDate().year == _toDate().year &&
        _fromDate().month == _toDate().month &&
        _toDate().day < _fromDate().day) {
      _initialToDay = _initialFromDay;
      return _initialToDay;
    }
    if (year == currentYear &&
        month == currentMonth &&
        initialDay > currentDay) {
      isFrom
          ? _initialFromDay = currentDay.toString()
          : _initialToDay = currentDay.toString();
      return currentDay.toString();
    } else if (daysInMonth > initialDay) {
      isFrom
          ? _initialFromDay = initialDay.toString()
          : _initialToDay = initialDay.toString();
      return initialDay.toString();
    } else {
      isFrom
          ? _initialFromDay = daysInMonth.toString()
          : _initialToDay = daysInMonth.toString();
      return daysInMonth.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations? t = AppLocalizations.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customAppBar(context, t!.translate("addWorkplace")),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(4.r),
                        height: 25.r,
                        width: 25.r,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorConst.primary,
                            border: Border.all()),
                        child: SvgPicture.asset(
                          IconConst.bag,
                          color: ColorConst.black,
                        ),
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          customTextField(
                              _nameController, t.translate("workplaceName")),
                        ],
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      children: [
                        customTextField(
                            _jobTitleController, t.translate("jobTitle")),
                        customTextField(
                            _locationController, t.translate("location")),
                      ],
                    ),
                  ),
                  SizedBox(height: 25.h),
                  Row(
                    children: [
                      Text(
                        t.translate("currentlyWorkHere"),
                        style: FontConst.font.w500().px16().c(ColorConst.dark),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isCurrentWorkplace = !_isCurrentWorkplace;
                          });
                        },
                        child: Container(
                          width: 21.w,
                          height: 21.h,
                          decoration: BoxDecoration(
                            color: _isCurrentWorkplace
                                ? ColorConst.secondary
                                : Colors.white,
                            borderRadius: BorderRadius.circular(4.r),
                            border: Border.all(
                              color: ColorConst.secondary,
                            ),
                          ),
                          child: _isCurrentWorkplace
                              ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 15.h,
                                )
                              : const SizedBox(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            const Divider(
              color: ColorConst.dviderColor,
              thickness: 1,
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.only(left: 32.w),
              child: Text(
                _isCurrentWorkplace
                    ? t.translate("since").toUpperCase()
                    : t.translate("from").toUpperCase(),
                style: FontConst.font.w500().px14().c(ColorConst.ligtGrey),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Row(
                children: [
                  customDatePicker(
                    (value) {
                      setState(() {
                        _initialFromYear = value.toString();
                      });
                    },
                    _initialFromYear,
                    _getYears(true),
                    width: 86.w,
                  ),
                  SizedBox(width: 10.w),
                  customDatePicker((value) {
                    setState(() {
                      _initialFromMonth = value.toString();
                    });
                  }, getInitialMonth(true), getMonths(true), width: 130.w),
                  SizedBox(width: 10.w),
                  customDatePicker(
                    (value) {
                      setState(() {
                        _initialFromDay = value.toString();
                      });
                    },
                    _getinitialDay(true),
                    _getDays(true),
                    width: 70.w,
                  ),
                ],
              ),
            ),
            if (!_isCurrentWorkplace)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.h),
                  const Divider(
                    color: ColorConst.dviderColor,
                    thickness: 1,
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.only(left: 32.w),
                    child: Text(
                      t.translate("to").toUpperCase(),
                      style:
                          FontConst.font.w500().px14().c(ColorConst.ligtGrey),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: Row(
                      children: [
                        customDatePicker(
                          (value) {
                            setState(() {
                              _initialToYear = value.toString();
                            });
                          },
                          _initialToYear,
                          _getYears(false),
                          width: 86.w,
                        ),
                        SizedBox(width: 10.w),
                        customDatePicker((value) {
                          setState(() {
                            _initialToMonth = value.toString();
                          });
                        }, getInitialMonth(false), getMonths(false),
                            width: 130.w),
                        SizedBox(width: 10.w),
                        customDatePicker(
                          (value) {
                            setState(() {
                              _initialToDay = value.toString();
                            });
                          },
                          _getinitialDay(false),
                          _getDays(false),
                          width: 70.w,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: mainButton(
                context,
                () => {
                  widget.workExperienceList.value.add(
                    WorkExperienceModel(
                      company: _nameController.text,
                      title: _jobTitleController.text,
                      location: _locationController.text,
                      currently_work_here: _isCurrentWorkplace,
                      start_date:
                          '$_initialFromDay $_initialFromMonth $_initialFromYear',
                      end_date:
                          '$_initialToDay $_initialToMonth $_initialToYear',
                    ).toJson(),
                  ),
                  widget.workExperienceList.notifyListeners(),
                  // widget.workExperienceList!.value

                  Navigator.of(context).pop(context)
                },
                t.translate("save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
