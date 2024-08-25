import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pincode.g.dart';

@JsonSerializable()
class Pincode extends Equatable {
  final int pincode;
  final String city;
  final String state;
  final String country;

  const Pincode({
    required this.pincode,
    required this.city,
    required this.state,
    required this.country,
  });

  factory Pincode.fromJson(Map<String, dynamic> json) =>
      _$PincodeFromJson(json);

  Map<String, dynamic> toJson() => _$PincodeToJson(this);

  @override
  List<Object?> get props => [pincode, city, state, country];
}
