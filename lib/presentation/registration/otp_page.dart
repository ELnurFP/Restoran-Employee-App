import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:template/constants/constants.dart';
import 'package:template/cubit/general_cubit.dart';
import 'package:template/cubit/general_state.dart';
import 'package:template/infrastructure/remote/otp_service.dart';
import 'package:template/language/localization.dart';
import 'package:template/models/otp_req_model.dart';
import 'package:template/models/otp_res_model.dart';

import '../intro/intro_pages.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController otpCtrl = TextEditingController();

  @override
  void dispose() {
    otpCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
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
          t.translate('otpCode'),
          //context.loc.otpCode,
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 200.w,
                child: Text(
                  t.translate('enterOtp'),
                  //    context.loc.enterOtp,
                  textAlign: TextAlign.center,
                  style: FontConst.font.px14().w400().c(ColorConst.lightDark),
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              PinCodeTextField(
                length: 6,
                textStyle: FontConst.font.w600().px20().c(
                      ColorConst.almostBlack,
                    ),

                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  inactiveColor: ColorConst.secondary,
                  inactiveFillColor: ColorConst.primary,
                  selectedFillColor: ColorConst.primary,
                  selectedColor: ColorConst.secondaryDark,
                  fieldOuterPadding: EdgeInsets.zero,
                  borderWidth: 1.r,
                  borderRadius: BorderRadius.circular(11.r),
                  fieldHeight: 46.h,
                  fieldWidth: 50.w,
                  activeFillColor: ColorConst.primary,
                ),
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: ColorConst.primary,
                enableActiveFill: true,
                // errorAnimationController: errorController,
                controller: otpCtrl,
                appContext: context,
                onChanged: (String value) {
                  setState(() {});
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                t.translate('otpDidNot'),
                textAlign: TextAlign.center,
                style: FontConst.font.px14().w400().c(ColorConst.lightDark),
              ),
              SizedBox(
                height: 5.h,
              ),
              InkWell(
                onTap: () {
                  resendOtp(context);
                },
                child: Text(
                  t.translate('otpResend'),
                  textAlign: TextAlign.center,
                  style:
                      FontConst.font.px16().w600().c(ColorConst.secondaryDark),
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: BlocListener<GeneralCubit<OTPService, OTPReqModel>,
                        GeneralState>(
                      listener: (context, state) {
                        if (state is GeneralSuccess) {
                          if (state.data != null &&
                              (state.data as OTPResModel).status == '0') {
                            otpSubmit(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(t.translate("wrongOTP")),
                              backgroundColor: Colors.red,
                            ));
                          }
                        } else if (state is GeneralFail) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(t.translate("error")),
                            backgroundColor: Colors.red,
                          ));
                        }
                      },
                      child: ElevatedButton(
                        onPressed: otpCtrl.text.length == 6
                            ? () async {
                                await context
                                    .read<
                                        GeneralCubit<OTPService, OTPReqModel>>()
                                    .generalRequest(
                                        OTPReqModel(otp: otpCtrl.text));
                              }
                            : null,
                        child: Text(
                          t.translate('submit'),
                          style: FontConst.font.px16().w500().c(
                                ColorConst.primary,
                              ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void resendOtp(BuildContext context) {
    //
  }

  void otpSubmit(BuildContext context) {
    //
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const IntroPages()));
  }
}
