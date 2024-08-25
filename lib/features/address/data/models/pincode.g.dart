// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pincode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pincode _$PincodeFromJson(Map<String, dynamic> json) => Pincode(
      pincode: (json['pincode'] as num).toInt(),
      city: json['city'] as String,
      state: json['state'] as String,
      country: json['country'] as String,
    );

Map<String, dynamic> _$PincodeToJson(Pincode instance) => <String, dynamic>{
      'pincode': instance.pincode,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
    };
