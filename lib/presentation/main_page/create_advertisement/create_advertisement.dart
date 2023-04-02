// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:template/configs/base64_conventer.dart';
import 'package:template/constants/constants.dart';
import 'package:template/dependency_injection.dart';
import 'package:template/language/localization.dart';
import 'package:template/models/get_user_status_type_res_model.dart';
import 'package:template/presentation/main_page/create_advertisement/select_place_for_ca.dart';
import 'package:template/presentation/widgets/custom_appbar.dart';
import 'package:template/presentation/widgets/custom_checkbox_field.dart';
import 'package:template/presentation/widgets/custom_dropdownformfield.dart';
import 'package:template/presentation/widgets/custom_text_field.dart';
import 'package:template/presentation/widgets/main_buton.dart';

import '../../../cubit/general_cubit.dart';
import '../../../cubit/general_state.dart';
import '../../../infrastructure/remote/create_order_service.dart';
import '../../../infrastructure/remote/get_user_status_types_service.dart';
import '../../../models/create_order_req_model.dart';
import '../../../models/get_user_status_req_model.dart';
import 'custom_age_range_chooser.dart';
import 'preview_advertisement.dart';

class CreateAdvertisement extends StatefulWidget {
  const CreateAdvertisement({super.key});

  @override
  State<CreateAdvertisement> createState() => _CreateAdvertisementState();
}

