import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_activity.g.dart';

@JsonSerializable()
class EventActivity extends Equatable {
  @JsonKey(name: 'activity_type')
  final String activityType;
  @JsonKey(name: 'daily_target_km')
  final double dailyTargetKm;

  const EventActivity({
    required this.activityType,
    required this.dailyTargetKm,
  });

  factory EventActivity.fromJson(Map<String, dynamic> json) =>
      _$EventActivityFromJson(json);

  Map<String, dynamic> toJson() => _$EventActivityToJson(this);

  @override
  List<Object?> get props => [activityType, dailyTargetKm];
}
