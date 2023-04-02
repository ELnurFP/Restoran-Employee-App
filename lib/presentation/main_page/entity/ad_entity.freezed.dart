// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ad_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AdEntity _$AdEntityFromJson(Map<String, dynamic> json) {
  return _AdEntity.fromJson(json);
}

/// @nodoc
mixin _$AdEntity {
//
  @JsonKey(name: "id")
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: "worker_type")
  String get workerType => throw _privateConstructorUsedError;
  @JsonKey(name: "owner_type")
  String get ownerType => throw _privateConstructorUsedError;
  @JsonKey(name: "gender")
  String get gender => throw _privateConstructorUsedError;
  @JsonKey(name: "work_date")
  String get workDate => throw _privateConstructorUsedError;
  @JsonKey(name: "is_perminent")
  String get isPermanent => throw _privateConstructorUsedError;
  @JsonKey(name: "work_hours")
  String get workHours => throw _privateConstructorUsedError;
  @JsonKey(name: "address")
  String get address => throw _privateConstructorUsedError;
  @JsonKey(name: "description")
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: "count")
  String get count => throw _privateConstructorUsedError;
  @JsonKey(name: "attended_people")
  String get attendees => throw _privateConstructorUsedError;
  @JsonKey(name: "is_vip")
  String get isVip => throw _privateConstructorUsedError;
  @JsonKey(name: "views")
  String get views => throw _privateConstructorUsedError;
  @JsonKey(name: "status")
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: "saved")
  String get saved => throw _privateConstructorUsedError;
  @JsonKey(name: "order_type")
  String get order_type => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AdEntityCopyWith<AdEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdEntityCopyWith<$Res> {
  factory $AdEntityCopyWith(AdEntity value, $Res Function(AdEntity) then) =
      _$AdEntityCopyWithImpl<$Res, AdEntity>;
  @useResult
  $Res call({
    @JsonKey(name: "id") String id,
    @JsonKey(name: "worker_type") String workerType,
    @JsonKey(name: "owner_type") String ownerType,
    @JsonKey(name: "gender") String gender,
    @JsonKey(name: "work_date") String workDate,
    @JsonKey(name: "is_perminent") String isPermanent,
    @JsonKey(name: "work_hours") String workHours,
    @JsonKey(name: "address") String address,
    @JsonKey(name: "description") String description,
    @JsonKey(name: "count") String count,
    @JsonKey(name: "attended_people") String attendees,
    @JsonKey(name: "is_vip") String isVip,
    @JsonKey(name: "views") String views,
    @JsonKey(name: "status") String status,
    @JsonKey(name: "saved") String saved,
    @JsonKey(name: "order_type") String order_type,
  });
}

/// @nodoc
class _$AdEntityCopyWithImpl<$Res, $Val extends AdEntity>
    implements $AdEntityCopyWith<$Res> {
  _$AdEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? workerType = null,
    Object? ownerType = null,
    Object? gender = null,
    Object? workDate = null,
    Object? isPermanent = null,
    Object? workHours = null,
    Object? address = null,
    Object? description = null,
    Object? count = null,
    Object? attendees = null,
    Object? isVip = null,
    Object? views = null,
    Object? status = null,
    Object? saved = null,
    Object? order_type = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      workerType: null == workerType
          ? _value.workerType
          : workerType // ignore: cast_nullable_to_non_nullable
              as String,
      ownerType: null == ownerType
          ? _value.ownerType
          : ownerType // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      workDate: null == workDate
          ? _value.workDate
          : workDate // ignore: cast_nullable_to_non_nullable
              as String,
      isPermanent: null == isPermanent
          ? _value.isPermanent
          : isPermanent // ignore: cast_nullable_to_non_nullable
              as String,
      workHours: null == workHours
          ? _value.workHours
          : workHours // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as String,
      attendees: null == attendees
          ? _value.attendees
          : attendees // ignore: cast_nullable_to_non_nullable
              as String,
      isVip: null == isVip
          ? _value.isVip
          : isVip // ignore: cast_nullable_to_non_nullable
              as String,
      views: null == views
          ? _value.views
          : views // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      saved: null == saved
          ? _value.saved
          : saved // ignore: cast_nullable_to_non_nullable
              as String,
      order_type: null == order_type
          ? _value.order_type
          : order_type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AdEntityCopyWith<$Res> implements $AdEntityCopyWith<$Res> {
  factory _$$_AdEntityCopyWith(
          _$_AdEntity value, $Res Function(_$_AdEntity) then) =
      __$$_AdEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") String id,
      @JsonKey(name: "worker_type") String workerType,
      @JsonKey(name: "owner_type") String ownerType,
      @JsonKey(name: "gender") String gender,
      @JsonKey(name: "work_date") String workDate,
      @JsonKey(name: "is_perminent") String isPermanent,
      @JsonKey(name: "work_hours") String workHours,
      @JsonKey(name: "address") String address,
      @JsonKey(name: "description") String description,
      @JsonKey(name: "count") String count,
      @JsonKey(name: "attended_people") String attendees,
      @JsonKey(name: "is_vip") String isVip,
      @JsonKey(name: "views") String views,
      @JsonKey(name: "status") String status,
      @JsonKey(name: "saved") String saved,
      @JsonKey(name: "order_type") String order_type});
}

