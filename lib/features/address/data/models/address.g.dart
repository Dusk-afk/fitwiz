// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      name: json['name'] as String,
      pincode: Pincode.fromJson(json['pincode'] as Map<String, dynamic>),
      line1: json['line_1'] as String,
      line2: json['line_2'] as String?,
      landmark: json['landmark'] as String?,
      mobile: json['mobile'] as String,
      tower: json['tower'] == null
          ? null
          : Tower.fromJson(json['tower'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'name': instance.name,
      'pincode': instance.pincode,
      'line_1': instance.line1,
      'line_2': instance.line2,
      'landmark': instance.landmark,
      'mobile': instance.mobile,
      'tower': instance.tower,
    };
