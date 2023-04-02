// ignore_for_file: invalid_annotation_target, non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ad_entity.freezed.dart';
part 'ad_entity.g.dart';

@freezed
class AdEntity with _$AdEntity {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory AdEntity({
    //
    @Default("") @JsonKey(name: "id") String id,
    @Default("") @JsonKey(name: "worker_type") String workerType,
    @Default("") @JsonKey(name: "owner_type") String ownerType,
    @Default("") @JsonKey(name: "gender") String gender,
    @Default("") @JsonKey(name: "work_date") String workDate,
    @Default("") @JsonKey(name: "is_perminent") String isPermanent,
    @Default("") @JsonKey(name: "work_hours") String workHours,
    @Default("") @JsonKey(name: "address") String address,
    @Default("") @JsonKey(name: "description") String description,
    @Default("") @JsonKey(name: "count") String count,
    @Default("") @JsonKey(name: "attended_people") String attendees,
    @Default("") @JsonKey(name: "is_vip") String isVip,
    @Default("") @JsonKey(name: "views") String views,
    @Default("") @JsonKey(name: "status") String status,
    @Default("") @JsonKey(name: "saved") String saved,
    @Default("") @JsonKey(name: "order_type") String order_type,
  }) = _AdEntity;

  factory AdEntity.fromJson(Map<String, dynamic> json) =>
      _$AdEntityFromJson(json);
}
