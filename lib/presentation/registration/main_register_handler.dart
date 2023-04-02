import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:template/configs/base64_conventer.dart';
import 'package:template/constants/constants.dart';
import 'package:template/cubit/general_state.dart';
import 'package:template/dependency_injection.dart';
import 'package:template/infrastructure/remote/get_user_status_types_service.dart';
import 'package:template/infrastructure/remote/sign_in_service.dart';
import 'package:template/language/localization.dart';
import 'package:template/models/get_user_status_req_model.dart';
import 'package:template/models/sign_in_req_model.dart';
import 'package:template/models/sign_in_res_model.dart';

import '../../application/core/mail_validator.dart';
import '../../application/core/roles.dart';
import '../../cubit/general_cubit.dart';
import '../../infrastructure/remote/otp_service.dart';
import '../../models/get_user_status_type_res_model.dart';
import '../../models/otp_req_model.dart';
import '../widgets/custom_dropdownformfield.dart';
import 'otp_page.dart';

class RegisterHandlerPage extends StatefulWidget {
  final Roles role;

  const RegisterHandlerPage({Key? key, required this.role}) : super(key: key);

  @override
  State<RegisterHandlerPage> createState() => _RegisterHandlerPageState();
}

class _RegisterHandlerPageState extends State<RegisterHandlerPage>
    with WidgetsBindingObserver {
  var _isKeyboardVisible = false;
  final _regFormKey = GlobalKey<FormState>();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController numberCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController mailCtrl = TextEditingController();
  String? category;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
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
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    nameCtrl.dispose();
    numberCtrl.dispose();
    passwordCtrl.dispose();
    mailCtrl.dispose();
    super.dispose();
  }

  bool onceValidated = false;

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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //
                    SizedBox(
                      height: 45.h,
                    ),
                    Text(
                      t.translate('sign_up'),
                      //  context.loc.sign_up,
                      style: FontConst.font
                          .w500()
                          .px26()
                          .c(ColorConst.secondaryDark),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Form(
                      key: _regFormKey,
                      child: Column(
                        children: [
                          TextFormField(
                            style: FontConst.font
                                .px16()
                                .w500()
                                .c(ColorConst.almostBlack),
                            validator: (value) {
                              if (value == null || value.length < 3) {
                                return t.translate(
                                    "nameConstraint"); //context.loc.nameConstraint;
                              }
                              return null;
                            },
                            autovalidateMode: onceValidated
                                ? AutovalidateMode.onUserInteraction
                                : null,
                            maxLength: 40,
                            textInputAction: TextInputAction.next,
                            controller: nameCtrl,
                            decoration: InputDecoration(
                              hintText: t.translate(
                                  "nameSurnameHint"), //context.loc.nameSurnameHint,
                              counterText: "",
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          TextFormField(
                            style: FontConst.font
                                .px16()
                                .w500()
                                .c(ColorConst.almostBlack),
                            autovalidateMode: onceValidated
                                ? AutovalidateMode.onUserInteraction
                                : null,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || !isValidMail(value)) {
                                return t.translate("mailConstraint");
                                // context.loc.mailConstraint;
                              }
                              return null;
                            },
                            maxLength: 100,
                            controller: mailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: t.translate(
                                  "mailHint"), // context.loc.mailHint,
                              counterText: "",
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          TextFormField(
                            style: FontConst.font
                                .px16()
                                .w500()
                                .c(ColorConst.almostBlack),
                            validator: (value) {
                              if (value == null || value.length != 9) {
                                return t.translate("numberConstraint");
                                //context.loc.numberConstraint;
                              }
                              return null;
                            },
                            maxLength: 9,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  //5404686
                                  RegExp(r'^[1-9][0-9]*$')),
                            ],
                            controller: numberCtrl,
                            autovalidateMode: onceValidated
                                ? AutovalidateMode.onUserInteraction
                                : null,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              counterText: "",
                              hintText: t.translate(
                                  "numberHint"), //context.loc.numberHint,
                              // prefixStyle: FontConst.font
                              prefixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                //
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
                          SizedBox(
                            height: 30.h,
                          ),
                          BlocBuilder<
                              GeneralCubit<GetUsesStatusTypeService,
                                  GetUserStatusTypeReqModel>,
                              GeneralState>(builder: (context, state) {
                            if (state is GeneralSuccess) {
                              var objList =
                                  (state.data! as GetUserStatusTypeResModel)
                                      .types!;
                              var list =
                                  (state.data! as GetUserStatusTypeResModel)
                                      .types!
                                      .map<String>((e) => e.name!.fromBase64)
                                      .toList();

                              return Row(
                                children: [
                                  customDropDownFormField(
                                    list,
                                    hint: t.translate("category"),
                                    onChanged: (value) {
                                      if (value != null) {
                                        locator
                                            .get<GetStorage>()
                                            .write('user_status', value);
                                        locator.get<GetStorage>().write(
                                            'user_status_${locator.get<GetStorage>().read('lang') ?? 'az'}',
                                            value.toBase64);
                                        locator.get<GetStorage>().write(
                                            'user_status_id',
                                            objList[list.indexOf(value)].id);
                                        category = value;
                                      }
                                    },
                                  )
                                ],
                              );
                            } else {
                              return Row(
                                children: [
                                  customDropDownFormField(
                                    [],
                                    hint: t.translate("category"),
                                    onChanged: (value) {
                                      //category = value;
                                    },
                                  )
                                ],
                              );
                            }
                          }),
                          SizedBox(
                            height: 30.h,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.length < 6) {
                                return t.translate("passwordConstraint");
                                //context.loc.passwordConstraint;
                              }
                              return null;
                            },
                            maxLength: 40,
                            autovalidateMode: onceValidated
                                ? AutovalidateMode.onUserInteraction
                                : null,
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            controller: passwordCtrl,
                            style: FontConst.font
                                .px16()
                                .w500()
                                .c(ColorConst.almostBlack),
                            decoration: InputDecoration(
                              hintText: t.translate(
                                  "passwordHint"), // context.loc.passwordHint,
                              counterText: "",
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          // Text(
                          //   t.translate(
                          //       "registerShortcut"), //context.loc.registerShortcut,
                          //   style: FontConst.font
                          //       .w400()
                          //       .px14()
                          //       .c(ColorConst.BCBABA),
                          // ),
                          // SizedBox(
                          //   height: 15.h,
                          // ),
                          // Row(
                          //   mainAxisSize: MainAxisSize.min,
                          //   children: [
                          //     //
                          //     InkWell(
                          //       onTap: () {
                          //         withGoogle(context);
                          //       },
                          //       child: Image.asset(
                          //         ImageConst.google,
                          //         height: 32.h,
                          //         width: 32.h,
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       width: 32.w,
                          //     ),
                          //     InkWell(
                          //       onTap: () {
                          //         withFacebook(context);
                          //       },
                          //       child: SvgPicture.asset(
                          //         IconConst.facebook,
                          //         height: 32.h,
                          //         width: 32.h,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          SizedBox(
                            height: 35.h,
                          ),
                          BlocListener<
                              GeneralCubit<SignInService, SignInReqModel>,
                              GeneralState>(
                            listener: (context, state) {
                              if (state is GeneralSuccess) {
                                if (state.data != null &&
                                    (state.data as SignInResModel).status! ==
                                        '0') {
                                  manualRegister(context);
                                } else if (state.data != null &&
                                    (state.data as SignInResModel).status! ==
                                        '1') {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(t.translate("userExist")),
                                    backgroundColor: Colors.red,
                                    behavior: SnackBarBehavior.floating,
                                  ));

                                  // Get.snackbar('', 'User Exist');
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(t.translate("error")),
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
                              }
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      onceValidated = true;
                                      setState(() {});
                                      if (_regFormKey.currentState!
                                              .validate() &&
                                          category != null) {
                                        await context
                                            .read<
                                                GeneralCubit<SignInService,
                                                    SignInReqModel>>()
                                            .generalRequest(SignInReqModel(
                                              email: mailCtrl.text,
                                              name: nameCtrl.text,
                                              number: numberCtrl.text.isNotEmpty
                                                  ? '+994${numberCtrl.text}'
                                                  : null,
                                              user_type_status: locator
                                                  .get<GetStorage>()
                                                  .read('user_status_id'),
                                              password: passwordCtrl.text,
                                              login_type: '0',
                                              type: locator
                                                          .get<GetStorage>()
                                                          .read('role') ==
                                                      'Roles.Worker'
                                                  ? '1'
                                                  : '0',
                                            ));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(t.translate("plsFill")),
                                          backgroundColor: Colors.red,
                                          behavior: SnackBarBehavior.floating,
                                        ));
                                      }
                                    },
                                    child: Text(
                                      t.translate("sign_up")
                                      // context.loc.sign_up
                                      ,
                                      style: FontConst.font.px16().w500().c(
                                            ColorConst.primary,
                                          ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (!_isKeyboardVisible) SizedBox(height: 20.h),
            if (!_isKeyboardVisible)
              InkWell(
                onTap: () {
                  gotoSignIn(context);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      t.translate(
                          "alreadyHaveACC"), //  context.loc.alreadyHaveACC,
                      style: FontConst.font.w400().px14().c(
                            ColorConst.BCBABA,
                          ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Text(
                      t.translate("sign_in"),
                      // context.loc.sign_in,
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

  void withGoogle(BuildContext context) {}

  void withFacebook(BuildContext context) {}

  void manualRegister(BuildContext context) {
    //TEMP LINKER
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            BlocProvider<GeneralCubit<OTPService, OTPReqModel>>(
                create: (context) => GeneralCubit<OTPService, OTPReqModel>(),
                child: const OtpPage())));

    //context.router.push(const OtpPageRoute());
  }

  gotoSignIn(BuildContext context) {
    // context.router.push(const SignInPageRoute());
    Navigator.of(context).pop(context);
  }
}
