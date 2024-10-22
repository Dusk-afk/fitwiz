import 'package:equatable/equatable.dart';
import 'package:fitwiz/utils/components/custom_icon.dart';
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

  String getSvgPath() {
    String name = this.name.toLowerCase().replaceAll('-', '');
    if (name.contains('trophy')) {
      return CustomIcons.trophy;
    } else if (name.contains('medal')) {
      return CustomIcons.medal;
    } else if (name.contains('tshirt')) {
      return CustomIcons.tshirt;
    } else {
      // TODO: Return a default icon like app logo or something
      throw Exception('Invalid goodie name');
    }
  }
}
