import 'package:equatable/equatable.dart';
import 'package:fitwiz/features/event/data/models/goodie.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session.g.dart';

@JsonSerializable()
class Session extends Equatable {
  final int id;
  final String name;
  final String description;

  @JsonKey(name: 'start_datetime')
  final DateTime startDateTime;

  @JsonKey(name: 'end_datetime')
  final DateTime endDateTime;

  @JsonKey(fromJson: _goodiesFromJson, toJson: _goodiesToJson)
  final List<Goodie> goodies;

  const Session({
    required this.id,
    required this.name,
    required this.description,
    required this.startDateTime,
    required this.endDateTime,
    required this.goodies,
  });

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);

  @override
  List<Object?> get props =>
      [id, name, description, startDateTime, endDateTime, goodies];
}

List<Goodie> _goodiesFromJson(List<dynamic>? json) {
  if (json == null) {
    return [];
  }
  return json.map((e) => Goodie.fromJson(e)).toList();
}

List<Map<String, dynamic>> _goodiesToJson(List<Goodie> goodies) {
  return goodies.map((e) => e.toJson()).toList();
}
