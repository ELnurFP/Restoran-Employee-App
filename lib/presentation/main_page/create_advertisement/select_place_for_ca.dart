// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:template/constants/constants.dart';
import 'package:template/language/localization.dart';
import 'package:template/presentation/widgets/search_map.dart';
import 'package:template/presentation/widgets/main_buton.dart';

class SelectPlaceForCA extends StatefulWidget {
  const SelectPlaceForCA({super.key, required this.mapList});

  final ValueNotifier mapList;

  @override
  State<SelectPlaceForCA> createState() => _SelectPlaceForCAState();
}

class _SelectPlaceForCAState extends State<SelectPlaceForCA> {
  late GoogleMapController controller;
  LatLng? locallatLng;
  final TextEditingController searchController = TextEditingController();

  final Set<Marker> _markers = {};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AppLocalizations? t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          t!.translate("map"),
          style: FontConst.font.px18().w600(),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20.h),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: SearchMapWidget(controller: searchController, t: t),
              ),
              SizedBox(height: 15.h),
              Text(
                t.translate('selectLocation'),
                style: FontConst.font
                    .px12()
                    .w500()
                    .copyWith(color: ColorConst.softTextColor),
              ),
              SizedBox(height: 15.h),
              SizedBox(
                height: 336.h,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: GoogleMap(
                      zoomGesturesEnabled: true,
                      onMapCreated: (GoogleMapController ctrl) {
                        controller = ctrl;
                      },
                      onTap: (LatLng latLng) {
                        _markers.add(Marker(
                            markerId: const MarkerId('mark'),
                            position: latLng));
                        setState(() {
                          locallatLng = latLng;
                        });
                      },
                      markers: Set<Marker>.of(_markers),
                      mapType: MapType.normal,
                      zoomControlsEnabled: false,
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(40.4, 49.84),
                        zoom: 10,
                      )),
                ),
              ),
              SizedBox(height: 15.h),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: mainButton(context, () {
                    if (_formKey.currentState!.validate()) {
                      if (locallatLng != null) {
                        setState(() {
                          List localMapList = [
                            searchController.text,
                            locallatLng!.latitude.toString(),
                            locallatLng!.longitude.toString(),
                          ];
                          widget.mapList.value = localMapList;
                        });
                        widget.mapList.notifyListeners();
                        Navigator.of(context).pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(t.translate("selectFromMap")),
                          behavior: SnackBarBehavior.floating,
                        ));
                      }
                    }
                  }, t.translate('save')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