class _CreateAdvertisementState extends State<CreateAdvertisement> {
  String? ageRange = "18-25";
  String? category;
  String? category_id;
  TextEditingController description = TextEditingController();
  String gender = '2';
  String? hours;
  TextEditingController hoursController = TextEditingController();
  DateTime? initialDate;
  final ValueNotifier<List> mapList = ValueNotifier<List>([]);
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(7.r),
    borderSide: const BorderSide(
      color: ColorConst.disabledColor,
    ),
  );

  String? submitdate;
  TextEditingController workerNumber = TextEditingController();

  final ValueNotifier<String> _dateController = ValueNotifier<String>('');
  final ValueNotifier<bool> _isChecked = ValueNotifier<bool>(false);

  @override
  void initState() {
    initialDate = DateTime.now().add(const Duration(days: 2));

    submitdate = initialDate!.toString();
    _dateController.value =
        DateFormat('dd-MMM-yyyy - HH:mm').format(initialDate!).toString();

    ageRange = "18-25";
    category = null;
    category_id = null;
    description.clear();
    gender = '2';
    hours = '';
    hoursController.clear();

    workerNumber.clear();

    _isChecked.value = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations t = AppLocalizations.of(context)!;
    List genders = [
      t.translate("male"),
      t.translate("female"),
      t.translate("allGender")
    ];
    List locationList = [];
    try {
      locationList = (locator.get<GetStorage>().read('map') != null &&
              locator.get<GetStorage>().read('map') != 'null' &&
              locator.get<GetStorage>().read('map') != '' &&
              locator.get<GetStorage>().read('map') != "" &&
              locator.get<GetStorage>().read('map').isNotEmpty)
          ? json.decode(locator.get<GetStorage>().read('map'))
          : [];
    } catch (e) {
      locationList = [];
    }
    List ageRangeList = ["18-25", "25-35", t.translate("custom")];
    try {
      if (locator.get<GetStorage>().hasData("customAgeRanges")) {
        if (locator
            .get<GetStorage>()
            .read("customAgeRanges")
            .toString()
            .isNotEmpty) {
          List customAges = locator
              .get<GetStorage>()
              .read("customAgeRanges")
              .toString()
              .split(",");
          for (int i = 0; i < customAges.length; i++) {
            ageRangeList.insert(
                ageRangeList.length - 1, customAges[i].toString().trim());
          }
        }
      }
    } catch (e) {
      ageRangeList = ["18-25", "25-35", t.translate("custom")];
    }

    //print(locationList);
    // ageRangeList.add(t.translate("custom"));
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            customAppBar(context, t.translate("createAd")),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      BlocBuilder<
                          GeneralCubit<GetUsesStatusTypeService,
                              GetUserStatusTypeReqModel>,
                          GeneralState>(builder: (context, state) {
                        if (state is GeneralSuccess) {
                          var list = (state.data as GetUserStatusTypeResModel)
                              .types!
                              .map<String>((e) => e.name!.fromBase64)
                              .toList();

                          return customDropDownFormField(
                            list,
                            hint: t.translate("category"),
                            onChanged: (value) {
                              category = value;
                              category_id =
                                  (state.data as GetUserStatusTypeResModel)
                                      .types![list.indexOf(value!)]
                                      .id;
                            },
                          );
                        } else {
                          return customDropDownFormField(
                            [],
                            hint: t.translate("category"),
                            onChanged: (value) {
                              category = value;
                            },
                          );
                        }
                      }),
                      SizedBox(width: 10.w),
                      Expanded(
                          child: customTextFiled(
                        t.translate("workersNumber"),
                        workerNumber,
                        (value) {},
                        radius: 7,
                        keyboardType: TextInputType.number,
                        verticalPadding: 11.5,
                      )),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      customDropDownFormField(
                        genders,
                        hint: t.translate("gender"),
                        initialValue: genders[2],
                        onChanged: (value) {
                          gender = genders.indexOf(value!).toString();
                        },
                      ),
                      SizedBox(width: 10.w),
                      customDropDownFormField(
                        ageRangeList,
                        fillColor: Colors.white,
                        initialValue: ageRange,
                        onChanged: (value) {
                          if (value == t.translate("custom")) {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => CustomAgeRangeDialog(
                                onSave: (newAgeRange) {
                                  setState(() {
                                    if (ageRange != newAgeRange) {
                                      setState(() {
                                        ageRange = newAgeRange;
                                      });
                                    } else {
                                      return;
                                    }
                                  });
                                },
                              ),
                            );
                          } else {
                            setState(() {
                              ageRange = value;
                            });
                          }
                        },
                        t: t,
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  GestureDetector(
                    onTap: () {
                      return DatePicker.showDatePicker(
                        context,
                        dateFormat: 'dd MMMM yyyy HH:mm',
                        initialDateTime: initialDate,
                        minDateTime: DateTime.now().add(
                          const Duration(days: 1),
                        ),
                        maxDateTime:
                            DateTime.now().add(const Duration(days: 366)),
                        onMonthChangeStartWithFirstDate: true,
                        onConfirm: (dateTime, List<int> index) {
                          DateTime selectdate = dateTime;
                          final selIOS = DateFormat('dd-MMM-yyyy - HH:mm')
                              .format(selectdate);
                          _dateController.value = selIOS;
                          submitdate = selectdate.toString();
                        },
                      );
                    },
                    child: ValueListenableBuilder(
                        valueListenable: _dateController,
                        builder: (context, value, child) {
                          return Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.r),
                                border: Border.all(
                                  color: const Color(0xffACACAC),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 13.w,
                                vertical: 12.h,
                              ),
                              child: Text(value));
                        }),
                  ),
                  SizedBox(height: 15.h),
                  ValueListenableBuilder(
                    valueListenable: _isChecked,
                    builder: (context, value, child) {
                      return CustomCheckboxField(
                        red: false,
                        title: t.translate("permanentJob"),
                        value: _isChecked.value,
                        onTap: () {
                          _isChecked.value = !_isChecked.value;
                        },
                      );
                    },
                  ),
                  SizedBox(height: 15.h),
                  customTextFiled(
                    t.translate("workTime"),
                    hoursController,
                    (value) {
                      hours = value;
                    },
                    radius: 7,
                    verticalPadding: 11.5,
                  ),
                  SizedBox(height: 15.h),

                  //location button
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text(t.translate('selectLoc')),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r)),
                                content: SizedBox(
                                  height: 300.h,
                                  width: 300.w,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      locationList.isNotEmpty
                                          ? ListView.separated(
                                              itemCount: locationList.length,
                                              shrinkWrap: true,
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const Divider(),
                                              itemBuilder: (context, index) =>
                                                  InkWell(
                                                    onTap: () {
                                                      mapList.value = [];

                                                      mapList.value = [
                                                        locationList[index]
                                                            ['place_name'],
                                                      ];
                                                      mapList.value.add(
                                                          locationList[index]
                                                              ['lat']);

                                                      mapList.value.add(
                                                          locationList[index]
                                                              ['lon']);

                                                      Navigator.of(context)
                                                          .pop(context);
                                                    },
                                                    child: Text(
                                                        locationList[index]
                                                            ['place_name']),
                                                  ))
                                          : Text(t.translate('empty')),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(context);
                                            },
                                            child: Text(t.translate('cancel')),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              mapList.value = [];
                                              Navigator.of(context)
                                                  .pop(context);
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SelectPlaceForCA(
                                                          mapList: mapList),
                                                ),
                                              );
                                            },
                                            child: Text(t.translate('fromMap')),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ));

                      // Navigator.of(context).push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         SelectPlaceForCA(mapList: mapList),
                      //   ),
                      // );
                    },
                    child: ValueListenableBuilder(
                      valueListenable: mapList,
                      builder: (context, value, _) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.r),
                          border: Border.all(
                            color: const Color(0xffACACAC),
                          ),
                          color: const Color(0xffF1F1F1),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 13.w, vertical: 12.h),
                        child: Row(
                          children: [
                            Text(
                              value.isNotEmpty
                                  ? value[0]
                                  : t.translate("enterLoc"),
                              style: FontConst.font.w400().px14().copyWith(
                                    color: const Color(0xff949494),
                                  ),
                            ),
                            const Spacer(),
                            Image.asset(ImageConst.map, height: 23.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  customTextFiled(
                    t.translate("description"),
                    description,
                    (value) {
                      //description = value;
                    },
                    radius: 7,
                    maxLines: 5,
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: mainButton(context, () {
                      if (category != null &&
                          category_id != null &&
                          submitdate != null &&
                          mapList.value.isNotEmpty &&
                          description.text.isNotEmpty &&
                          ageRange != null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => GeneralCubit<
                                  CreateOrderService, CreateOrderReqModel>()
                                ..generalRequest(
                                  CreateOrderReqModel(
                                      address: mapList.value[0],
                                      age_from: int.tryParse(ageRange != null
                                          ? ageRange!.split('-').first
                                          : ''),
                                      age_to: int.tryParse(ageRange != null
                                          ? ageRange!.split('-').last
                                          : ''),
                                      count: workerNumber.text,
                                      description: description.text,
                                      gender: gender,
                                      is_perminent: _isChecked.value ? 1 : 0,
                                      lat: mapList.value[1],
                                      lon: mapList.value[2],
                                      work_date: submitdate,
                                      work_hours: hoursController.text,
                                      worker_id: category_id),
                                ),
                              child: PreviewAdvertisementPage(
                                category: category,
                                model: CreateOrderReqModel(
                                    address: mapList.value[0],
                                    age_from: int.tryParse(ageRange != null
                                        ? ageRange!.split('-').first
                                        : ''),
                                    age_to: int.tryParse(ageRange != null
                                        ? ageRange!.split('-').last
                                        : ''),
                                    count: workerNumber.text,
                                    description: description.text.isNotEmpty
                                        ? description.text
                                        : '',
                                    gender: gender,
                                    is_perminent: _isChecked.value ? 1 : 0,
                                    lat: mapList.value[1],
                                    lon: mapList.value[2],
                                    work_date: submitdate,
                                    work_hours: hoursController.text,
                                    worker_id: category_id),
                              ),
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(t.translate("plsFill")),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    }, "Next"),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
