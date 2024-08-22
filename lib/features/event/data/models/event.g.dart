// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      startDateTime: DateTime.parse(json['start_datetime'] as String),
      endDateTime: DateTime.parse(json['end_datetime'] as String),
      price: (json['price'] as num?)?.toInt(),
      activities: _activitiesFromJson(json['activities'] as List?),
      goodies: _goodiesFromJson(json['goodies'] as List),
      sessions: _sessionsFromJson(json['sessions'] as List),
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'start_datetime': instance.startDateTime.toIso8601String(),
      'end_datetime': instance.endDateTime.toIso8601String(),
      'price': instance.price,
      'activities': _activitiesToJson(instance.activities),
      'goodies': _goodiesToJson(instance.goodies),
      'sessions': _sessionsToJson(instance.sessions),
    };
