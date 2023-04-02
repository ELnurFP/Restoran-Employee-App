// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nofication_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NotificationEntity _$NotificationEntityFromJson(Map<String, dynamic> json) {
  return _NotificationEntity.fromJson(json);
}

/// @nodoc
mixin _$NotificationEntity {
  @JsonKey(name: "id")
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: "user_id")
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: "person_id")
  String get personId => throw _privateConstructorUsedError;
  @JsonKey(name: "order_id")
  String get orderId => throw _privateConstructorUsedError;
  @JsonKey(name: "name")
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: "created_at")
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: "img")
  String get img => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationEntityCopyWith<NotificationEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationEntityCopyWith<$Res> {
  factory $NotificationEntityCopyWith(
          NotificationEntity value, $Res Function(NotificationEntity) then) =
      _$NotificationEntityCopyWithImpl<$Res, NotificationEntity>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") String id,
      @JsonKey(name: "user_id") String userId,
      @JsonKey(name: "person_id") String personId,
      @JsonKey(name: "order_id") String orderId,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "created_at") String createdAt,
      @JsonKey(name: "img") String img});
}

/// @nodoc
class _$NotificationEntityCopyWithImpl<$Res, $Val extends NotificationEntity>
    implements $NotificationEntityCopyWith<$Res> {
  _$NotificationEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? personId = null,
    Object? orderId = null,
    Object? name = null,
    Object? createdAt = null,
    Object? img = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      personId: null == personId
          ? _value.personId
          : personId // ignore: cast_nullable_to_non_nullable
              as String,
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      img: null == img
          ? _value.img
          : img // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NotificationEntityCopyWith<$Res>
    implements $NotificationEntityCopyWith<$Res> {
  factory _$$_NotificationEntityCopyWith(_$_NotificationEntity value,
          $Res Function(_$_NotificationEntity) then) =
      __$$_NotificationEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") String id,
      @JsonKey(name: "user_id") String userId,
      @JsonKey(name: "person_id") String personId,
      @JsonKey(name: "order_id") String orderId,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "created_at") String createdAt,
      @JsonKey(name: "img") String img});
}

/// @nodoc
class __$$_NotificationEntityCopyWithImpl<$Res>
    extends _$NotificationEntityCopyWithImpl<$Res, _$_NotificationEntity>
    implements _$$_NotificationEntityCopyWith<$Res> {
  __$$_NotificationEntityCopyWithImpl(
      _$_NotificationEntity _value, $Res Function(_$_NotificationEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? personId = null,
    Object? orderId = null,
    Object? name = null,
    Object? createdAt = null,
    Object? img = null,
  }) {
    return _then(_$_NotificationEntity(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      personId: null == personId
          ? _value.personId
          : personId // ignore: cast_nullable_to_non_nullable
              as String,
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      img: null == img
          ? _value.img
          : img // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$_NotificationEntity implements _NotificationEntity {
  const _$_NotificationEntity(
      {@JsonKey(name: "id") this.id = "",
      @JsonKey(name: "user_id") this.userId = "",
      @JsonKey(name: "person_id") this.personId = "0",
      @JsonKey(name: "order_id") this.orderId = "0",
      @JsonKey(name: "name") this.name = "",
      @JsonKey(name: "created_at") this.createdAt = "",
      @JsonKey(name: "img") this.img = ""});

  factory _$_NotificationEntity.fromJson(Map<String, dynamic> json) =>
      _$$_NotificationEntityFromJson(json);

  @override
  @JsonKey(name: "id")
  final String id;
  @override
  @JsonKey(name: "user_id")
  final String userId;
  @override
  @JsonKey(name: "person_id")
  final String personId;
  @override
  @JsonKey(name: "order_id")
  final String orderId;
  @override
  @JsonKey(name: "name")
  final String name;
  @override
  @JsonKey(name: "created_at")
  final String createdAt;
  @override
  @JsonKey(name: "img")
  final String img;

  @override
  String toString() {
    return 'NotificationEntity(id: $id, userId: $userId, personId: $personId, orderId: $orderId, name: $name, createdAt: $createdAt, img: $img)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NotificationEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.personId, personId) ||
                other.personId == personId) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.img, img) || other.img == img));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, userId, personId, orderId, name, createdAt, img);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NotificationEntityCopyWith<_$_NotificationEntity> get copyWith =>
      __$$_NotificationEntityCopyWithImpl<_$_NotificationEntity>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NotificationEntityToJson(
      this,
    );
  }
}

abstract class _NotificationEntity implements NotificationEntity {
  const factory _NotificationEntity(
      {@JsonKey(name: "id") final String id,
      @JsonKey(name: "user_id") final String userId,
      @JsonKey(name: "person_id") final String personId,
      @JsonKey(name: "order_id") final String orderId,
      @JsonKey(name: "name") final String name,
      @JsonKey(name: "created_at") final String createdAt,
      @JsonKey(name: "img") final String img}) = _$_NotificationEntity;

  factory _NotificationEntity.fromJson(Map<String, dynamic> json) =
      _$_NotificationEntity.fromJson;

  @override
  @JsonKey(name: "id")
  String get id;
  @override
  @JsonKey(name: "user_id")
  String get userId;
  @override
  @JsonKey(name: "person_id")
  String get personId;
  @override
  @JsonKey(name: "order_id")
  String get orderId;
  @override
  @JsonKey(name: "name")
  String get name;
  @override
  @JsonKey(name: "created_at")
  String get createdAt;
  @override
  @JsonKey(name: "img")
  String get img;
  @override
  @JsonKey(ignore: true)
  _$$_NotificationEntityCopyWith<_$_NotificationEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
