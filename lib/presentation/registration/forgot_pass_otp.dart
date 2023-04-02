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
import 'package:template/models/otp_res_model.dart';

import '../../models/otp_req_model.dart';
import '../main_page/main_page.dart';

class ForgotPassOtpPage extends StatefulWidget {
  const ForgotPassOtpPage({Key? key}) : super(key: key);

  @override
  State<ForgotPassOtpPage> createState() => _ForgotPassOtpPageState();
}

class _ForgotPassOtpPageState extends State<ForgotPassOtpPage> {
  TextEditingController otpCtrl = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  final regFormKey = GlobalKey<FormState>();
  bool onceValidated = false;
  bool isObs1 = true;
  bool isObs2 = true;
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
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Form(
              key: regFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200.w,
                    child: Text(
                      t.translate('enterOtp'),
                      textAlign: TextAlign.center,
                      style:
                          FontConst.font.px14().w400().c(ColorConst.lightDark),
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
                      style: FontConst.font
                          .px16()
                          .w600()
                          .c(ColorConst.secondaryDark),
                    ),
                  ),
                  SizedBox(height: 25.h),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return t.translate("passwordConstraint");
                      }
                      return null;
                    },
                    maxLength: 40,
                    autovalidateMode: onceValidated
                        ? AutovalidateMode.onUserInteraction
                        : null,
                    obscureText: isObs1,
                    textInputAction: TextInputAction.done,
                    controller: passController,
                    style:
                        FontConst.font.px16().w500().c(ColorConst.almostBlack),
                    decoration: InputDecoration(
                      hintText: t.translate("newPass"),
                      counterText: "",
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            isObs1 = !isObs1;
                          });
                        },
                        child: Icon(
                          isObs1 ? Icons.visibility : Icons.visibility_off,
                          color: ColorConst.lightDark,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return t.translate("passwordConstraint");
                      }
                      if (value != passController.text) {
                        return t.translate("noMatch");
                      }
                      return null;
                    },
                    maxLength: 40,
                    autovalidateMode: onceValidated
                        ? AutovalidateMode.onUserInteraction
                        : null,
                    obscureText: isObs2,
                    textInputAction: TextInputAction.done,
                    controller: confirmPassController,
                    style:
                        FontConst.font.px16().w500().c(ColorConst.almostBlack),
                    decoration: InputDecoration(
                      hintText: t.translate("confirmPass"),
                      counterText: "",
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            isObs2 = !isObs2;
                          });
                        },
                        child: Icon(
                          isObs2 ? Icons.visibility : Icons.visibility_off,
                          color: ColorConst.lightDark,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  BlocListener<GeneralCubit<OTPService, OTPReqModel>,
                      GeneralState>(
                    listener: (context, state) {
                      if (state is GeneralSuccess) {
                        if ((state.data as OTPResModel).status == '0') {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MainPage()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(t.translate("tryAgain")),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                          ));
                          // Get.snackbar(
                          //     '', 'Error occured! Please try again');
                        }
                      } else if (state is GeneralFail) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(t.translate("tryAgain")),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                        ));
                      } else if (state is GeneralLoading) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            t.translate("loading"),
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.grey,
                          behavior: SnackBarBehavior.floating,
                        ));
                      }
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: otpCtrl.text.length == 6
                                ? () async {
                                    if (regFormKey.currentState!.validate()) {
                                      await context
                                          .read<
                                              GeneralCubit<OTPService,
                                                  OTPReqModel>>()
                                          .generalRequest(OTPReqModel(
                                              otp: otpCtrl.text,
                                              password: passController.text,
                                              pass_new_code: '1'));
                                    }
                                  }
                                : null,
                            child: Text(
                              t.translate('submit'),
                              style: FontConst.font.px16().w500().c(
                                    ColorConst.primary,
                                  ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void resendOtp(BuildContext context) {}

  void otpSubmit(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const MainPage()));
  }
}
