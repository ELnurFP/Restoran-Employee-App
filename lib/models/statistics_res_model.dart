

import 'package:template/models/base_res_model.dart';

class StatisticsResModel extends BaseResModel{
    StatisticsResModel({
        this.adCount,
        this.empCount,
        this.viewCount,
        this.statistics,
        this.orders,
    });

    String? adCount;
    String? empCount;
    String? viewCount;
    List<Statistic>? statistics;
    List<Order>? orders;

    factory StatisticsResModel.fromJson(Map<String, dynamic> json) => StatisticsResModel(
        adCount: json["ad_count"].toString(),
        empCount: json["emp_count"].toString(),
        viewCount: json["view_count"].toString(),
        statistics: List<Statistic>.from(json["statistics"].map((x) => Statistic.fromJson(x))),
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
    );

    // Map<String, dynamic> toJson() => {
    //     "ad_count": adCount,
    //     "emp_count": empCount,
    //     "view_count": viewCount,
    //     "statistics": List<dynamic>.from(statistics.map((x) => x.toJson())),
    //     "orders": List<dynamic>.from(orders.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
    // };
}

class Statistic {
    Statistic({
        this.empCount,
        this.views,
        this.month,
    });

    String? empCount;
    String? views;
    String? month;

    factory Statistic.fromJson(Map<String, dynamic> json) => Statistic(
        empCount: json["emp_count"].toString(),
        views: json["views"].toString(),
        month: json["month"].toString(),
    );

    Map<String, dynamic> toJson() => {
        "emp_count": empCount,
        "views": views,
        "month": month,
    };
}

class Order {
    Order({
        this.id,
        this.workerTypeName,
        this.ownerTypeName,
        this.workerType,
        this.ownerType,
        this.status,
        this.gender,
        this.workDate,
        this.isPerminent,
        this.workHours,
        this.address,
        this.description,
        this.count,
        this.attendedPeople,
        this.lat,
        this.lon,
        this.radius,
        this.views,
        this.total,
        this.orderType,
        this.createdAt,
    });

    String? id;
    String? workerTypeName;
    String? ownerTypeName;
    String? workerType;
    String? ownerType;
    String? status;
    String? gender;
    String? workDate;
    String? isPerminent;
    String? workHours;
    String? address;
    String? description;
    String? count;
    String? attendedPeople;
    String? lat;
    String? lon;
    String? radius;
    String? views;
    String? total;
    String? orderType;
    String? createdAt;

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"].toString(),
        workerTypeName: json["worker_type_name"].toString(),
        ownerTypeName: json["owner_type_name"].toString(),
        workerType: json["worker_type"].toString(),
        ownerType: json["owner_type"].toString(),
        status: json["status"].toString(),
        gender: json["gender"].toString(),
        workDate: json["work_date"].toString(),
        isPerminent: json["is_perminent"].toString(),
        workHours: json["work_hours"].toString(),
        address: json["address"].toString(),
        description: json["description"].toString(),
        count: json["count"].toString(),
        attendedPeople: json["attended_people"].toString(),
        lat: json["lat"].toString(),
        lon: json["lon"].toString(),
        radius: json["radius"].toString(),
        views: json["views"].toString(),
        total: json["total"].toString(),
        orderType: json["order_type"].toString(),
        createdAt: json["createdAt"].toString(),
    );

    // Map<String, dynamic> toJson() => {
    //     "id": id,
    //     "worker_type_name": workerTypeName,
    //     "owner_type_name": ownerTypeName,
    //     "worker_type": workerType,
    //     "owner_type": ownerType,
    //     "status": status,
    //     "gender": gender,
    //     "work_date": workDate,
    //     "is_perminent": isPerminent,
    //     "work_hours": workHours,
    //     "address": address,
    //     "description": description,
    //     "count": count,
    //     "attended_people": attendedPeople,
    //     "lat": lat,
    //     "lon": lon,
    //     "radius": radius,
    //     "views": views,
    //     "total": total,
    //     "order_type": orderType,
    //     "createdAt": createdAt.toIso8601String(),
    // };
}
