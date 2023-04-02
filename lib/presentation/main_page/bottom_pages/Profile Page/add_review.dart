import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:template/configs/base64_conventer.dart';
import 'package:template/constants/color_constant.dart';
import 'package:template/constants/font_constant.dart';
import 'package:template/cubit/general_cubit.dart';
import 'package:template/language/localization.dart';
import 'package:template/models/status_model.dart';
import 'package:template/presentation/widgets/custom_appbar.dart';
import 'package:template/presentation/widgets/custom_checkbox_field.dart';
import 'package:template/presentation/widgets/main_buton.dart';

import '../../../../constants/image_constant.dart';
import '../../../../cubit/general_state.dart';
import '../../../../dependency_injection.dart';
import '../../../../infrastructure/remote/get_user_status_types_service.dart';
import '../../../../infrastructure/remote/rate_workers_owner_service.dart';
import '../../../../models/get_order_res_model.dart';
import '../../../../models/get_user_status_req_model.dart';
import '../../../../models/rate_workers_owner_req_model.dart';

class AddReviewPage extends StatefulWidget {
  const AddReviewPage({super.key, required this.orderId, this.applieds});

  final List<GetApplieds>? applieds;
  final String orderId;

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final TextEditingController commentController = TextEditingController();
  int indexUser = 0;

  final BehaviorSubject<bool> _isChecked = BehaviorSubject();
  final BehaviorSubject<int> _starNotifier = BehaviorSubject();

  @override
  void initState() {
    super.initState();
    _starNotifier.value = 5;
    _isChecked.value = false;
  }

