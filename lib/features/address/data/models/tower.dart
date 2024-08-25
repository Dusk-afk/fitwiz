import 'package:equatable/equatable.dart';
import 'package:fitwiz/features/address/data/models/society.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tower.g.dart';

Map<String, dynamic> _societyToJson(Society society) => society.toJson();

@JsonSerializable()
class Tower extends Equatable {
  final int id;
  final String name;

  @JsonKey(toJson: _societyToJson)
  final Society society;

  const Tower({
    required this.id,
    required this.name,
    required this.society,
  });

  factory Tower.fromJson(Map<String, dynamic> json) => _$TowerFromJson(json);

  Map<String, dynamic> toJson() => _$TowerToJson(this);

  factory Tower.fromJsonSociety(Map<String, dynamic> json, Society society) {
    return Tower(
      id: json['id'],
      name: json['name'],
      society: society,
    );
  }

  @override
  List<Object?> get props => [id, name, society];
}
