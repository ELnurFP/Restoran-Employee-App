// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:template/language/localization.dart';
import 'package:template/configs/base64_conventer.dart';
import '../../constants/constants.dart';
import '../../dependency_injection.dart';
import '../core/decoder.dart';
import '../core/icon_and_test.dart';
import '../main_page/entity/ad_entity.dart';
import '../registration/role_choser_page.dart';
import '../widgets/main_buton.dart';

enum EmployeeType { employee, accapted, canceled }

class GuestAdViewPage extends StatelessWidget {
  const GuestAdViewPage({Key? key, required this.adEntity}) : super(key: key);

  final AdEntity adEntity;

  GetIt get adViewButton => locator;

  Widget _header(BuildContext context, AppLocalizations t) {
    return Container(
      margin: EdgeInsets.only(
        left: 12.w,
        right: 22.w,
        top: 5,
        bottom: 14.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10.h),
                    width: 50.r,
                    height: 50.r,
                    decoration: const BoxDecoration(
                      color: ColorConst.purpleW100,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        adEntity.ownerType.isNotEmpty
                            ? Decoder.text(adEntity.ownerType)[0]
                            : "A",
                        style: FontConst.font.w600().px22().c(
                              ColorConst.purpleW500,
                            ),
                      ),
                    ),
                  ),
                  if (adEntity.isVip != '0')
                    Positioned(
                      top: -1.h,
                      right: 0,
                      left: 0,
                      child: SvgPicture.asset(
                        IconConst.crown,
                        width: 25.w,
                        color: const Color(0xFFDBA932),
                      ),
                    )
                ],
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Decoder.text(adEntity.workerType),
                    style: FontConst.font.w500().px16().c(
                          ColorConst.dark,
                        ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    Decoder.text(adEntity.ownerType),
                    style: FontConst.font.w400().px14().c(
                          ColorConst.lightDark,
                        ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            'ID #${adEntity.id}',
            style: FontConst.font.c(const Color(0xff929292)),
          )
        ],
      ),
    );
  }

  Widget _body(BuildContext context, AppLocalizations t) {
    return Column(
      children: [
        if (adEntity.views.isNotEmpty)
          IconAndText(
              IconConst.show,
              t.translate("viewed").replaceFirst("\$p", adEntity.views),
              Colors.orange),

        if (adEntity.attendees.isNotEmpty && adEntity.count.isNotEmpty)
          IconAndText(
            IconConst.done,
            "${adEntity.attendees} / ${adEntity.count}",
            // "${orderData.order!.attended_people ?? '0'} / ${orderData.order!.count}",
            // context.loc.applicantCounter
            //     .replaceAll("\$a", widget.adEntity.attendees)
            //     .replaceAll(
            //       "\$t",
            //       widget.adEntity.count,
            //     ),
            const Color(0xFF99DB71),
          ),
        if (adEntity.workDate.isNotEmpty)
          IconAndText(
            IconConst.calendar,
            '${t.translate('deadline')}  ${DateFormat("d MMMM, yyyy").format(DateTime.parse(adEntity.workDate))}',
            ColorConst.blue,
          ),
        if (adEntity.workHours.isNotEmpty)
          IconAndText(
            IconConst.time,
            adEntity.workHours.fromBase64,
            // context.loc.workHours
            //     .replaceAll("\$d", Decoder.text(widget.adEntity.workHours)),
            ColorConst.blue,
          ),
        if (adEntity.address.isNotEmpty)
          IconAndText(
            IconConst.location,
            Decoder.text(adEntity.address),
            ColorConst.orange,
          ),
        if (adEntity.gender.isNotEmpty)
          IconAndText(
            adEntity.gender == "0"
                ? IconConst.man
                : adEntity.gender == "1"
                    ? IconConst.woman
                    : IconConst.gender,
            adEntity.gender == "0"
                ? t.translate("male") // context.loc.male
                : adEntity.gender == "1"
                    ? t.translate("female") // context.loc.female
                    : t.translate("allGender"), //context.loc.allGender,
            ColorConst.blue,
          ),
        //
        SizedBox(
          height: 10.h,
        ),
        // SizedBox(
        //   height: 120.h,
        //   child: ClipRRect(
        //     borderRadius: BorderRadius.circular(15.r),
        //     child: GoogleMap(
        //       circles: {
        //         Circle(
        //           strokeColor: Colors.blue,
        //           fillColor: Colors.blue.withOpacity(0.3),
        //           circleId: CircleId(adEntity.address ?? ''),
        //           strokeWidth: 1,
        //           center: LatLng(double.tryParse(adEntity.!)!,
        //               double.tryParse(orderData.order!.lon!)!),
        //           radius: 10000,
        //         )
        //       },
        //       mapType: MapType.normal,
        //       zoomControlsEnabled: false,
        //       initialCameraPosition: CameraPosition(
        //         // bearing: 192.8334901395799,
        //         target: LatLng(double.tryParse(orderData.order!.lat!)!,
        //             double.tryParse(orderData.order!.lon!)!),
        //         // tilt: 59.440717697143555,
        //         zoom: 10,
        //       ),
        //       // markers: {
        //       //   Marker(
        //       //     markerId: const MarkerId(
        //       //       "position",
        //       //     ),
        //       //     position: LatLng(double.tryParse(orderData.order!.lat!)!,
        //       //         double.tryParse(orderData.order!.lon!)!),
        //       //   )
        //       // },
        //     ),
        //   ),
        // ),
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: EdgeInsets.all(
            10.r,
          ),
          child: Text(
            adEntity.description.fromBase64,
            style: FontConst.font.px12().w400().copyWith(height: 1.5),
          ),
        ),
        SizedBox(
          height: 40.h,
        ),
        registerButton(
          context,
          () => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const RoleChooserPage()),
                (route) => false)
          },
          t.translate("register"),
        ),
        SizedBox(
          height: 100.h,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations? t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // centerTitle: false,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop(context);
            //
          },
          child: Center(
            child: SvgPicture.asset(
              IconConst.back,
              height: 15.h,
              width: 15.h,
            ),
          ),
        ),
        title: Text(
          t!.translate("myAdvertisement"),
          // context.loc.myAdvertisement,
        ),
      ),
      body: SizedBox(
        height: 812.h,
        width: 375.w,
        child: ListView(
          children: [
            _header(
              context,
              t,
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: _body(context, t),
            ),
          ],
        ),
      ),
    );
  }
}
