// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyEvent _$MyEventFromJson(Map<String, dynamic> json) => MyEvent(
      event: Event.fromJson(json['event'] as Map<String, dynamic>),
      activities: (json['activities'] as List<dynamic>)
          .map((e) => Activity.fromJson(e as Map<String, dynamic>))
          .toList(),
      ticket: Ticket.fromJson(json['ticket'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MyEventToJson(MyEvent instance) => <String, dynamic>{
      'event': instance.event,
      'activities': instance.activities,
      'ticket': instance.ticket,
    };
