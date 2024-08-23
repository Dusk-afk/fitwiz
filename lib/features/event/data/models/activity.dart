import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable()
class Activity extends Equatable {
  final int id;

  @JsonKey(name: 'activity_type')
  final String activityType;

  @JsonKey(name: 'distance_km')
  final double distanceKm;

  @JsonKey(name: 'start_datetime')
  final DateTime startDateTime;

  @JsonKey(name: 'end_datetime')
  final DateTime endDateTime;

  const Activity({
    required this.id,
    required this.activityType,
    required this.distanceKm,
    required this.startDateTime,
    required this.endDateTime,
  });

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);

  @override
  List<Object?> get props =>
      [id, activityType, distanceKm, startDateTime, endDateTime];
}
