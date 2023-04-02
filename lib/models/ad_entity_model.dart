class AdEntityModel {
  final String id;
  final String gender;
  final String attendees;
  final String address;
  final String count;
  final String description;
  final String isPermanent;
  final String isVip;
  final String ownerType;
  final String views;
  final String workDate;
  final String workerType;
  final String workHours;

  AdEntityModel(
      this.id,
      this.gender,
      this.attendees,
      this.address,
      this.count,
      this.description,
      this.isPermanent,
      this.isVip,
      this.ownerType,
      this.views,
      this.workDate,
      this.workerType,
      this.workHours);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'attendees': attendees,
      'count': count,
      'description': description,
      'isPermanent': isPermanent,
      'isVip': isVip,
      'ownerType': ownerType,
      'views': views,
      'workDate': workDate,
      'workerType': workerType,
      'workHours': workHours,
      'gender': gender,
      'address': address,
    };
  }
}
