import 'package:equatable/equatable.dart';
import 'package:fitwiz/features/address/data/models/tower.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tower_short.g.dart';

@JsonSerializable()
class TowerShort extends Equatable {
  final int id;
  final String name;

  const TowerShort({
    required this.id,
    required this.name,
  });

  factory TowerShort.fromJson(Map<String, dynamic> json) =>
      _$TowerShortFromJson(json);

  Map<String, dynamic> toJson() => _$TowerShortToJson(this);

  factory TowerShort.fromTower(Tower tower) {
    return TowerShort(
      id: tower.id,
      name: tower.name,
    );
  }

  @override
  List<Object?> get props => [id, name];
}
