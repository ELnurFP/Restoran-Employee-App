// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'ad_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AdEntity _$$_AdEntityFromJson(Map<String, dynamic> json) => _$_AdEntity(
      id: json['id'] as String? ?? "",
      workerType: json['worker_type'] as String? ?? "",
      ownerType: json['owner_type'] as String? ?? "",
      gender: json['gender'] as String? ?? "",
      workDate: json['work_date'] as String? ?? "",
      isPermanent: json['is_perminent'] as String? ?? "",
      workHours: json['work_hours'] as String? ?? "",
      address: json['address'] as String? ?? "",
      description: json['description'] as String? ?? "",
      count: json['count'] as String? ?? "",
      attendees: json['attended_people'] as String? ?? "",
      isVip: json['is_vip'] as String? ?? "",
      views: json['views'] as String? ?? "",
      status: json['status'] as String? ?? "",
    );

Map<String, dynamic> _$$_AdEntityToJson(_$_AdEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'worker_type': instance.workerType,
      'owner_type': instance.ownerType,
      'gender': instance.gender,
      'work_date': instance.workDate,
      'is_perminent': instance.isPermanent,
      'work_hours': instance.workHours,
      'address': instance.address,
      'description': instance.description,
      'count': instance.count,
      'attended_people': instance.attendees,
      'is_vip': instance.isVip,
      'views': instance.views,
      'status': instance.status,
    };
