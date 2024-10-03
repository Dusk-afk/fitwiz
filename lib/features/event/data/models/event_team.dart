import 'package:equatable/equatable.dart';
import 'package:fitwiz/data/models/user_short.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_team.g.dart';

@JsonSerializable(explicitToJson: true)
class EventTeam extends Equatable {
  final int id;

  @JsonKey(name: 'event_id')
  final int eventId;

  @JsonKey(name: 'team_code')
  final String teamCode;

  final String name;

  final UserShort leader;

  final List<UserShort> members;

  const EventTeam({
    required this.id,
    required this.eventId,
    required this.teamCode,
    required this.name,
    required this.leader,
    required this.members,
  });

  factory EventTeam.fromJson(Map<String, dynamic> json) =>
      _$EventTeamFromJson(json);

  Map<String, dynamic> toJson() => _$EventTeamToJson(this);

  @override
  List<Object?> get props => [id, eventId, teamCode, name, leader, members];
}
