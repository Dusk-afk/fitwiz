import 'package:equatable/equatable.dart';
import 'package:fitwiz/features/address/data/models/pincode.dart';
import 'package:fitwiz/features/address/data/models/tower.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address extends Equatable {
  final String name;
  final Pincode pincode;

  @JsonKey(name: 'line_1')
  final String line1;

  @JsonKey(name: 'line_2')
  final String? line2;

  final String? landmark;
  final String mobile;

  final Tower? tower;

  const Address({
    required this.name,
    required this.pincode,
    required this.line1,
    this.line2,
    this.landmark,
    required this.mobile,
    this.tower,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  factory Address.fromJsonPincodeTower(
    Map<String, dynamic> json,
    Pincode pincode,
    Tower? tower,
  ) {
    return Address(
      name: json['name'],
      pincode: pincode,
      line1: json['line_1'],
      line2: json['line_2'],
      landmark: json['landmark'],
      mobile: json['mobile'],
      tower: tower,
    );
  }

  Map<String, dynamic> toUpdateJson() => {
        'name': name,
        'pincode': pincode.pincode,
        'line_1': line1,
        'line_2': line2,
        'landmark': landmark,
        'mobile': mobile,
        'tower_id': tower?.id,
      };

  @override
  List<Object?> get props => [name, pincode, line1, line2, landmark, mobile];
}
