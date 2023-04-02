import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:template/application/core/roles.dart';
import 'package:template/cubit/general_state.dart';
import 'package:template/dependency_injection.dart';
import 'package:template/infrastructure/remote/forgot_service.dart';
import 'package:template/language/localization.dart';
import 'package:template/models/forgot_req_model.dart';
import 'package:template/presentation/main_page/main_page.dart';
import 'package:template/presentation/registration/forgot_pass_page.dart';
import '../../constants/color_constant.dart';
import '../../constants/font_constant.dart';
import '../../constants/icon_constant.dart';
import '../../constants/image_constant.dart';
import '../../cubit/general_cubit.dart';
import '../../infrastructure/remote/get_user_status_types_service.dart';
import '../../infrastructure/remote/login_service.dart';
import '../../infrastructure/remote/sign_in_service.dart';
import '../../models/get_user_status_req_model.dart';
import '../../models/login_req_model.dart';
import '../../models/login_res_model.dart';
import '../../models/sign_in_req_model.dart';
import 'main_register_handler.dart';

class SignInPage extends StatefulWidget {
  //
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with WidgetsBindingObserver {
  var _isKeyboardVisible = false;
  final _regFormKey = GlobalKey<FormState>();
  TextEditingController numberCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

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
    numberCtrl.dispose();
    passwordCtrl.dispose();
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
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //
                      SizedBox(
                        height: 45.h,
                      ),
                      Text(
                        t.translate("sign_in"),
                        //  context.loc.sign_in,
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
                                if (value == null || value.length != 9) {
                                  return t.translate(
                                      "numberConstraint"); //context.loc.numberConstraint;
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
                            SizedBox(height: 20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => BlocProvider<
                                            GeneralCubit<ForgotService,
                                                ForgotReqModel>>(
                                          create: (context) => GeneralCubit<
                                              ForgotService, ForgotReqModel>(),
                                          child: ForgotPassPage(
                                              number: numberCtrl.text),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    t.translate("forgotPassword"),
                                    // context.loc.forgotPassword,
                                    style: FontConst.font
                                        .w400()
                                        .px14()
                                        .c(ColorConst.BCBABA),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30.h),
                            // Text(
                            //   t.translate("registerShortcut"),
                            //   //   context.loc.registerShortcut,
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
                                GeneralCubit<LoginService, LoginReqModel>,
                                GeneralState>(
                              listener: (context, state) {
                                if (state is GeneralSuccess) {
                                  if (state.data != null &&
                                      (state.data as LoginResModel).status ==
                                          '1') {
                                    manualSignIn(context);
                                  } else if ((state.data != null &&
                                      (state.data as LoginResModel).status ==
                                          '0')) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(t.translate("wrongPass")),
                                      backgroundColor: Colors.red,
                                    ));
                                  } else if ((state.data != null &&
                                      (state.data as LoginResModel).status ==
                                          '2')) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content:
                                          Text(t.translate("typeErrorOwner")),
                                      backgroundColor: Colors.red,
                                    ));
                                  }
                                } else if (state is GeneralFail) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(t.translate("error")),
                                    backgroundColor: Colors.red,
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
                                            .validate()) {
                                          await context
                                              .read<
                                                  GeneralCubit<LoginService,
                                                      LoginReqModel>>()
                                              .generalRequest(LoginReqModel(
                                                  number:
                                                      '+994${numberCtrl.text}',
                                                  password: passwordCtrl.text));
                                        }
                                      },
                                      child: Text(
                                        t.translate("sign_in"),
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
              if (!_isKeyboardVisible)
                InkWell(
                  onTap: () {
                    gotoSignUp(context);
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
      ),
    );
  }

  void withGoogle(BuildContext context) {}

  void withFacebook(BuildContext context) {}

  void manualSignIn(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MainPage()),
        (route) => false);
  }

  void gotoSignUp(BuildContext context) {
    //context.router.pop();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider<GeneralCubit<SignInService, SignInReqModel>>(
                  create: (context) =>
                      GeneralCubit<SignInService, SignInReqModel>(),
                ),
                BlocProvider<
                    GeneralCubit<GetUsesStatusTypeService,
                        GetUserStatusTypeReqModel>>(
                  create: (context) => GeneralCubit<GetUsesStatusTypeService,
                      GetUserStatusTypeReqModel>()
                    ..generalRequest(GetUserStatusTypeReqModel(
                        type: locator.get<GetStorage>().read('role') ==
                                'Roles.Owner'
                            ? '0'
                            : '1')),
                )
              ],
              child: RegisterHandlerPage(
                role: locator.get<GetStorage>().read('role') == 'Roles.Worker'
                    ? Roles.Worker
                    : Roles.Owner,
              ),
            )));

    // context.router.push(RegisterHandlerPageRoute(
    //     role: locator.get<GetStorage>().read('role') == 'Roles.Worker'
    //         ? Roles.Worker
    //         : Roles.Owner));
  }
}
