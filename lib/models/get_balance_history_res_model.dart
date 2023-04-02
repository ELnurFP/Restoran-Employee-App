import 'base_res_model.dart';

class GetBalanceHistoryResModel extends BaseResModel{
    GetBalanceHistoryResModel({
        required this.history,
    });

    List<History> history;

    factory GetBalanceHistoryResModel.fromJson(Map<String, dynamic> json) => GetBalanceHistoryResModel(
        history: List<History>.from(json["history"].map((x) => History.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "history": List<dynamic>.from(history.map((x) => x.toJson())),
    };
}

class History {
    History({
        required this.id,
        required this.orderId,
        required this.amount,
        required this.paymentStatus,
        required this.createdAt,
        required this.place,
        required this.premiumId,
        required this.type,
    });

    String id;
    String orderId;
    String amount;
    String paymentStatus;
    DateTime createdAt;
    String place;
    String premiumId;
    String type;

    factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        orderId: json["order_id"],
        amount: json["amount"],
        paymentStatus: json["payment_status"],
        createdAt: DateTime.parse(json["createdAt"]),
        place: json["place"],
        premiumId: json["premium_id"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "amount": amount,
        "payment_status": paymentStatus,
        "createdAt": createdAt.toIso8601String(),
        "place": place,
        "premium_id": premiumId,
        "type": type,
    };
}
