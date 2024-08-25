import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'society.g.dart';

@JsonSerializable()
class Society extends Equatable {
  final int id;
  final String name;

  const Society({
    required this.id,
    required this.name,
  });

  factory Society.fromJson(Map<String, dynamic> json) =>
      _$SocietyFromJson(json);

  Map<String, dynamic> toJson() => _$SocietyToJson(this);

  @override
  List<Object?> get props => [id, name];
}
