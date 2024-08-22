import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'goodie.g.dart';

@JsonSerializable()
class Goodie extends Equatable {
  final int id;
  final String name;
  final String description;
  final int? quantity;

  const Goodie({
    required this.id,
    required this.name,
    required this.description,
    required this.quantity,
  });

  factory Goodie.fromJson(Map<String, dynamic> json) => _$GoodieFromJson(json);

  Map<String, dynamic> toJson() => _$GoodieToJson(this);

  @override
  List<Object?> get props => [id, name, description, quantity];
}
