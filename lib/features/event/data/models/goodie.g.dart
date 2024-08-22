// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goodie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Goodie _$GoodieFromJson(Map<String, dynamic> json) => Goodie(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      quantity: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GoodieToJson(Goodie instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'quantity': instance.quantity,
    };
