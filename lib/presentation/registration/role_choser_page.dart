// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:template/constants/constants.dart';
import 'package:template/cubit/general_cubit.dart';
import 'package:template/language/localization.dart';
import 'package:template/presentation/registration/sign_in.dart';

import '../../application/core/roles.dart';
import '../../dependency_injection.dart';
import '../../infrastructure/remote/login_service.dart';
import '../../infrastructure/remote/main_screen_service.dart';
import '../../models/general_req_model.dart';
import '../../models/login_req_model.dart';
import '../guest/guest_page.dart';

class RoleChooserPage extends StatefulWidget {
  const RoleChooserPage({Key? key}) : super(key: key);

  @override
  State<RoleChooserPage> createState() => _RoleChooserPageState();
}

class _RoleChooserPageState extends State<RoleChooserPage> {
  Roles? chosenRole;

  @override
  Widget build(BuildContext context) {
    AppLocalizations t = AppLocalizations.of(context)!;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: ColorConst.secondary,
          image: DecorationImage(
            image: AssetImage(
              ImageConst.background,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //
            Text(
              t.translate('sign_up'),
              //   context.loc.sign_up,
              style: FontConst.font.px26().w500().c(
                    ColorConst.primary,
                  ),
            ),
            SizedBox(
              height: 60.h,
            ),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RoleView(
                    role: Roles.Owner,
                    isChosen: chosenRole == Roles.Owner,
                    onTap: (role) {
                      setState(() {
                        chosenRole = role;
                      });
                      goto(context);
                    },
                  ),
                  SizedBox(
                    width: 35.w,
                  ),
                  RoleView(
                    role: Roles.Worker,
                    isChosen: chosenRole == Roles.Worker,
                    onTap: (role) {
                      setState(() {
                        chosenRole = role;
                      });
                      goto(context);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RoleView(
                    role: Roles.Guest,
                    isChosen: chosenRole == Roles.Guest,
                    onTap: (role) {
                      setState(() {
                        chosenRole = role;
                      });
                      goto(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
//Roles.Worker    Roles.Owner  Roles.Guest

  void goto(BuildContext context) {
    final box = locator.get<GetStorage>();
    log(chosenRole.toString());
    box.write('role', chosenRole.toString());
    box.read('role') != 'Roles.Guest'
        ? Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                BlocProvider<GeneralCubit<LoginService, LoginReqModel>>(
                    create: (context) =>
                        GeneralCubit<LoginService, LoginReqModel>(),
                    child: const SignInPage()),
          ))
        //   context.router.push(
        //   const SignInPageRoute(),
        // )
        : Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      GeneralCubit<MainGuestScreenService, GetGuestReqModel>(),
                  child: const GuestPage(),
                )));
  }
}

class RoleView extends StatelessWidget {
  final Roles role;
  final bool isChosen;
  final Function(Roles) onTap;

  const RoleView({
    Key? key,
    required this.role,
    required this.isChosen,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations t = AppLocalizations.of(context)!;
    return InkWell(
      onTap: () {
        onTap(role);
      },
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(
                  25.r,
                ),
                margin: EdgeInsets.all(
                  5.r,
                ),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConst.primary,
                ),
                child: SvgPicture.asset(
                  role == Roles.Owner
                      ? IconConst.owner
                      : role == Roles.Worker
                          ? IconConst.worker
                          : IconConst.twoMen,
                  height: 50.w,
                  width: 50.w,
                  color: ColorConst.secondary,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                role == Roles.Owner
                    ? t.translate("owner") //context.loc.owner
                    : role == Roles.Worker
                        ? t.translate("worker") //context.loc.worker
                        : t.translate("guest"), //context.loc.guest,
                style: FontConst.font.w600().px22().c(
                      ColorConst.primary,
                    ),
              ),
            ],
          ),
          if (isChosen)
            Positioned(
              top: 0,
              right: 0,
              child: SvgPicture.asset(
                IconConst.done,
                height: 15.w,
                width: 15.w,
                color: ColorConst.primary,
              ),
            )
        ],
      ),
    );
  }
}
