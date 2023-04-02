// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'nofication_entity.freezed.dart';
part 'nofication_entity.g.dart';

@freezed
class NotificationEntity with _$NotificationEntity {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory NotificationEntity({
    @JsonKey(name: "id") @Default("") String id,
    @JsonKey(name: "user_id") @Default("") String userId,
    @JsonKey(name: "person_id") @Default("0") String personId,
    @JsonKey(name: "order_id") @Default("0") String orderId,
    @JsonKey(name: "name") @Default("") String name,
    @JsonKey(name: "created_at") @Default("") String createdAt,
    @JsonKey(name: "img") @Default("") String img,
  }) = _NotificationEntity;

  factory NotificationEntity.fromJson(Map<String, dynamic> json) =>
      _$NotificationEntityFromJson(json);
}
