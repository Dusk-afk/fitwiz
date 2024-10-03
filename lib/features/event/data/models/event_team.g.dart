// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventTeam _$EventTeamFromJson(Map<String, dynamic> json) => EventTeam(
      id: (json['id'] as num).toInt(),
      eventId: (json['event_id'] as num).toInt(),
      teamCode: json['team_code'] as String,
      name: json['name'] as String,
      leader: UserShort.fromJson(json['leader'] as Map<String, dynamic>),
      members: (json['members'] as List<dynamic>)
          .map((e) => UserShort.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventTeamToJson(EventTeam instance) => <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'team_code': instance.teamCode,
      'name': instance.name,
      'leader': instance.leader.toJson(),
      'members': instance.members.map((e) => e.toJson()).toList(),
    };
