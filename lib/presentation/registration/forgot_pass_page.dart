import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:template/constants/constants.dart';
import 'package:template/cubit/general_state.dart';
import 'package:template/models/sign_in_res_model.dart';
import 'package:template/presentation/widgets/main_buton.dart';

import '../../cubit/general_cubit.dart';
import '../../infrastructure/remote/forgot_service.dart';
import '../../infrastructure/remote/otp_service.dart';
import '../../language/localization.dart';
import '../../models/forgot_req_model.dart';
import '../../models/otp_req_model.dart';
import 'forgot_pass_otp.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key, required this.number});
  final String? number;

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage>
    with WidgetsBindingObserver {
  GlobalKey<FormState> regFormKey = GlobalKey<FormState>();
  TextEditingController numberCtrl = TextEditingController();
  bool onceValidated = false;
  var _isKeyboardVisible = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    numberCtrl.text = widget.number ?? '';
    super.initState();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    final newValue = bottomInset > 0.0;
    if (newValue != _isKeyboardVisible) {
      setState(() {
        _isKeyboardVisible = newValue;
      });
    }
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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 45.h),
                    Text(
                      t.translate("forgotPassword"),
                      style: FontConst.font
                          .w500()
                          .px26()
                          .c(ColorConst.secondaryDark),
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      t.translate("forgotPasswordDesc"),
                      // textAlign: TextAlign.center,
                      style:
                          FontConst.font.w400().px16().c(ColorConst.lightDark),
                    ),
                    SizedBox(height: 30.h),
                    Form(
                      key: regFormKey,
                      child: Column(
                        children: [
                          TextFormField(
                            style: FontConst.font
                                .px16()
                                .w500()
                                .c(ColorConst.almostBlack),
                            validator: (value) {
                              if (value == null || value.length != 9) {
                                return t.translate("numberConstraint");
                              }
                              return null;
                            },
                            maxLength: 9,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^[1-9][0-9]*$')),
                            ],
                            controller: numberCtrl,
                            autovalidateMode: onceValidated
                                ? AutovalidateMode.onUserInteraction
                                : null,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              counterText: "",
                              hintText: t.translate("numberHint"),
                              prefixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  Container(
                                    width: 22.h,
                                    height: 22.h,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(
                                          ImageConst.az2,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    " +994 ",
                                    style: FontConst.font
                                        .px16()
                                        .w500()
                                        .c(ColorConst.titleAppbar),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h),
                          BlocListener<
                              GeneralCubit<ForgotService, ForgotReqModel>,
                              GeneralState>(
                            listener: (context, state) {
                              if (state is GeneralSuccess) {
                                if ((state.data as SignInResModel).status ==
                                    '0') {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider<
                                              GeneralCubit<OTPService,
                                                  OTPReqModel>>(
                                          create: (context) => GeneralCubit<
                                              OTPService, OTPReqModel>(),
                                          child: const ForgotPassOtpPage()),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(t.translate("tryAgain")),
                                    backgroundColor: Colors.red,
                                    behavior: SnackBarBehavior.floating,
                                  ));
                                }
                              } else if (state is GeneralFail) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(t.translate("error")),
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                ));
                              } else if (state is GeneralLoading) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    t.translate("loading"),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.grey,
                                  behavior: SnackBarBehavior.floating,
                                ));
                              }
                            },
                            child: mainButton(context, () async {
                              if (numberCtrl.text.replaceAll(' ', '') != '') {
                                await context
                                    .read<
                                        GeneralCubit<ForgotService,
                                            ForgotReqModel>>()
                                    .generalRequest(ForgotReqModel(
                                        number: "+994${numberCtrl.text}"));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(t.translate("plsFill")),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.red,
                                ));
                              }
                            }, t.translate("next")),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (!_isKeyboardVisible)
              InkWell(
                onTap: () {
                  Navigator.of(context).pop(context);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      t.translate("haveNotACC"),
                      // context.loc.haveNotACC,
                      style: FontConst.font.w400().px14().c(
                            ColorConst.BCBABA,
                          ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Text(
                      t.translate("sign_up"),
                      //context.loc.sign_up,
                      style: FontConst.font.w600().px14().c(
                            ColorConst.secondaryDark,
                          ),
                    ),
                  ],
                ),
              ),
            if (!_isKeyboardVisible)
              SizedBox(
                height: 20.h,
              )
          ],
        ),
      ),
    );
  }
}
