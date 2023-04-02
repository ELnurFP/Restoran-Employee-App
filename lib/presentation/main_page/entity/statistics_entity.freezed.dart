// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'statistics_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StatisticsEntity _$StatisticsEntityFromJson(Map<String, dynamic> json) {
  return _StatisticsEntity.fromJson(json);
}

/// @nodoc
mixin _$StatisticsEntity {
  String get adCount => throw _privateConstructorUsedError;
  String get employeeCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StatisticsEntityCopyWith<StatisticsEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatisticsEntityCopyWith<$Res> {
  factory $StatisticsEntityCopyWith(
          StatisticsEntity value, $Res Function(StatisticsEntity) then) =
      _$StatisticsEntityCopyWithImpl<$Res, StatisticsEntity>;
  @useResult
  $Res call({String adCount, String employeeCount});
}

/// @nodoc
class _$StatisticsEntityCopyWithImpl<$Res, $Val extends StatisticsEntity>
    implements $StatisticsEntityCopyWith<$Res> {
  _$StatisticsEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? adCount = null,
    Object? employeeCount = null,
  }) {
    return _then(_value.copyWith(
      adCount: null == adCount
          ? _value.adCount
          : adCount // ignore: cast_nullable_to_non_nullable
              as String,
      employeeCount: null == employeeCount
          ? _value.employeeCount
          : employeeCount // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StatisticsEntityCopyWith<$Res>
    implements $StatisticsEntityCopyWith<$Res> {
  factory _$$_StatisticsEntityCopyWith(
          _$_StatisticsEntity value, $Res Function(_$_StatisticsEntity) then) =
      __$$_StatisticsEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String adCount, String employeeCount});
}

/// @nodoc
class __$$_StatisticsEntityCopyWithImpl<$Res>
    extends _$StatisticsEntityCopyWithImpl<$Res, _$_StatisticsEntity>
    implements _$$_StatisticsEntityCopyWith<$Res> {
  __$$_StatisticsEntityCopyWithImpl(
      _$_StatisticsEntity _value, $Res Function(_$_StatisticsEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? adCount = null,
    Object? employeeCount = null,
  }) {
    return _then(_$_StatisticsEntity(
      adCount: null == adCount
          ? _value.adCount
          : adCount // ignore: cast_nullable_to_non_nullable
              as String,
      employeeCount: null == employeeCount
          ? _value.employeeCount
          : employeeCount // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$_StatisticsEntity implements _StatisticsEntity {
  const _$_StatisticsEntity({this.adCount = "", this.employeeCount = ""});

  factory _$_StatisticsEntity.fromJson(Map<String, dynamic> json) =>
      _$$_StatisticsEntityFromJson(json);

  @override
  @JsonKey()
  final String adCount;
  @override
  @JsonKey()
  final String employeeCount;

  @override
  String toString() {
    return 'StatisticsEntity(adCount: $adCount, employeeCount: $employeeCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StatisticsEntity &&
            (identical(other.adCount, adCount) || other.adCount == adCount) &&
            (identical(other.employeeCount, employeeCount) ||
                other.employeeCount == employeeCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, adCount, employeeCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StatisticsEntityCopyWith<_$_StatisticsEntity> get copyWith =>
      __$$_StatisticsEntityCopyWithImpl<_$_StatisticsEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StatisticsEntityToJson(
      this,
    );
  }
}

abstract class _StatisticsEntity implements StatisticsEntity {
  const factory _StatisticsEntity(
      {final String adCount, final String employeeCount}) = _$_StatisticsEntity;

  factory _StatisticsEntity.fromJson(Map<String, dynamic> json) =
      _$_StatisticsEntity.fromJson;

  @override
  String get adCount;
  @override
  String get employeeCount;
  @override
  @JsonKey(ignore: true)
  _$$_StatisticsEntityCopyWith<_$_StatisticsEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
