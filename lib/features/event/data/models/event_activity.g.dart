// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventActivity _$EventActivityFromJson(Map<String, dynamic> json) =>
    EventActivity(
      activityType: json['activity_type'] as String,
      dailyTargetKm: (json['daily_target_km'] as num).toDouble(),
    );

Map<String, dynamic> _$EventActivityToJson(EventActivity instance) =>
    <String, dynamic>{
      'activity_type': instance.activityType,
      'daily_target_km': instance.dailyTargetKm,
    };