/// @nodoc
class __$$_AdEntityCopyWithImpl<$Res>
    extends _$AdEntityCopyWithImpl<$Res, _$_AdEntity>
    implements _$$_AdEntityCopyWith<$Res> {
  __$$_AdEntityCopyWithImpl(
      _$_AdEntity _value, $Res Function(_$_AdEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? workerType = null,
    Object? ownerType = null,
    Object? gender = null,
    Object? workDate = null,
    Object? isPermanent = null,
    Object? workHours = null,
    Object? address = null,
    Object? description = null,
    Object? count = null,
    Object? attendees = null,
    Object? isVip = null,
    Object? views = null,
    Object? status = null,
    Object? saved = null,
    Object? order_type = null,
  }) {
    return _then(_$_AdEntity(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      workerType: null == workerType
          ? _value.workerType
          : workerType // ignore: cast_nullable_to_non_nullable
              as String,
      ownerType: null == ownerType
          ? _value.ownerType
          : ownerType // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      workDate: null == workDate
          ? _value.workDate
          : workDate // ignore: cast_nullable_to_non_nullable
              as String,
      isPermanent: null == isPermanent
          ? _value.isPermanent
          : isPermanent // ignore: cast_nullable_to_non_nullable
              as String,
      workHours: null == workHours
          ? _value.workHours
          : workHours // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as String,
      attendees: null == attendees
          ? _value.attendees
          : attendees // ignore: cast_nullable_to_non_nullable
              as String,
      isVip: null == isVip
          ? _value.isVip
          : isVip // ignore: cast_nullable_to_non_nullable
              as String,
      views: null == views
          ? _value.views
          : views // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      saved: null == saved
          ? _value.saved
          : saved // ignore: cast_nullable_to_non_nullable
              as String,
      order_type: null == order_type
          ? _value.order_type
          : order_type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$_AdEntity implements _AdEntity {
  const _$_AdEntity({
    @JsonKey(name: "id") this.id = "",
    @JsonKey(name: "worker_type") this.workerType = "",
    @JsonKey(name: "owner_type") this.ownerType = "",
    @JsonKey(name: "gender") this.gender = "",
    @JsonKey(name: "work_date") this.workDate = "",
    @JsonKey(name: "is_perminent") this.isPermanent = "",
    @JsonKey(name: "work_hours") this.workHours = "",
    @JsonKey(name: "address") this.address = "",
    @JsonKey(name: "description") this.description = "",
    @JsonKey(name: "count") this.count = "",
    @JsonKey(name: "attended_people") this.attendees = "",
    @JsonKey(name: "is_vip") this.isVip = "",
    @JsonKey(name: "views") this.views = "",
    @JsonKey(name: "status") this.status = "",
    @JsonKey(name: "saved") this.saved = "",
    @JsonKey(name: "order_type") this.order_type = "",
  });

  factory _$_AdEntity.fromJson(Map<String, dynamic> json) =>
      _$$_AdEntityFromJson(json);

//
  @override
  @JsonKey(name: "id")
  final String id;
  @override
  @JsonKey(name: "worker_type")
  final String workerType;
  @override
  @JsonKey(name: "owner_type")
  final String ownerType;
  @override
  @JsonKey(name: "gender")
  final String gender;
  @override
  @JsonKey(name: "work_date")
  final String workDate;
  @override
  @JsonKey(name: "is_perminent")
  final String isPermanent;
  @override
  @JsonKey(name: "work_hours")
  final String workHours;
  @override
  @JsonKey(name: "address")
  final String address;
  @override
  @JsonKey(name: "description")
  final String description;
  @override
  @JsonKey(name: "count")
  final String count;
  @override
  @JsonKey(name: "attended_people")
  final String attendees;
  @override
  @JsonKey(name: "is_vip")
  final String isVip;
  @override
  @JsonKey(name: "views")
  final String views;
  @override
  @JsonKey(name: "status")
  final String status;
  @override
  @JsonKey(name: "saved")
  final String saved;
  @JsonKey(name: "order_type")
  final String order_type;
  @override
  String toString() {
    return 'AdEntity(id: $id, workerType: $workerType, ownerType: $ownerType, gender: $gender, workDate: $workDate, isPermanent: $isPermanent, workHours: $workHours, address: $address, description: $description, count: $count, attendees: $attendees, isVip: $isVip, views: $views, status: $status, saved: $saved, order_type: $order_type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AdEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.workerType, workerType) ||
                other.workerType == workerType) &&
            (identical(other.ownerType, ownerType) ||
                other.ownerType == ownerType) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.workDate, workDate) ||
                other.workDate == workDate) &&
            (identical(other.isPermanent, isPermanent) ||
                other.isPermanent == isPermanent) &&
            (identical(other.workHours, workHours) ||
                other.workHours == workHours) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.attendees, attendees) ||
                other.attendees == attendees) &&
            (identical(other.isVip, isVip) || other.isVip == isVip) &&
            (identical(other.views, views) || other.views == views) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.saved, saved) || other.saved == saved) &&
            (identical(other.order_type, order_type) ||
                other.order_type == order_type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      workerType,
      ownerType,
      gender,
      workDate,
      isPermanent,
      workHours,
      address,
      description,
      count,
      attendees,
      isVip,
      views,
      status.codeUnits,
      saved,
      order_type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AdEntityCopyWith<_$_AdEntity> get copyWith =>
      __$$_AdEntityCopyWithImpl<_$_AdEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AdEntityToJson(
      this,
    );
  }
}

