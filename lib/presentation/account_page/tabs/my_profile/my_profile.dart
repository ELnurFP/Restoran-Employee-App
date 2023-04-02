// ignore_for_file: use_build_context_synchronously, prefer_contains, deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:template/constants/constants.dart';
import 'package:template/cubit/general_state.dart';
import 'package:template/infrastructure/remote/profile_update_service.dart';
import 'package:template/language/localization.dart';
import 'package:template/models/profile_update_req_model.dart';
import 'package:template/models/status_model.dart';
import 'package:template/models/work_experience_model.dart';
import 'package:template/presentation/widgets/main_buton.dart';
import 'package:template/configs/base64_conventer.dart';
import '../../../../cubit/general_cubit.dart';
import '../../../../dependency_injection.dart';
import '../../../../infrastructure/remote/buy_premium_service.dart';
import '../../../../infrastructure/remote/premium_service.dart';
import '../../../../infrastructure/remote/profile_info_service.dart';
import '../../../../infrastructure/remote/profile_update_image_service.dart';
import '../../../../models/buy_premium_req_model.dart';
import '../../../../models/general_req_model.dart';
import '../../../../models/map_place_model.dart';
import '../../../../models/profile_info_res_model.dart';
import '../../../../models/profile_update_image_req_model.dart';
import '../../../main_page/main_page.dart';
import '../../../widgets/get_premium.dart';
import '../premium_page/premium_page.dart';
import 'add_workplace.dart';
import 'methods/map_button.dart';
import 'methods/open_image_picker.dart';
import 'methods/places_card.dart';
import 'methods/profile_content_title.dart';
import 'methods/profile_imput_field.dart';
import 'methods/select_place.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage(
      {super.key, this.profileInfoResModel, this.fromMain = false});

  final bool fromMain;
  final ProfileInfoResModel? profileInfoResModel;

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  TextEditingController addressController = TextEditingController();
  List<UserStatue>? allUserStatuses = [];
  ValueNotifier<File?> backImage = ValueNotifier(null);
  final ValueNotifier<DateTime> birtController =
      ValueNotifier<DateTime>(DateTime.now());

  final ValueNotifier<TextEditingController> birtControllerF =
      ValueNotifier<TextEditingController>(TextEditingController());

  late DateTime birthHint;
  TextEditingController businessController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  late GoogleMapController controller;
  TextEditingController emailController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  String? gender = '';
  TextEditingController genderController = TextEditingController();
  ValueNotifier<File?> image = ValueNotifier(null);
  String? initialID = '';
  String? initialStatus = '';
  late String jobStatus;
  String? lat = '0';
  LatLng? locallatLng;
  String? lon = '0';
  final ValueNotifier<List<MapPlacesModel>> mainMapList =
      ValueNotifier<List<MapPlacesModel>>([]);

  String mainplace = '';
  final ValueNotifier<List> mapList = ValueNotifier<List>([]);
  TextEditingController nameController = TextEditingController(text: 'John');
  final ValueNotifier<List<MapPlacesModel>> otherMapList =
      ValueNotifier<List<MapPlacesModel>>([]);

  List otherPlaces = [];
  final ValueNotifier<List<Map<String, dynamic>>> otherWorks =
      ValueNotifier<List<Map<String, dynamic>>>([]);

  TextEditingController phoneController = TextEditingController();
  List<MapPlacesModel> places = [];
  final List<Map<String, dynamic>> referance = [];
  TextEditingController referanceName = TextEditingController();
  TextEditingController referancePhone = TextEditingController();
  final role = locator.get<GetStorage>().read('role');
  String sendedJobStatus = '';
  String? statusName;
  List<UserStatue> statuses = [];
  TextEditingController surNameController = TextEditingController();
  String typeUser =
      locator.get<GetStorage>().read('role') == 'Roles.Worker' ? '1' : '0';

  List workList = [];

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();

    businessController.text =
        widget.profileInfoResModel!.thisUser!.userTypeStatus!.isNotEmpty &&
                widget.profileInfoResModel!.thisUser!.placeName != 'null'
            ? widget.profileInfoResModel!.thisUser!.placeName!.fromBase64
            : '';
    businessNameController.text =
        widget.profileInfoResModel!.thisUser!.placeName!.isNotEmpty &&
                widget.profileInfoResModel!.thisUser!.placeName != 'null'
            ? widget.profileInfoResModel!.thisUser!.placeName!.fromBase64
            : '';
    addressController.text =
        widget.profileInfoResModel!.thisUser!.address!.fromBase64;
    lat = widget.profileInfoResModel!.thisUser!.lat != null
        ? widget.profileInfoResModel!.thisUser!.lat != 'null'
            ? widget.profileInfoResModel!.thisUser!.lat != ''
                ? widget.profileInfoResModel!.thisUser!.lat != '0'
                    ? widget.profileInfoResModel!.thisUser!.lat!
                    : '40.4'
                : '40.4'
            : '40.4'
        : '40.4';

    lon = widget.profileInfoResModel!.thisUser!.lon != null
        ? widget.profileInfoResModel!.thisUser!.lon != 'null'
            ? widget.profileInfoResModel!.thisUser!.lon != ''
                ? widget.profileInfoResModel!.thisUser!.lon != '0'
                    ? widget.profileInfoResModel!.thisUser!.lon!
                    : '49.85'
                : '49.85'
            : '49.85'
        : '49.85';
    locallatLng = LatLng(double.parse(lat!), double.parse(lon!));
    _markers.add(
      Marker(
        markerId: const MarkerId('1'),
        position: locallatLng!,
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    birtController.value = widget.profileInfoResModel!.thisUser!.birthday!;
    places = widget.profileInfoResModel!.thisUser!.mapsJson == ''
        ? []
        : json
            .decode(widget.profileInfoResModel!.thisUser!.mapsJson!.fromBase64)
            .map<MapPlacesModel>((e) => MapPlacesModel.fromJson(e))
            .toList();

    otherMapList.value =
        places.where((element) => element.isMain == '0').isNotEmpty
            ? places.where((element) => element.isMain == '0').toList()
            : [];
    mainMapList.value =
        places.where((element) => element.isMain == '1').isNotEmpty
            ? places.where((element) => element.isMain == '1').toList()
            : [];
    workList = widget.profileInfoResModel!.thisUser!.workExperienceJson! == ''
        ? []
        : json.decode(widget
            .profileInfoResModel!.thisUser!.workExperienceJson!.fromBase64);

    for (int i = 0; i < workList.length; i++) {
      otherWorks.value.add(workList[i]);
    }
    referancePhone = TextEditingController(
        text: widget.profileInfoResModel!.thisUser!.referancesJson! == ''
            ? ''
            : json
                .decode(widget
                    .profileInfoResModel!.thisUser!.referancesJson!.fromBase64)
                .first['phone']);
    referanceName = TextEditingController(
        text: widget.profileInfoResModel!.thisUser!.referancesJson! == ''
            ? ''
            : json
                .decode(widget
                    .profileInfoResModel!.thisUser!.referancesJson!.fromBase64)
                .first['place']);

    // print('${mapList} mapList');

    // workList = json.decode(
    //     widget.profileInfoResModel!.thisUser!.workExperienceJson!.fromBase64);
    nameController = TextEditingController(
        text: widget.profileInfoResModel!.thisUser!.personName!.fromBase64);

    surNameController = TextEditingController(
        text: widget.profileInfoResModel!.thisUser!.personSurname!.fromBase64);

    fatherNameController = TextEditingController(
        text:
            widget.profileInfoResModel!.thisUser!.personFatherName!.fromBase64);

    birthHint = widget.profileInfoResModel!.thisUser!.birthday!;
    print('birthHintT ${birthHint.year}');
    emailController = TextEditingController(
        text: widget.profileInfoResModel!.thisUser!.email);
    phoneController = TextEditingController(
        text: widget.profileInfoResModel!.thisUser!.number!);

    mainplace = widget.profileInfoResModel!.thisUser!.address!.fromBase64;
    // otherPlaces = selectedMap.value;
    gender = birtController.value.year.toString() == '-1'
        ? ''
        : widget.profileInfoResModel!.thisUser!.gender;

    print('gender $gender');
    //status here
    allUserStatuses = widget.profileInfoResModel!.userStatues;

    for (var i in allUserStatuses!) {
      if (i.name != '' && i.type == typeUser) {
        statuses.add(i);
      }
    }

    jobStatus = widget.profileInfoResModel!.thisUser!.userTypeStatus ?? '0';

    initialStatus = allUserStatuses!.firstWhere((element) {
              return element.id == jobStatus;
            }).name !=
            null
        ? allUserStatuses!
            .firstWhere((element) {
              return element.id == jobStatus;
            })
            .name!
            .fromBase64
        : allUserStatuses![0].id;
  }

  Widget imageChange(BuildContext context, String role, AppLocalizations t) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            ValueListenableBuilder<File?>(
                valueListenable: backImage,
                builder: (context, value, child) {
                  return Container(
                    alignment: Alignment.topCenter,
                    width: double.infinity,
                    height: 170.h,
                    padding: EdgeInsets.symmetric(vertical: 35.h),
                    decoration: BoxDecoration(
                        // color: Colors.orange,
                        image: backImage.value != null
                            ? DecorationImage(
                                image: MemoryImage(
                                    backImage.value!.readAsBytesSync()),
                                fit: BoxFit.cover,
                              )
                            : widget.profileInfoResModel!.thisUser!
                                            .backImg ==
                                        null ||
                                    widget.profileInfoResModel!.thisUser!
                                            .backImg ==
                                        '' ||
                                    widget.profileInfoResModel!.thisUser!
                                            .backImg ==
                                        'null'
                                ? const DecorationImage(
                                    image: AssetImage(ImageConst.phBack),
                                    fit: BoxFit.cover,
                                  )
                                : DecorationImage(
                                    image: NetworkImage(
                                        'https://rayza.az/${widget.profileInfoResModel!.thisUser!.backImg!}'),
                                    fit: BoxFit.cover,
                                  )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        !widget.fromMain
                            ? IconButton(
                                icon: Icon(Icons.arrow_back_ios, size: 20.h),
                                onPressed: () => Navigator.of(context).pop(),
                              )
                            : SizedBox(
                                width: 20.h,
                                height: 20.h,
                              ),
                        IconButton(
                          icon: SvgPicture.asset(
                            IconConst.upload,
                            height: 20.h,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                context: context,
                                builder: ((context) => openImagePicker(
                                    false, backImage, image, t)));
                          },
                        ),
                      ],
                    ),
                  );
                }),
            Container(
              height: 110.h,
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    t.translate("changePfp"),
                    style: FontConst.font.w500().px16().copyWith(
                          color: const Color(0xFF8F8F8F),
                        ),
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.r),
                              topRight: Radius.circular(20.r),
                            ),
                          ),
                          context: context,
                          builder: ((context) =>
                              openImagePicker(true, backImage, image, t)));
                    },
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.zero,
                    icon: SvgPicture.asset(
                      IconConst.editName,
                      height: 15.h,
                    ),
                  )
                ],
              ),
            ),
            if (role == 'Roles.Worker')
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 10.h),
                child:
                    //premium date

                    widget.profileInfoResModel!.thisUser!.peremiumAccountDate ==
                            '0000-00-00'
                        ? premiumButton(() {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return MultiBlocProvider(providers: [
                                  BlocProvider<
                                      GeneralCubit<PremiumService,
                                          GeneralInfoReqModel>>(
                                    create: (context) => GeneralCubit<
                                        PremiumService, GeneralInfoReqModel>()
                                      ..generalRequest(GeneralInfoReqModel()),
                                  ),
                                  BlocProvider<
                                          GeneralCubit<BuyPremiumService,
                                              BuyPremiumReqModel>>(
                                      create: (context) => GeneralCubit<
                                          BuyPremiumService,
                                          BuyPremiumReqModel>()),
                                ], child: const PremiumPage());
                              },
                            )).then((value) async {
                              await context
                                  .read<
                                      GeneralCubit<ProfileInfoService,
                                          GeneralInfoReqModel>>()
                                  .generalRequest(GeneralInfoReqModel());
                            });
                          }, t.translate("getPremium"))
                        : premiumButton(
                            () => null,
                            widget.profileInfoResModel!.thisUser!
                                .peremiumAccountDate!),
              )
          ],
        ),
        ValueListenableBuilder<File?>(
            valueListenable: image,
            builder: (context, value, child) {
              return Positioned(
                bottom: role == 'Roles.Worker' ? 105.h : 42.h,
                child: Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Container(
                      height: 118.w,
                      width: 118.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        // color: Colors.orange,
                        // image: image.value != null
                        //     ? DecorationImage(
                        //         image: MemoryImage(
                        //             image.value!.readAsBytesSync()),
                        //         fit: BoxFit.cover)
                        //     : (widget.profileInfoResModel?.thisUser
                        //                     ?.img) ==
                        //                 null ||
                        //             (widget.profileInfoResModel?.thisUser
                        //                     ?.img) ==
                        //                 '' ||
                        //             (widget.profileInfoResModel?.thisUser
                        //                     ?.img) ==
                        //                 'null'
                        //         ? const DecorationImage(
                        //             image: AssetImage(ImageConst.ph),
                        //             fit: BoxFit.cover)
                        //         : DecorationImage(
                        //             image: NetworkImage(
                        //               'https://rayza.az/${widget.profileInfoResModel!.thisUser!.img!}',
                        //             ),
                        //             fit: BoxFit.cover)
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.r),
                        child: image.value != null
                            ? Image.memory(
                                image.value!.readAsBytesSync(),
                                fit: BoxFit.fill,
                              )
                            : (widget.profileInfoResModel?.thisUser?.img) ==
                                        null ||
                                    (widget.profileInfoResModel?.thisUser
                                            ?.img) ==
                                        '' ||
                                    (widget.profileInfoResModel?.thisUser
                                            ?.img) ==
                                        'null'
                                ? Image.asset(ImageConst.ph1, fit: BoxFit.fill)
                                : Image.network(
                                    'https://rayza.az/${widget.profileInfoResModel!.thisUser!.img!}',
                                    fit: BoxFit.fill, frameBuilder: (context,
                                        child, frame, wasSynchronouslyLoaded) {
                                    if (wasSynchronouslyLoaded) {
                                      return child;
                                    }
                                    return AnimatedOpacity(
                                      opacity: frame == null ? 0 : 1,
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.easeOut,
                                      child: child,
                                    );
                                  }, loadingBuilder:
                                        (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: ColorConst.secondary,
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  }, errorBuilder:
                                        (context, error, stackTrace) {
                                    return Image.asset(ImageConst.ph,
                                        fit: BoxFit.fill);
                                  }),
                      )),
                ),
              );
            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print('birthhh ${birtController.value.year.toString()}');
    AppLocalizations t = AppLocalizations.of(context)!;
    List genders = [
      t.translate("male"),
      t.translate("female"),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
          width: double.infinity,
          height: 812.h,
          child: SingleChildScrollView(
            child: Column(
              children: [
                imageChange(context, role, t),
                Divider(color: ColorConst.dviderColor, height: 1.h),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    children: [
                      profileContentTitle(
                        t.translate("basicInfo"),
                        IconConst.accountPerson,
                      ),
                      SizedBox(height: 15.h),
                      ProfileInputField(
                        title: t.translate("name"),
                        t: t,
                        controller: nameController,
                        hintText: t.translate("enterName"),
                      ),
                      SizedBox(height: 15.h),
                      ProfileInputField(
                        title: t.translate("surName"),
                        t: t,
                        hintText: t.translate("enterSurName"),
                        controller: surNameController,
                      ),
                      SizedBox(height: 15.h),
                      ProfileInputField(
                        title: t.translate("fatherName"),
                        t: t,
                        hintText: t.translate("enterFatherName"),
                        controller: fatherNameController,
                      ),
                      SizedBox(height: 15.h),
                      ProfileInputField(
                          title: t.translate("gender"),
                          hintText: t.translate("chooseGender"),
                          t: t,
                          controller: genderController,
                          isDropDown: true,
                          items: genders,
                          initialValue:
                              gender == '' ? null : genders[int.parse(gender!)],
                          onChanged: (v) {
                            setState(() {
                              gender = genders.indexOf(v).toString();
                            });
                          }),
                      SizedBox(height: 15.h),
                      //birthhhh
                      ValueListenableBuilder(
                        valueListenable: birtController,
                        builder: (context, value, child) {
                          return ProfileInputField(
                            title: t.translate("birthDay"),
                            t: t,
                            controller: birtControllerF.value,
                            isReadOnly: true,
                            hintText: birtController.value.year == -1
                                ? '__-__-____'
                                : '${birthHint.day}-${birthHint.month}-${birthHint.year}',
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now().subtract(
                                  const Duration(days: 18 * 365),
                                ),
                                firstDate: DateTime(
                                    1920), //TODO: first date-i deyis lazm olsa
                                lastDate: DateTime.now().subtract(
                                  const Duration(days: 18 * 365),
                                ),
                              );
                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('dd-MM-yyyy').format(pickedDate);
                                birtControllerF.value.text = formattedDate;
                                birtController.value = pickedDate;
                              }
                            },
                          );
                        },
                      ),
                      SizedBox(height: 15.h),
                      role == 'Roles.Worker'
                          ? ProfileInputField(
                              title: t.translate("jobStatus"),
                              t: t,
                              isDropDown: true,
                              items: statuses
                                  .map<String>((e) => e.name!.fromBase64)
                                  .toList(),
                              initialValue:
                                  statuses
                                              .map<String>((e) => e.id!)
                                              .toList()
                                              .indexOf(jobStatus) >=
                                          0
                                      ? statuses
                                              .map<String>(
                                                  (e) => e.name!.fromBase64)
                                              .toList()[
                                          statuses
                                              .map<String>((e) => e.id!)
                                              .toList()
                                              .indexOf(jobStatus)]
                                      : null,
                              onChanged: (v) {
                                setState(() {
                                  jobStatus = statuses
                                      .map<String>((e) => e.id!)
                                      .toList()[(statuses
                                          .map<String>(
                                              (e) => e.name!.fromBase64)
                                          .toList()
                                          .indexOf(v.toString()))]
                                      .toString();
                                });
                              },
                              // items: allUserStatuses!.map((e) => e.name).toList(),
                              // initialValue:(widget.profileInfoResModel?.thisUser?.userTypeStatus)!=null&&widget.profileInfoResModel!.thisUser!.userTypeStatus!='null'&&widget.profileInfoResModel!.thisUser!.userTypeStatus!=''&&widget.profileInfoResModel!.thisUser!.userTypeStatus!.isNotEmpty?
                              // allUserStatuses!.firstWhere((element) => element.name! == widget.profileInfoResModel!.thisUser!.userTypeStatus!).name!:''
                              // ,
                              // onChanged: (v) {
                              //   setState(() {
                              //     jobStatus = allUserStatuses!.firstWhere((element) => v== element.name! ).id!;
                              //   });
                              // },
                            )
                          //owner biznes novu
                          : Column(children: [
                              ProfileInputField(
                                title: t.translate("businessName"),
                                t: t,
                                controller: businessNameController,
                                //  jobStatuses: widget.profileInfoResModel!.userStatues!
                              ),
                              SizedBox(height: 15.h),
                              //  problem
                              if (statuses.isNotEmpty && statuses.length > 1)
                                ProfileInputField(
                                  title: t.translate("businessType"),
                                  t: t,
                                  controller: businessController,
                                  items: statuses
                                      .map<String>((e) => e.name!.fromBase64)
                                      .toList(),
                                  initialValue: statuses
                                              .map<String>((e) => e.id!)
                                              .toList()
                                              .indexOf(jobStatus) >=
                                          0
                                      ? statuses
                                              .map<String>(
                                                  (e) => e.name!.fromBase64)
                                              .toList()[
                                          statuses
                                              .map<String>((e) => e.id!)
                                              .toList()
                                              .indexOf(jobStatus)]
                                      : initialStatus,
                                  isDropDown: true,
                                  onChanged: (v) {
                                    setState(() {
                                      print(v.toString());
                                      statusName = v.toString();
                                      jobStatus = statuses
                                          .map<String>((e) => e.id!)
                                          .toList()[(statuses
                                              .map<String>(
                                                  (e) => e.name!.fromBase64)
                                              .toList()
                                              .indexOf(v.toString()))]
                                          .toString();

                                      sendedJobStatus = allUserStatuses!
                                          .firstWhere((element) =>
                                              element.name ==
                                              v!.toString().toBase64)
                                          .id
                                          .toString();

                                      //  statusName =
                                    });
                                  },
                                )
                            ]),
                      SizedBox(height: 15.h),
                    ],
                  ),
                ),
                Divider(color: ColorConst.dviderColor, height: 1.h),
                SizedBox(height: 15.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.w),
                  child: Column(
                    children: [
                      //here
                      role == 'Roles.Worker'
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      profileContentTitle(
                                          t.translate("work"), IconConst.bag),
                                      SizedBox(height: 15.h),
                                      ValueListenableBuilder(
                                          valueListenable: otherWorks,
                                          builder: (context, value, _) {
                                            return value.isNotEmpty
                                                ? ListView.separated(
                                                    separatorBuilder: (context,
                                                            index) =>
                                                        SizedBox(height: 10.h),
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.zero,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        ((context, index) {
                                                      return ListTile(
                                                        title: Text(
                                                          otherWorks
                                                                  .value[index]
                                                              ['company'],
                                                          style: FontConst.font
                                                              .w600()
                                                              .px16()
                                                              .c(ColorConst
                                                                  .dark),
                                                        ),
                                                        trailing: Text(
                                                          otherWorks
                                                                  .value[index]
                                                              ['title']!,
                                                          style: FontConst.font
                                                              .w400()
                                                              .px14()
                                                              .c(ColorConst
                                                                  .dark),
                                                        ),
                                                        subtitle: Text(
                                                          otherWorks
                                                                  .value[index]
                                                              ['location']!,
                                                          style: FontConst.font
                                                              .w400()
                                                              .px14()
                                                              .c(ColorConst
                                                                  .dark),
                                                        ),
                                                      );
                                                    }),
                                                    itemCount:
                                                        otherWorks.value.length,
                                                  )
                                                : const SizedBox();
                                          }),
                                      SizedBox(height: 10.h),
                                      Divider(
                                          color: ColorConst.dviderColor,
                                          height: 1.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            t.translate("otherWork"),
                                            style: FontConst.font
                                                .w500()
                                                .px14()
                                                .c(ColorConst.dark),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddWorkPlace(
                                                    workExperienceList:
                                                        otherWorks,
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.add_circle_outlined,
                                              color: Color(0xff5A5A5A),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                Divider(
                                    color: ColorConst.dviderColor, height: 1.h),
                                SizedBox(height: 22.h),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(10.r),
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: ColorConst.secondary),
                                            child: SvgPicture.asset(
                                              IconConst.bag,
                                              color: ColorConst.primary,
                                              height: 18.r,
                                            ),
                                          ),
                                          SizedBox(width: 10.w),
                                          Text(
                                            t.translate("referance"),
                                            style: FontConst.font
                                                .px16()
                                                .w600()
                                                .copyWith(
                                                    color:
                                                        ColorConst.secondary),
                                          ),
                                          const Spacer(),
                                        ],
                                      ),
                                      //here
                                      SizedBox(height: 15.h),
                                      ProfileInputField(
                                          title: t.translate("name"),
                                          t: t,
                                          controller: referanceName),
                                      SizedBox(height: 15.h),
                                      ProfileInputField(
                                        title: t.translate("numberHint"),
                                        t: t,
                                        controller: referancePhone,
                                        keyboardType: TextInputType.phone,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15.h),
                                Divider(
                                    color: ColorConst.dviderColor, height: 1.h),
                                //TODO: add "Place lived"
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          profileContentTitle(
                                              t.translate("mainPlace"),
                                              IconConst.location),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SelectPlace(
                                                          mapList: mainMapList,
                                                          isMain: '1'),
                                                ),
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.add_circle_outlined,
                                              color: Color(0xff5A5A5A),
                                            ),
                                          )
                                        ],
                                      ),
                                      ValueListenableBuilder(
                                          valueListenable: mainMapList,
                                          builder: (context, value, child) {
                                            return value.isNotEmpty
                                                ? ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    itemCount: value.length,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            value[index]
                                                                .place_name!,
                                                            style: FontConst
                                                                .font
                                                                .px14()
                                                                .w400()
                                                                .copyWith(
                                                                    color: ColorConst
                                                                        .softTextColor),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              mapButton(() {
                                                                mainMapList
                                                                    .value
                                                                    .removeAt(
                                                                        index);
                                                                Navigator.of(
                                                                        context)
                                                                    .push(
                                                                  MaterialPageRoute(
                                                                    builder: (context) => SelectPlace(
                                                                        mapList:
                                                                            mainMapList,
                                                                        isMain:
                                                                            '1'),
                                                                  ),
                                                                );
                                                              })
                                                            ],
                                                          )
                                                        ],
                                                      );
                                                    })
                                                : placesCard(context, mainplace,
                                                    '1', mainMapList);
                                          })
                                      // : placesCard(
                                      //     context, mainplace, mapList),
                                    ],
                                  ),
                                ),
                                if (mainplace == "")
                                  Divider(
                                      color: ColorConst.dviderColor,
                                      height: 1.h),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 15.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          profileContentTitle(
                                            t.translate("otherPlaces"),
                                            IconConst.location,
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SelectPlace(
                                                          mapList: otherMapList,
                                                          isMain: '0'),
                                                ),
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.add_circle_outlined,
                                              color: Color(0xff5A5A5A),
                                            ),
                                          )
                                        ],
                                      ),
                                      ValueListenableBuilder(
                                          valueListenable: otherMapList,
                                          builder: (context, value, child) {
                                            return value.isNotEmpty
                                                ? ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    itemCount: value.length,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            value[index]
                                                                .place_name!,
                                                            style: FontConst
                                                                .font
                                                                .px14()
                                                                .w400()
                                                                .copyWith(
                                                                    color: ColorConst
                                                                        .softTextColor),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              mapButton(() {
                                                                otherMapList
                                                                    .value
                                                                    .removeAt(
                                                                        index);
                                                                Navigator.of(
                                                                        context)
                                                                    .push(
                                                                  MaterialPageRoute(
                                                                    builder: (context) => SelectPlace(
                                                                        mapList:
                                                                            otherMapList,
                                                                        isMain:
                                                                            '0'),
                                                                  ),
                                                                );
                                                              })
                                                            ],
                                                          )
                                                        ],
                                                      );
                                                    })
                                                : placesCard(context, mainplace,
                                                    '0', otherMapList);
                                          }),
                                      SizedBox(height: 15.h),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15.h),
                                Divider(
                                    color: ColorConst.dviderColor, height: 1.h),
                              ],
                            ),
                      SizedBox(height: 15.h),
                      role == 'Roles.Worker'
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              child: profileContentTitle(
                                  t.translate("placeLived"), IconConst.contact),
                            )
                          : const SizedBox(),
                      SizedBox(height: 15.h),
                      role == 'Roles.Worker'
                          ? Padding(
                              //here
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              child: ProfileInputField(
                                  title: t.translate("address"),
                                  t: t,
                                  controller: addressController),
                            )
                          : const SizedBox(),
                      // role == 'Roles.Worker'
                      //     ? Padding(
                      //         padding: EdgeInsets.symmetric(horizontal: 15.w),
                      //         child: Divider(
                      //             color: ColorConst.dviderColor, height: 1.h))
                      //     : const SizedBox(),
                      role == 'Roles.Worker'
                          ? SizedBox(height: 15.h)
                          : const SizedBox(),
                      role == 'Roles.Worker'
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: SizedBox(
                                  height: 200.h,
                                  child: GoogleMap(
                                    zoomGesturesEnabled: true,
                                    tiltGesturesEnabled: true,
                                    scrollGesturesEnabled: true,
                                    cameraTargetBounds:
                                        CameraTargetBounds.unbounded,
                                    gestureRecognizers: <
                                        Factory<OneSequenceGestureRecognizer>>{
                                      Factory<OneSequenceGestureRecognizer>(
                                        () => EagerGestureRecognizer(),
                                      ),
                                    },
                                    // max
                                    onMapCreated: (GoogleMapController ctrl) {
                                      controller = ctrl;
                                    },

                                    onTap: (LatLng latLng) {
                                      _markers.add(Marker(
                                          markerId: const MarkerId('1'),
                                          position: latLng));
                                      setState(() {
                                        locallatLng = latLng;
                                      });
                                    },
                                    markers: Set<Marker>.of(_markers),
                                    mapType: MapType.normal,
                                    zoomControlsEnabled: false,
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(double.parse(lat!),
                                          double.parse(lon!)),
                                      zoom: 10,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      SizedBox(height: 15.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Column(
                          children: [
                            profileContentTitle(
                                t.translate("contactInfo"), IconConst.contact),
                            SizedBox(height: 15.h),
                            ProfileInputField(
                                title: t.translate("mailHint"),
                                t: t,
                                controller: emailController),
                            SizedBox(height: 15.h),
                            ProfileInputField(
                              title: t.translate("numberHint"),
                              t: t,
                              controller: phoneController,
                              isReadOnly: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Divider(
                  color: ColorConst.dviderColor,
                  height: 1.h,
                ),
                SizedBox(height: 30.h),
                Padding(
                  padding: EdgeInsets.only(left: 29.w, right: 43.w),
                  child: BlocListener<
                      GeneralCubit<ProfileUpdateService, ProfileUpdateReqModel>,
                      GeneralState>(
                    listener: (context, state) {
                      if (state is GeneralSuccess) {
                        if ((state.data as StatusModel).status == 1) {
                          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //   content: Text(t.translate("profileSuccess")),
                          //   backgroundColor: Colors.green,
                          //   behavior: SnackBarBehavior.floating,
                          // ));
                          if (!widget.fromMain) {
                            Navigator.of(context).pop();
                          } else {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) {
                              return const MainPage();
                            }), (route) => false);
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(t.translate("profileFailed")),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                          ));
                        }
                      } else if (state is GeneralFail) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(t.translate("profileFailed")),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                        ));
                      }
                    },
                    child: mainButton(
                      context,
                      () async {
                        places = mainMapList.value + otherMapList.value;
                        //post
                        if (statusName != null && statusName!.isNotEmpty) {
                          locator.get<GetStorage>().write(
                              'user_status_${locator.get<GetStorage>().read('lang') ?? 'az'}',
                              statusName!.toBase64);
                        }
                        referance.add(ReferanceModel(
                          phone: referancePhone.text,
                          name: referanceName.text,
                        ).toJson());

                        if (birtController.value.toString() ==
                            '-0001-11-30 00:00:00.000') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(t.translate("birthdateReq")),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                          ));
                        } else if (gender == null ||
                            gender!.isEmpty ||
                            gender == '2') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(t.translate("genderReq")),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                          ));
                        } else {
                          await context
                              .read<
                                  GeneralCubit<ProfileUpdateService,
                                      ProfileUpdateReqModel>>()
                              .generalRequest(ProfileUpdateReqModel(
                                  person_name: nameController.text,
                                  person_surname: surNameController.text,
                                  person_father_name: fatherNameController.text,
                                  email: emailController.text,
                                  birthday: birtController.value,
                                  maps_json: json.encode(places),
                                  user_type_status: int.parse(
                                          sendedJobStatus.isEmpty
                                              ? jobStatus
                                              : sendedJobStatus)
                                      .toString(),
                                  gender: gender,
                                  place_name: businessNameController.text,
                                  address: addressController.text,
                                  lat: locallatLng?.latitude,
                                  lon: locallatLng?.longitude,
                                  work_experience_json:
                                      json.encode(otherWorks.value),
                                  referances_json: json.encode(referance)));
                        }

                        //TODO:show snackbar

                        await context
                            .read<
                                GeneralCubit<ProfileUpdateImageService,
                                    ProfileUpdateImageReqModel>>()
                            .generalRequest(ProfileUpdateImageReqModel(
                                img: image.value, background: backImage.value));
                        //here
                      },
                      t.translate("save"),
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          )),
    );
  }
}
