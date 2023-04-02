// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'statistics_entity.freezed.dart';
part 'statistics_entity.g.dart';

@freezed
class StatisticsEntity with _$StatisticsEntity {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory StatisticsEntity({
    @Default("") String adCount,
    @Default("") String employeeCount,
  }) = _StatisticsEntity;

  factory StatisticsEntity.fromJson(Map<String, dynamic> json) =>
      _$StatisticsEntityFromJson(json);
}
