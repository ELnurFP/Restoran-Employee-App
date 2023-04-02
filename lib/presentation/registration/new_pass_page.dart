import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:template/constants/constants.dart';
import 'package:template/presentation/core/capitalize_word.dart';
import 'package:template/presentation/widgets/main_buton.dart';
import '../../language/localization.dart';

class NewPassPage extends StatefulWidget {
  const NewPassPage({super.key});

  @override
  State<NewPassPage> createState() => _NewPassPageState();
}

class _NewPassPageState extends State<NewPassPage> {
  TextEditingController confirmPassController = TextEditingController();
  bool isObs1 = true;
  bool isObs2 = true;
  bool onceValidated = false;
  TextEditingController passController = TextEditingController();
  final regFormKey = GlobalKey<FormState>();

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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: Column(
            children: [
              SizedBox(height: 45.h),
              Text(
                t.translate("newPass").capitalizeWords(),
                style: FontConst.font.w500().px26().c(ColorConst.secondaryDark),
              ),
              SizedBox(height: 30.h),
              Text(
                t.translate("newPassDesc"),
                // textAlign: TextAlign.center,
                style: FontConst.font.w400().px16().c(ColorConst.lightDark),
              ),
              SizedBox(height: 30.h),
              Form(
                key: regFormKey,
                child: Column(),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return t.translate("passwordConstraint");
                  }
                  return null;
                },
                maxLength: 40,
                autovalidateMode:
                    onceValidated ? AutovalidateMode.onUserInteraction : null,
                obscureText: isObs1,
                textInputAction: TextInputAction.done,
                controller: passController,
                style: FontConst.font.px16().w500().c(ColorConst.almostBlack),
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
                autovalidateMode:
                    onceValidated ? AutovalidateMode.onUserInteraction : null,
                obscureText: isObs2,
                textInputAction: TextInputAction.done,
                controller: confirmPassController,
                style: FontConst.font.px16().w500().c(ColorConst.almostBlack),
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
              mainButton(
                context,
                () {
                  setState(() {
                    onceValidated = true;
                  });
                  if (regFormKey.currentState!.validate()) {
                    //
                  }
                },
                t.translate("save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
