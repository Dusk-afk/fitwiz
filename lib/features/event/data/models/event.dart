import 'package:equatable/equatable.dart';
import 'package:fitwiz/features/event/data/models/event_activity.dart';
import 'package:fitwiz/features/event/data/models/event_team_type.dart';
import 'package:fitwiz/features/event/data/models/goodie.dart';
import 'package:fitwiz/features/event/data/models/session.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable()
class Event extends Equatable {
  final int id;
  final String name;
  final String description;

  @JsonKey(name: 'start_datetime')
  final DateTime startDateTime;

  @JsonKey(name: 'end_datetime')
  final DateTime endDateTime;

  final int? price;

  @JsonKey(fromJson: _activitiesFromJson, toJson: _activitiesToJson)
  final List<EventActivity> activities;

  @JsonKey(fromJson: _goodiesFromJson, toJson: _goodiesToJson)
  final List<Goodie> goodies;

  @JsonKey(fromJson: _sessionsFromJson, toJson: _sessionsToJson)
  final List<Session> sessions;

  @JsonKey(name: 'team_type')
  final EventTeamType? teamType;

  const Event({
    required this.id,
    required this.name,
    required this.description,
    required this.startDateTime,
    required this.endDateTime,
    required this.price,
    required this.activities,
    required this.goodies,
    required this.sessions,
    required this.teamType,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        startDateTime,
        endDateTime,
        activities,
        goodies,
        sessions,
      ];

  bool get isTeamEvent => teamType != null;
}

List<EventActivity> _activitiesFromJson(List<dynamic>? json) {
  if (json == null) {
    return [];
  }
  return json.map((e) => EventActivity.fromJson(e)).toList();
}

List<Map<String, dynamic>> _activitiesToJson(List<EventActivity> activities) {
  return activities.map((e) => e.toJson()).toList();
}

List<Goodie> _goodiesFromJson(List<dynamic> json) {
  return json.map((e) => Goodie.fromJson(e)).toList();
}

List<Map<String, dynamic>> _goodiesToJson(List<Goodie> goodies) {
  return goodies.map((e) => e.toJson()).toList();
}

List<Session> _sessionsFromJson(List<dynamic> json) {
  return json.map((e) => Session.fromJson(e)).toList();
}

List<Map<String, dynamic>> _sessionsToJson(List<Session> sessions) {
  return sessions.map((e) => e.toJson()).toList();
}
