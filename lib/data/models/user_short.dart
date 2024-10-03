import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_short.g.dart';

@JsonSerializable()
class UserShort extends Equatable {
  final int id;
  final String name;

  const UserShort({
    required this.id,
    required this.name,
  });

  factory UserShort.fromJson(Map<String, dynamic> json) =>
      _$UserShortFromJson(json);

  Map<String, dynamic> toJson() => _$UserShortToJson(this);

  @override
  List<Object?> get props => [id, name];
}
