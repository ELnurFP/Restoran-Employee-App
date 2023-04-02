import 'package:flutter/material.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:template/constants/constants.dart";
import "package:template/language/localization.dart";

class MoneyTransactionCard extends StatelessWidget {
  const MoneyTransactionCard({
    Key? key,
    required this.t,
    required this.id,
    required this.amount,
    required this.isIncrease,
    required this.isSucces,
    this.place,
  }) : super(key: key);

  final double amount;
  final int id;
  final bool isIncrease;
  final bool isSucces;
  final String? place;
  final AppLocalizations t;

  @override
  Widget build(BuildContext context) {
    String amountString =
        amount.toStringAsFixed(amount.truncateToDouble() == amount ? 0 : 2);
    if (isIncrease == false) {
      amountString = "-$amountString";
    }
    return SizedBox(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "ID",
                style: FontConst.font.w500().px14().copyWith(
                      color: const Color(0xff99DB71),
                    ),
              ),
              SizedBox(width: 8.w),
              Text(
                "#$id",
                style: FontConst.font.w500().px14().copyWith(
                      color: ColorConst.dark,
                    ),
              ),
              const Spacer(),
              Flexible(
                child: Text(
                  isSucces == false
                      ? t.translate("failed")
                      : isIncrease
                          ? t.translate("successfullyPaid")
                          : t.translate("withdrawn"),
                  style: FontConst.font.w500().px14().copyWith(
                        color: isSucces == false
                            ? const Color(0xffFF0505)
                            : isIncrease
                                ? ColorConst.idColor
                                : const Color(0xffFF0505),
                      ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Text(
                place ?? '',
                style: FontConst.font.w500().px14().copyWith(
                      color: const Color(0xff7D7D7D),
                    ),
              ),
              const Spacer(),
              isIncrease
                  ? Icon(
                      Icons.credit_card,
                      size: 20.h,
                      color: const Color(0xff707070),
                    )
                  : const SizedBox(),
              SizedBox(width: 8.w),
              Text(
                "$amountString AZN",
                style: FontConst.font.w600().px16().copyWith(
                      color: isSucces == false
                          ? const Color(0xffFF0505)
                          : isIncrease
                              ? ColorConst.idColor
                              : const Color(0xffFF0505),
                    ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(
            color: ColorConst.dviderColor,
            thickness: 1.h,
            height: 0,
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
