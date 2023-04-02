// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:template/configs/base64_conventer.dart';
import 'package:template/constants/constants.dart';
import 'package:template/language/localization.dart';
import 'package:template/models/status_model.dart';
import '../../../cubit/general_cubit.dart';
import '../../../cubit/general_state.dart';
import '../../../dependency_injection.dart';
import '../../../infrastructure/remote/update_saved_order_service.dart';
import '../../../models/update_saved_orders_req_model.dart';
import '../../core/decoder.dart';
import '../../core/icon_and_test.dart';
import '../../core/shadows.dart';
import '../entity/ad_entity.dart';

class AdView extends StatefulWidget {
  const AdView(
      {Key? key,
      required this.adEntity,
      this.orderType = '',
      this.total = '',
      this.saved = ''})
      : super(key: key);

  final AdEntity adEntity;
  final String orderType;
  final String saved;
  final String total;

  @override
  State<AdView> createState() => _AdViewState();
}

class _AdViewState extends State<AdView> {
  Color workTypeColor() {
    String ownerType = widget.adEntity.ownerType.isNotEmpty
        ? Decoder.text(widget.adEntity.ownerType)[0]
        : '';

    Color color;

    switch (ownerType) {
      case 'A':
        color = const Color(0xffE9D7FF);
        break;
      case 'R':
        color = const Color(0xff6A9DEA);
        break;
      case 'O':
        color = const Color(0xff93D6F4);
        break;
      case 'Q':
        color = const Color(0xff99DB71);
        break;
      case 'S':
        color = const Color(0xffF8935B);
        break;
      case 'İ':
        color = const Color(0xffE9D7FF);
        break;
      case 'K':
        color = const Color(0xffBCF5A1);
        break;
      case 'X':
        color = const Color(0xff6A9DEA);
        break;
      case 'T':
        color = const Color(0xffF8935B);
        break;
      case 'D':
        color = const Color(0xff99DB71);
        break;
      default:
        color = const Color(0xffE9D7FF);
        break;
    }

    return color;
  }

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
        children: [
          Stack(
            children: [
              Container(
                width: 50.h,
                height: 50.h,
                decoration: BoxDecoration(
                  color: workTypeColor(),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        widget.adEntity.ownerType.isNotEmpty
                            ? Decoder.text(widget.adEntity.ownerType)[0]
                            : "A",
                        style: FontConst.font.w600().px24().c(
                              const Color.fromARGB(255, 140, 98, 192),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -6.h,
                right: 0,
                left: 0,
                child: widget.adEntity.isVip == '1'
                    ? SvgPicture.asset(
                        IconConst.crown,
                        width: 25.w,
                        color: const Color(0xFFDBA932),
                      )
                    : const SizedBox.shrink(),
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
              SizedBox(
                width: 140.w,
                child: Text(
                  Decoder.text(widget.adEntity.workerType),
                  style: FontConst.font.w500().px16().c(
                        ColorConst.dark,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              SizedBox(
                width: 140.w,
                child: Text(
                  Decoder.text(widget.adEntity.ownerType),
                  style: FontConst.font.w400().px14().c(
                        ColorConst.lightDark,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "ID#${widget.adEntity.id}",
                style: FontConst.font.w400().px14().c(
                      ColorConst.lightDark,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                padding: EdgeInsets.all(
                  7.h,
                ),
                width: 85.w,
                decoration: BoxDecoration(
                  color: widget.adEntity.status == '0'
                      ? ColorConst.orangeStatus
                      : widget.adEntity.status.toString() == '3'
                          ? Colors.black
                          : widget.adEntity.status.toString() == '4'
                              ? const Color(0xffE90B0B)
                              : ColorConst.secondary,
                  borderRadius: BorderRadius.circular(
                    12.r,
                  ),
                ),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        widget.adEntity.status == '0'
                            ? t.translate("active")
                            : widget.adEntity.status == '1'
                                ? t.translate("completed")
                                : widget.adEntity.status.toString() == '2'
                                    ? t.translate("ended")
                                    : widget.adEntity.status.toString() == '3'
                                        ? t.translate("archived")
                                        : t.translate("cancelled"),
                        textAlign: TextAlign.center,
                        style: FontConst.font.w400().px10().c(
                              widget.adEntity.status == '3'
                                  ? Colors.black
                                  : ColorConst.whiteSupporter,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context, AppLocalizations t) {
    ValueNotifier<bool> fav = ValueNotifier(widget.saved == '0' ? false : true);

    return Container(
      margin: EdgeInsets.only(
        bottom: 8.r,
        left: 8.r,
        right: 8.r,
      ),
      padding: EdgeInsets.only(
        bottom: 15.h,
        left: 22.w,
        right: 22.w,
        top: 14.h,
      ),
      decoration: BoxDecoration(
        color: ColorConst.contBack,
        border: widget.adEntity.isVip == "1"
            ? Border.all(
                color: ColorConst.orange,
                width: 1.r,
              )
            : null,
        borderRadius: BorderRadius.circular(
          15.r,
        ),
      ),
      child: Column(
        children: [
          if (widget.adEntity.description.isNotEmpty)
            Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 280.w,
                  child: Text(
                    widget.adEntity.description.fromBase64,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
          if (widget.adEntity.description.isNotEmpty)
            SizedBox(
              height: 5.h,
            ),
          if (widget.adEntity.attendees.isNotEmpty &&
              widget.adEntity.count.isNotEmpty)
            IconAndText(
              IconConst.done,
              "${widget.adEntity.attendees}/${widget.adEntity.count} ${t.translate("applicantCounter")}",
              // //    context.loc.applicantCounter
              //         .replaceAll("\$a", adEntity.attendees)
              //         .replaceAll(
              //           "\$t",
              //           adEntity.count,
              //         ),
              const Color(0xFF99DB71),
              width: 215.h,
            ),
          if (widget.adEntity.workDate.isNotEmpty)
            IconAndText(
              IconConst.calendar,
              '${t.translate("deadline")} ${widget.adEntity.workDate.characters.take(16).toString()}',
              //   'Deadline ${widget.adEntity.workDate.substring(0, 10).split('-').reversed.join('.') }',
              // DateFormat("d MMMM, yyyy")
              //     .format(DateTime.parse(adEntity.workDate)),
              ColorConst.blue,
            ),
          if (widget.adEntity.workHours.isNotEmpty)
            IconAndText(
              IconConst.time,
              // context.loc.workHours
              //     .replaceAll("\$d", Decoder.text(adEntity.workHours)),
              '${t.translate("workHours")}: ${Decoder.text(widget.adEntity.workHours)}',
              ColorConst.blue,
            ),
          if (widget.adEntity.address.isNotEmpty)
            IconAndText(
              IconConst.location,
              Decoder.text(widget.adEntity.address),
              ColorConst.orange,
            ),
          if (widget.orderType.isNotEmpty)
            locator.get<GetStorage>().read('role') != 'Roles.Worker'
                ? Row(
                    children: [
                      IconAndText(
                          widget.orderType == '0'
                              ? IconConst.fund
                              : IconConst.starFull,
                          widget.orderType == '0'
                              ? t.translate("economic")
                              : t.translate("express"),
                          widget.orderType == '0'
                              ? ColorConst.ekonomColor
                              : ColorConst.exspressColor),
                      SizedBox(
                        width: 10.w,
                      ),
                      if (widget.total.isNotEmpty)
                        Container(
                          padding: EdgeInsets.only(
                              right: 10.w, left: 10.w, top: 7.h, bottom: 5.h),
                          decoration: BoxDecoration(
                            color: const Color(0xffBCF5A1),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text(
                            '${widget.total} AZN',
                            textAlign: TextAlign.center,
                            style: FontConst.font
                                .w400()
                                .px12()
                                .c(const Color(0xff4FAB30)),
                          ),
                        )
                    ],
                  )
                : const SizedBox(),
          if (widget.adEntity.gender.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconAndText(
                  widget.adEntity.gender == "0"
                      ? IconConst.man
                      : widget.adEntity.gender == "1"
                          ? IconConst.woman
                          : IconConst.gender,
                  widget.adEntity.gender == "0"
                      ? t.translate("male") //context.loc.male
                      : widget.adEntity.gender == "1"
                          ? t.translate('female') //context.loc.female
                          : t.translate("allGender"),
                  widget.adEntity.gender == "0"
                      ? ColorConst.blue
                      : widget.adEntity.gender == "1"
                          ? Colors.pink
                          : Colors.cyan,
                ),
                locator.get<GetStorage>().read('role') == 'Roles.Worker' &&
                        widget.saved != ''
                    ? BlocProvider(
                        create: (context) => GeneralCubit<
                            UpdateSavedOrdersService,
                            UpdateSavedOrdersReqModel>(),
                        child: BlocListener<
                                GeneralCubit<UpdateSavedOrdersService,
                                    UpdateSavedOrdersReqModel>,
                                GeneralState>(
                            listener: (context, state) {
                              if (state is GeneralSuccess) {
                                if ((state.data as StatusModel).status == 1) {
                                  fav.value = !fav.value;
                                }
                              }
                            },
                            child: ValueListenableBuilder<bool>(
                                valueListenable: fav,
                                builder: (context, value, child) {
                                  return InkWell(
                                      onTap: () async {
                                        await context
                                            .read<
                                                GeneralCubit<
                                                    UpdateSavedOrdersService,
                                                    UpdateSavedOrdersReqModel>>()
                                            .generalRequest(
                                                UpdateSavedOrdersReqModel(
                                              id: widget.adEntity.id,
                                              type: !fav.value ? '0' : '1',
                                            ));
                                      },
                                      child: Icon(fav.value
                                          ? Icons.bookmark
                                          : Icons.bookmark_outline));
                                })),
                      )
                    : const SizedBox()
              ],
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations? t = AppLocalizations.of(context);

    return Container(
      margin: EdgeInsets.only(bottom: 20.h, left: 6.w, right: 6.w),
      decoration: BoxDecoration(
        color: ColorConst.primary,
        boxShadow: Shadows.shadow1,
        borderRadius: BorderRadius.circular(
          15.r,
        ),
      ),
      child: Column(
        children: [
          _header(context, t!),
          _body(context, t),
        ],
      ),
    );
  }
}