  @override
  Widget build(BuildContext context) {
    print('build ${widget.applieds?[indexUser].rate}');
    commentController.text = widget.applieds?[indexUser].comment != null
        ? (widget.applieds?[indexUser].comment!.fromBase64) ?? ''
        : '';
    _starNotifier.value = widget.applieds?[indexUser].rate != null &&
            widget.applieds?[indexUser].rate != '0'
        ? int.parse((widget.applieds?[indexUser].rate) ?? '5')
        : 5;
    _isChecked.value = (widget.applieds?[indexUser].is_not_come) != null
        ? (widget.applieds![indexUser].is_not_come! == '1')
        : false;

    AppLocalizations? t = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: ColorConst.primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            customAppBar(context, t!.translate("review")),
            SizedBox(height: 14.h),
            Text(
              '${indexUser + 1}/${widget.applieds!.length}',
              style: FontConst.font.w600().px18().copyWith(
                    color: ColorConst.dark,
                  ),
            ),
            SizedBox(height: 14.h),
            CircleAvatar(
              radius: 50.r,
              backgroundColor: ColorConst.primary,
              // foregroundImage: NetworkImage(
              //   widget.applieds![indexUser].img == '' ||
              //           widget.applieds![indexUser].img == 'null' ||
              //           widget.applieds![indexUser].img == null
              //       ? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png"
              //       : 'https://rayza.az/${widget.applieds![indexUser].img}',
              // ),
              child: widget.applieds![indexUser].img == '' ||
                      widget.applieds![indexUser].img == 'null' ||
                      widget.applieds![indexUser].img == null
                  ? Image.asset(
                      ImageConst.ph,
                      fit: BoxFit.fill,
                      height: 100.h,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(50.r),
                      child: Image.network(
                        'https://rayza.az/${widget.applieds![indexUser].img}',
                        width: 100.w,
                        height: 100.h,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            ImageConst.ph1,
                            fit: BoxFit.fill,
                          );
                        },
                        frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                          if (wasSynchronouslyLoaded) {
                            return child;
                          }
                          return AnimatedOpacity(
                            opacity: frame == null ? 0 : 1,
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeOut,
                            child: child,
                          );
                        },
                      ),
                    ),
            ),
            SizedBox(height: 14.h),
            Text(
              widget.applieds![indexUser].person_name == '' ||
                      widget.applieds![indexUser].person_name == 'null' ||
                      widget.applieds![indexUser].person_name == null
                  ? ""
                  : '${widget.applieds![indexUser].person_name!.fromBase64} ${widget.applieds![indexUser].person_surname!.fromBase64}',
              style:
                  FontConst.font.w500().px16().copyWith(color: ColorConst.dark),
            ),
            SizedBox(height: 7.h),
            BlocProvider<
                GeneralCubit<GetUsesStatusTypeService,
                    GetUserStatusTypeReqModel>>(
              create: (context) => GeneralCubit<GetUsesStatusTypeService,
                  GetUserStatusTypeReqModel>()
                ..generalRequest(GetUserStatusTypeReqModel(
                    type:
                        locator.get<GetStorage>().read('role') == 'Roles.Owner'
                            ? '1'
                            : '0')),
              child: BlocBuilder<
                  GeneralCubit<GetUsesStatusTypeService,
                      GetUserStatusTypeReqModel>,
                  GeneralState>(builder: (context, state) {
                if (state is GeneralSuccess) {
                  return Text(
                    widget.applieds![indexUser].worker_type!.isNotEmpty
                        ? widget.applieds![indexUser].worker_type!.fromBase64
                        : '',
                    style: FontConst.font
                        .w500()
                        .px14()
                        .copyWith(color: const Color(0xFF9C9C9C)),
                  );
                } else {
                  return Text(
                    "",
                    style: FontConst.font
                        .w500()
                        .px14()
                        .copyWith(color: const Color(0xFF9C9C9C)),
                  );
                }
              }),
            ),
            SizedBox(height: 15.h),
            SizedBox(
              height: 30.h,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: ((context, index) {
                  return StreamBuilder(
                    stream: _starNotifier,
                    builder: (
                      context,
                      value,
                    ) {
                      return GestureDetector(
                        onTap: () {
                          _starNotifier.value = index + 1; //index starts from 0
                        },
                        child: Icon(
                          (value.data ?? 5) > index
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.yellow,
                          size: 30.h,
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: StreamBuilder<bool>(
                  stream: _isChecked,
                  builder: (context, value) {
                    return CustomCheckboxField(
                        red: true,
                        title: t.translate("didNotCome"),
                        value: value.data!,
                        onTap: () {
                          _isChecked.value = !value.data!;
                        });
                  }),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: TextFormField(
                controller: commentController,
                maxLines: 5,
                decoration: InputDecoration(
                  isDense: false,
                  fillColor: Colors.white,
                  hintText: t.translate("comment"),
                  hintStyle: FontConst.font.w400().px14().copyWith(
                        color: ColorConst.softTextColor,
                      ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 13.w, vertical: 7.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.r),
                    borderSide: const BorderSide(
                      color: Color(0xffACACAC),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.r),
                    borderSide: const BorderSide(
                      color: Color(0xffACACAC),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.r),
                    borderSide: const BorderSide(
                      color: Color(0xffACACAC),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 23.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.w),
              child: BlocListener<
                  GeneralCubit<RateWorkerOwnerService, RateWorkerOwnerReqModel>,
                  GeneralState>(
                listener: (context, state) {
                  if (state is GeneralSuccess) {
                    if (((state.data as StatusModel).status ?? 0) == 1) {
                      if (indexUser < widget.applieds!.length - 1) {
                        setState(() {
                          indexUser++;
                        });
                      } else {
                        Navigator.of(context).pop();
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 2),
                          content: Text(t.translate("tryAgain")),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  } else if (state is GeneralFail) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 2),
                        content: Text(t.translate("tryAgain")),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                child: mainButton(context, () async {
                  await context
                      .read<
                          GeneralCubit<RateWorkerOwnerService,
                              RateWorkerOwnerReqModel>>()
                      .generalRequest(RateWorkerOwnerReqModel(
                        comment: commentController.text,
                        not_come: _isChecked.stream.value ? '1' : '0',
                        order_id: widget.orderId,
                        rate: _starNotifier.stream.value.toString(),
                        opr_id: widget.applieds![indexUser].id ?? '',
                      ));
                }, t.translate("next")),
              ),
            )
          ],
        ),
      ),
    );
  }
}
