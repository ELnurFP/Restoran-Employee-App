import 'package:template/models/base_res_model.dart';

class BalanceModel extends BaseResModel{
    BalanceModel({
        this.balance,
    });

    String? balance;

    factory BalanceModel.fromJson(Map<String, dynamic> json) => BalanceModel(
        balance: json["balance"],
    );

    Map<String, dynamic> toJson() => {
        "balance": balance,
    };
}