abstract class _AdEntity implements AdEntity {
  const factory _AdEntity(
      {@JsonKey(name: "id") final String id,
      @JsonKey(name: "worker_type") final String workerType,
      @JsonKey(name: "owner_type") final String ownerType,
      @JsonKey(name: "gender") final String gender,
      @JsonKey(name: "work_date") final String workDate,
      @JsonKey(name: "is_perminent") final String isPermanent,
      @JsonKey(name: "work_hours") final String workHours,
      @JsonKey(name: "address") final String address,
      @JsonKey(name: "description") final String description,
      @JsonKey(name: "count") final String count,
      @JsonKey(name: "attended_people") final String attendees,
      @JsonKey(name: "is_vip") final String isVip,
      @JsonKey(name: "views") final String views,
      @JsonKey(name: "status") final String status,
      @JsonKey(name: "saved") final String saved,
      @JsonKey(name: "order_type") final String order_type}) = _$_AdEntity;

  factory _AdEntity.fromJson(Map<String, dynamic> json) = _$_AdEntity.fromJson;

  @override //
  @JsonKey(name: "id")
  String get id;
  @override
  @JsonKey(name: "worker_type")
  String get workerType;
  @override
  @JsonKey(name: "owner_type")
  String get ownerType;
  @override
  @JsonKey(name: "gender")
  String get gender;
  @override
  @JsonKey(name: "work_date")
  String get workDate;
  @override
  @JsonKey(name: "is_perminent")
  String get isPermanent;
  @override
  @JsonKey(name: "work_hours")
  String get workHours;
  @override
  @JsonKey(name: "address")
  String get address;
  @override
  @JsonKey(name: "description")
  String get description;
  @override
  @JsonKey(name: "count")
  String get count;
  @override
  @JsonKey(name: "attended_people")
  String get attendees;
  @override
  @JsonKey(name: "is_vip")
  String get isVip;
  @override
  @JsonKey(name: "views")
  String get views;
  @override
  @JsonKey(name: "status")
  String get status;
  @override
  @JsonKey(name: "saved")
  String get saved;
  @override
  @JsonKey(name: "order_type")
  String get order_type;
  @override
  @JsonKey(ignore: true)
  _$$_AdEntityCopyWith<_$_AdEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
