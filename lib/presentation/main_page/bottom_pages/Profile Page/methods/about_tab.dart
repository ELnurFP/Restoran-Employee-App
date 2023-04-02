// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:template/language/localization.dart';
import 'package:template/presentation/main_page/bottom_pages/Profile%20Page/methods/place_lived.dart';

import '../../../../../constants/color_constant.dart';
import '../../../../../configs/base64_conventer.dart';

import '../../../../../constants/font_constant.dart';
import '../../../../../constants/icon_constant.dart';
import '../../../../../dependency_injection.dart';
import '../../../../../models/profile_info_res_model.dart';
import 'birthday_info.dart';
import 'gender_info.dart';
import 'other_workand_referances.dart';

Widget aboutTab(
  AppLocalizations t,
  String? gender,
  DateTime? birthday,
  String? placeLive,
  String? workExperience,
  String? referances,
  String? mapJson,
  String? latid,
  String? longid,
  List<WorkInRayza>? workInRayza, {
  bool isView = false,
}) {
  final Set<Marker> markers = {};
  final Set<Circle> circles = {};
  String lat = latid != null
      ? latid != 'null'
          ? latid != ''
              ? latid != '0'
                  ? latid
                  : '40.4'
              : '40.4'
          : '40.4'
      : '40.4';

  String lon = longid != null
      ? longid != 'null'
          ? longid != ''
              ? longid != '0'
                  ? longid
                  : '49.85'
              : '49.85'
          : '49.85'
      : '49.85';
  LatLng locallatLng = LatLng(double.parse(lat), double.parse(lon));
  isView
      ? null
      : markers.add(
          Marker(
            markerId: const MarkerId('1'),
            position: locallatLng,
            icon: BitmapDescriptor.defaultMarker,
          ),
        );
  isView
      ? circles.add(
          Circle(
            circleId: const CircleId('1'),
            strokeColor: Colors.blue,
            fillColor: Colors.blue.withOpacity(0.3),
            center: locallatLng,
            radius: 10000,
            strokeWidth: 1,
            // fillColor: ColorConst.primary.withOpacity(0.2),
          ),
        )
      : null;

  final isWorker = isView
      ? locator.get<GetStorage>().read('role') == 'Roles.Owner'
      : locator.get<GetStorage>().read('role') == 'Roles.Worker';

  return Padding(
    padding: EdgeInsets.only(left: 33.w, right: 26.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15.h),
        Text(
          t.translate("basicInfo"),
          style: FontConst.font
              .w600()
              .px16()
              .copyWith(color: ColorConst.secondary),
        ),
        SizedBox(height: 9.h),
        genderInfo(t, gender, birthday!.year != -1),
        SizedBox(height: 7.h),
        birthday.year == -1
            ? const SizedBox()
            : BirthdayInfo(birthday: birthday, t: t),
        Divider(
          color: ColorConst.dviderColor,
          height: 1.h,
        ),
        SizedBox(height: 12.h),
        if ((isWorker &&
                workExperience != null &&
                workExperience.isNotEmpty &&
                workExperience != '' &&
                json.decode(workExperience.fromBase64).isNotEmpty &&
                json.decode(workExperience.fromBase64)[0]['company'] != null &&
                json.decode(workExperience.fromBase64)[0]['title'] != null &&
                json
                    .decode(workExperience.fromBase64)[0]['company']
                    .toString()
                    .isNotEmpty &&
                json
                    .decode(workExperience.fromBase64)[0]['title']
                    .toString()
                    .isNotEmpty) ||
            (!isWorker &&
                mapJson != null &&
                mapJson.isNotEmpty &&
                mapJson != '' &&
                json.decode(mapJson.fromBase64).isNotEmpty &&
                json.decode(mapJson.fromBase64)[0]['place_name'] != null &&
                json.decode(mapJson.fromBase64)[0]['isMain'] != null &&
                json
                    .decode(mapJson.fromBase64)[0]['place_name']
                    .toString()
                    .isNotEmpty &&
                json
                    .decode(mapJson.fromBase64)[0]['isMain']
                    .toString()
                    .isNotEmpty))
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isWorker ? t.translate("work") : t.translate("places"),
                style: FontConst.font
                    .w600()
                    .px16()
                    .copyWith(color: ColorConst.secondary),
              ),
              SizedBox(height: 10.h),
              isWorker
                  ? workInRayza != null && workInRayza.isNotEmpty
                      ? Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: ColorConst.secondary,
                              radius: 12.5.r,
                              child: SvgPicture.asset(
                                IconConst.bag,
                                color: ColorConst.primary,
                                height: 12.5.r,
                                width: 12.5.r,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Text(t.translate("rayzaApp"),
                                style: FontConst.font.w600().px16())
                          ],
                        )
                      : const SizedBox()
                  : const SizedBox(),
              SizedBox(
                height: 10.h,
              ),
              isWorker
                  ? workInRayza != null && workInRayza.isNotEmpty
                      ? ListView.builder(
                          itemCount: workInRayza.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemBuilder: ((context, index) => Row(
                                children: [
                                  SizedBox(width: 10.w),
                                  WorkFieldWidget(
                                    title:
                                        workInRayza[index].workType != null &&
                                                workInRayza[index].workType! !=
                                                    'null' &&
                                                workInRayza[index]
                                                    .workType!
                                                    .isNotEmpty
                                            ? workInRayza[index]
                                                .workType!
                                                .fromBase64
                                            : '',
                                    subtitle: workInRayza[index].placeName !=
                                            null
                                        ? workInRayza[index].placeName != 'null'
                                            ? workInRayza[index]
                                                .placeName!
                                                .fromBase64
                                            : ''
                                        : '',
                                    isRayza: true,
                                    rayzaDate: workInRayza[index].createdAt ??
                                        DateTime.now(),
                                    isContinue: true,
                                  )
                                ],
                              )))
                      : const SizedBox()
                  : const SizedBox(),
              isWorker
                  ? workExperience != null && workExperience.isNotEmpty
                      ? Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: ColorConst.secondary,
                              radius: 12.5.r,
                              child: SvgPicture.asset(
                                IconConst.bag,
                                color: ColorConst.primary,
                                height: 12.5.r,
                                width: 12.5.r,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              t.translate("otherWork"),
                              style: FontConst.font
                                  .w600()
                                  .px16()
                                  .c(const Color(0xff3E8937)),
                            )
                          ],
                        )
                      : const SizedBox()
                  : const SizedBox(),
              isWorker
                  ? (workExperience != null &&
                          workExperience.isNotEmpty &&
                          json.decode(workExperience.fromBase64)[0]
                                  ['company'] !=
                              null &&
                          json.decode(workExperience.fromBase64)[0]['title'] !=
                              null)
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: workExperience != ''
                              ? json.decode(workExperience.fromBase64).length
                              : 0,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(left: 10.w),
                              child: SizedBox(
                                height: 60.h,
                                child: WorkFieldWidget(
                                  title:
                                      "${json.decode(workExperience.fromBase64)[index]['company']}",
                                  subtitle:
                                      "${json.decode(workExperience.fromBase64)[index]['title']}",
                                  startDate:
                                      "${json.decode(workExperience.fromBase64)[index]['start_date']}",
                                  endDate:
                                      "${json.decode(workExperience.fromBase64)[index]['end_date']}",
                                  isContinue:
                                      "${json.decode(workExperience.fromBase64)[index]['currently_work_here']}" ==
                                              'true'
                                          ? true
                                          : false,
                                ),
                              ),
                            );
                          })
                      : const SizedBox()
                  : mapJson != null && mapJson.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: mapJson != ''
                              ? json.decode(mapJson.fromBase64).length
                              : 0,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: ColorConst.secondary,
                                  radius: 12.5.r,
                                  child: SvgPicture.asset(
                                    IconConst.bag,
                                    color: ColorConst.primary,
                                    height: 12.5.r,
                                    width: 12.5.r,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                json.decode(mapJson.fromBase64)[index]
                                                ['place_name'] !=
                                            null &&
                                        json.decode(mapJson.fromBase64)[index]
                                                ['isMain'] !=
                                            null
                                    ? Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.h),
                                        child: Text(
                                          "${json.decode(mapJson.fromBase64)[index]['place_name']}",
                                          style: FontConst.font
                                              .w500()
                                              .px14()
                                              .copyWith(
                                                color: ColorConst.dark,
                                              ),
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            );
                          })
                      : const SizedBox(),
              SizedBox(height: 10.h),
              Divider(
                color: ColorConst.dviderColor,
                height: 1.h,
              ),
              SizedBox(height: 16.h),
            ],
          ),
        if (isWorker &&
            referances != null &&
            referances != '' &&
            json.decode(referances.fromBase64).isNotEmpty &&
            json.decode(referances.fromBase64)[0]['place'] != null &&
            json.decode(referances.fromBase64)[0]['phone'] != null &&
            json
                .decode(referances.fromBase64)[0]['place']
                .toString()
                .isNotEmpty &&
            json
                .decode(referances.fromBase64)[0]['phone']
                .toString()
                .isNotEmpty)
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: ColorConst.secondary,
                    radius: 12.5.r,
                    child: SvgPicture.asset(
                      IconConst.bag,
                      color: ColorConst.primary,
                      height: 12.5.r,
                      width: 12.5.r,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  SizedBox(
                    width: 280.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.translate("referance"),
                          style: FontConst.font.w600().px14().copyWith(
                                color: ColorConst.secondary,
                              ),
                        ),
                        OtherWorkAndReferencesWidget(
                          title: json.decode(referances.fromBase64)[0]['place'],
                          subtitle: json.decode(referances.fromBase64)[0]
                              ['phone'],
                          t: t,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                color: ColorConst.dviderColor,
                height: 1.h,
              )
            ],
          ),
        SizedBox(height: 5.h),
        isWorker
            ? Text(
                t.translate("placeLived"),
                style: FontConst.font
                    .w600()
                    .px16()
                    .copyWith(color: ColorConst.secondary),
              )
            : const SizedBox.shrink(),
        SizedBox(height: 10.h),
        isWorker
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: ColorConst.secondary,
                    radius: 12.5.r,
                    child: SvgPicture.asset(
                      IconConst.location,
                      color: ColorConst.primary,
                      height: 12.5.r,
                      width: 12.5.r,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  placeLive != null
                      ? placeLived(placeLive.fromBase64, t)
                      : Container(),
                ],
              )
            : const SizedBox.shrink(),
        isWorker
            ? SizedBox(
                height: 10.h,
              )
            : const SizedBox(),
        isWorker
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: SizedBox(
                  height: 200.h,
                  child: GoogleMap(
                    zoomGesturesEnabled: true,
                    // max
                    // onMapCreated: (GoogleMapController ctrl) {
                    //   controller = ctrl;
                    // },

                    // onTap: (LatLng latLng) {
                    //   _markers.add(Marker(
                    //       markerId: const MarkerId('1'),
                    //       position: latLng));
                    //   setState(() {
                    //     locallatLng = latLng;
                    //   });
                    // },
                    markers: Set<Marker>.of(markers),
                    circles: Set<Circle>.of(circles),
                    mapType: MapType.normal,
                    zoomControlsEnabled: false,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(double.parse(lat), double.parse(lon)),
                      zoom: 10,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        SizedBox(height: 20.h),
      ],
    ),
  );
}
