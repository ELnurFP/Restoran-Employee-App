// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'nofication_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NotificationEntity _$$_NotificationEntityFromJson(
        Map<String, dynamic> json) =>
    _$_NotificationEntity(
      id: json['id'] as String? ?? "",
      userId: json['user_id'] as String? ?? "",
      personId: json['person_id'] as String? ?? "0",
      orderId: json['order_id'] as String? ?? "0",
      name: json['name'] as String? ?? "",
      createdAt: json['created_at'] as String? ?? "",
      img: json['img'] as String? ?? "",
    );

Map<String, dynamic> _$$_NotificationEntityToJson(
        _$_NotificationEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'person_id': instance.personId,
      'order_id': instance.orderId,
      'name': instance.name,
      'created_at': instance.createdAt,
      'img': instance.img,
    };
